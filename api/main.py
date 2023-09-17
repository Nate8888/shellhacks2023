import time
import os
import math
import string
import random
import json
import requests as rq
from flask import Flask, jsonify, request
from flask_cors import CORS, cross_origin
from google.cloud import storage
from io import BytesIO
import io
import dotenv
dotenv.load_dotenv()
import openai


processed_dataset_URL = "https://storage.googleapis.com/shellhacksbucket/sorted_w_c-esg.json"
comp_data_URL = "https://storage.googleapis.com/shellhacksbucket/data.json"

app = Flask(__name__)

cors = CORS(app)
app.config['CORS_HEADERS'] = 'Content-Type'
storage_client = storage.Client()
openai.api_key = os.getenv('OPEN_API_KEY')

def get_ele_voices():
    url = "https://api.elevenlabs.io/v1/voices"

    headers = {
        "Accept": "application/json",
        "xi-api-key": os.getenv('ELEVEN_LABS_KEY_TWO')
    }

    response = rq.get(url, headers=headers)

    print(response.text)

def random_string(length=8):
    letters = string.ascii_lowercase + string.digits + string.ascii_uppercase
    return ''.join(random.choice(letters) for i in range(length))

def get_comp_data():
    response = rq.get(comp_data_URL)
    return response.json()

# We can update the dataset straight to Cloud Storage and then just get it from there
# The idea is to have a Cron job since it takes time.
def get_esg_news_from_gcs():
    bucket_name = "shellhacksbucket"
    prefix = "sorted_w_c-esg.json"
    delimiter = "/"

    blobs = storage_client.list_blobs(
        bucket_name, prefix=prefix, delimiter=delimiter
    )

    for blob in blobs:
        print(blob.name)
        if blob.name == prefix:
            blob = blob.download_as_string()
            blob = blob.decode('utf-8')
            blob = json.loads(blob)
            print(blob)
            return blob

def question_esg_news(news_summary):
    system_prompt = 'You are a system that is evaluating the ESG impact of articles that I pass you. You are to give a score from 0-10 and then explain briefly what the "E", "S", and "G" aspect focus on. Reply in JSON format like as following:"{score:8.5, "esg":["E:", "S:","G:"]}"'
    messages = [{"role": "system", "content": system_prompt}]
    messages.append({"role": "user", "content": news_summary})

    response = openai.ChatCompletion.create(
        model="gpt-4",
        messages=messages
    )
    print(response)
    return response.choices[0].message['content']

def save_audio_to_gcs(bucket_name, destination_blob_name, stream):
    bucket = storage_client.bucket(bucket_name)
    blob = bucket.blob(destination_blob_name)
    blob.upload_from_file(stream)
    print("The Public URL: " + blob.public_url)
    return blob.public_url

def generate_audio(msg):
    CHUNK_SIZE = 1024
    url = "https://api.elevenlabs.io/v1/text-to-speech/ThT5KcBeYPX3keUQqHPh"

    headers = {
      "Accept": "audio/mpeg",
      "Content-Type": "application/json",
      "xi-api-key": os.getenv('ELEVEN_LABS_KEY_TWO')
    }

    data = {
      "text": msg,
      "model_id": "eleven_monolingual_v1",
      "voice_settings": {
        "stability": 0.66,
        "similarity_boost": 0.72,
      }
    }

    response = rq.post(url, json=data, headers=headers)

    # Using 'BytesIO' object to hold the audio content.
    audio_content = BytesIO()
    
    for chunk in response.iter_content(chunk_size=CHUNK_SIZE):
        if chunk:
            audio_content.write(chunk)

    audio_content.seek(0)
    return save_audio_to_gcs('shellhacksbucket', random_string()+'.mp3', audio_content)

