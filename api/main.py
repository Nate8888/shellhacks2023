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

app = Flask(__name__)

cors = CORS(app)
app.config['CORS_HEADERS'] = 'Content-Type'
storage_client = storage.Client()
openai.api_key = os.getenv('OPEN_API_KEY')

def random_string(length=8):
    letters = string.ascii_lowercase + string.digits + string.ascii_uppercase
    return ''.join(random.choice(letters) for i in range(length))


def save_audio_to_gcs(bucket_name, destination_blob_name, stream):
    bucket = storage_client.bucket(bucket_name)
    blob = bucket.blob(destination_blob_name)
    blob.upload_from_file(stream)
    print("The Public URL: " + blob.public_url)
    return blob.public_url

def generate_audio(msg):
    CHUNK_SIZE = 1024
    url = "https://api.elevenlabs.io/v1/text-to-speech/pNInz6obpgDQGcFmaJgB"

    headers = {
      "Accept": "audio/mpeg",
      "Content-Type": "application/json",
      "xi-api-key": os.getenv('ELEVEN_LABS_KEY')
    }

    data = {
      "text": msg,
      "model_id": "eleven_monolingual_v1",
      "voice_settings": {
        "stability": 0.5,
        "similarity_boost": 0.5
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
    system_setup = "You are an AI system designed to help the user with financial literacy content with a focus on sustainability. If the user asks things outside of the finance scope, explain to the user politely your purpose."
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

@app.route('/ok', methods=['POST','GET'])
@cross_origin()
def hello_world_api():
    conversation_history = ["Hello! Who are you?", "I'm an AI assistant created to help you with financial literacy content."]
    new_prompt = "What should I be looking at while investing in ESG stocks?"
    print(gpt_educates(conversation_history, new_prompt))
    return jsonify({"data": "Hello World"})

@app.route('/articles', methods=['GET'])
@cross_origin()
def get_news_feed():
    data = {
        'news':[ # Article
        {
            'headline': 'Apple to invest $1 billion in North Carolina campus, create at least 3,000 jobs',
            'source': 'CNBC',
            'url': 'https://www.cnbc.com/technology/',
            'score': 7.8,
            'esg_points': [
                'Apple is investing $1 billion in North Carolina as part of a plan to establish a new campus and engineering hub in the Research Triangle area.',
                'The company said it will create at least 3,000 new jobs in machine learning, artificial intelligence, software engineering and other fields.',
                'Apple will also establish a $100 million fund to support schools and community initiatives in the greater Raleigh-Durham area and across the state.'
            ]
        },
    ]
    }
    return jsonify(data)

# Route to return the stonks
@app.route('/stocks', methods=['GET'])
@cross_origin()
def get_stocks():
    # Stocks returned will be from the SP500.
    stock_data = {
        'stocks':[
        {
            'fullname': 'Apple',
            'ticker': 'AAPL',
            'price': 127.45,
            'score': 7.8,
            'esg_points': [
                'Apple is investing $1 billion in North Carolina as part of a plan to establish a new campus and engineering hub in the Research Triangle area.',
                'The company said it will create at least 3,000 new jobs in machine learning, artificial intelligence, software engineering and other fields.',
                'Apple will also establish a $100 million fund to support schools and community initiatives in the greater Raleigh-Durham area and across the state.'
            ]
        },
    ]}
    return jsonify(stock_data)

# Future, Return audio link to user, ai-voice, ai text output.
@app.route('/audio', methods=['POST'])
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
    user_input_link = save_audio_to_gcs('shellhacksbucket', 'testing.mp3', audio_file)

    # now with reponse build a new audio with elevenlabs
    ai_output_link = generate_audio(response)
    completed_return = {
        'user_input': user_input_link,
        'ai_output': ai_output_link,
        'ai_text': response
    }
    return jsonify(completed_return)

if __name__ == '__main__':
    app.run(host='127.0.0.1', port=8080, debug=True)