def query_whiper(audio_file):
    url = "https://api.openai.com/v1/audio/transcriptions"

    payload={'model': 'whisper-1'}
    files=[
        ('file',
            (audio_file.filename, audio_file, 'audio/mpeg')
        )
    ]
    headers = {
    'Authorization': 'Bearer ' + os.getenv('OPEN_API_KEY')
    }
    response = rq.request("POST", url, headers=headers, data=payload, files=files)
    print(response.json())
    return response.json()

def gpt_educates(conversation_history, new_prompt):
    system_setup = "You are an AI system designed to help the user with financial literacy content with a focus on sustainability. If the user asks things outside of the finance scope, explain to the user politely your purpose. Keep it less than a paragraph"
    messages = [{"role": "system", "content": system_setup}]

    for i in range(len(conversation_history)):
        if i%2 == 0:  
            message_type = "user"
        else:  
            message_type = "assistant"
            
        messages.append({"role": message_type, "content": conversation_history[i]})
    
    messages.append({"role": "user", "content": new_prompt})
    
    response = openai.ChatCompletion.create(
        model="gpt-3.5-turbo",
        messages=messages
    )
    print(response)
    return response.choices[0].message['content']

@app.route('/articles', methods=['GET'])
@cross_origin()
def get_news_feed():
    comp_sector_map = {}
    companies = get_comp_data()
    final_data = get_esg_news_from_gcs().get("news")
    for company in companies:
        comp_sector_map[company['Symbol']] = company['Sector']
    
    for article in final_data:
        if article.get('ticker') and article['ticker'] in comp_sector_map:
            article['sector'] = comp_sector_map[article['ticker']]
        else:
            article['sector'] = 'N/A'

    return jsonify(final_data)

@app.route('/voices', methods=['GET'])
@cross_origin()
def get_voices():
    return jsonify(get_ele_voices())

# Route to return the stonks
@app.route('/stocks', methods=['GET'])
@cross_origin()
def get_stocks():
    # Stocks returned will be from the SP500.
    # Go through each 
    all_cps = get_comp_data()

    map_cps = {}
    all_articles = get_esg_news_from_gcs().get("news")
    for article in all_articles:
        if article.get('ticker') and article['ticker'] not in map_cps:
            map_cps[article['ticker']] = article['esg_company_score']
    
    for cp in all_cps:
        if cp['Symbol'] in map_cps:
            cp['score'] = map_cps[cp['Symbol']]
        else:
            cp['score'] = 0
    
    # sort by score descending [{}]
    all_cps = sorted(all_cps, key=lambda x: x['score'], reverse=True)
    return jsonify(all_cps)

# get news by company
@app.route('/company/<company_ticker>', methods=['GET'])
@cross_origin()
def get_news_by_company(company_ticker):
    all_articles = get_esg_news_from_gcs().get("news")
    company_articles = []
    for article in all_articles:
        if article.get('ticker') and type(article) == dict and article['ticker'] == company_ticker:
            company_articles.append(article)
    return jsonify(company_articles)

@app.route('/talk', methods=['POST'])
@cross_origin()
def process_audio_whisper():
    if 'audio' not in request.files:
        return 'No audio file in request', 400

    # Get the audio file
    audio_file = request.files['audio']
    conversations = request.form.get('conversations', [])

    whisper_response = query_whiper(audio_file)
    user_input = whisper_response.get('text')
    
    # Send it to GPT-4 conversational model
    response = gpt_educates(conversations, user_input)
    audio_file.seek(0)
    
    # upload the 'audio_file' to gcs
    user_input_link = save_audio_to_gcs('shellhacksbucket', random_string()+'.mp3', audio_file)

    # now with reponse build a new audio with elevenlabs
    ai_output_link = generate_audio(response)
    completed_return = {
        'user_input': user_input_link,
        'user_text': user_input,
        'ai_output': ai_output_link,
        'ai_text': response
    }
    print(completed_return)
    return jsonify(completed_return)

if __name__ == '__main__':
    app.run(host='127.0.0.1', port=8080, debug=True)