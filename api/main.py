import time
import os
import math
import string
import random
import json
import requests as rq
from flask import Flask, jsonify
from flask_cors import CORS, cross_origin

app = Flask(__name__)

cors = CORS(app)
app.config['CORS_HEADERS'] = 'Content-Type'

@app.route('/ok', methods=['POST','GET'])
@cross_origin()
def hello_world_api():
    return jsonify({"data": "Hello World"})

@app.route('/news', methods=['GET'])
@cross_origin()
def get_news_feed():
    data = {'news':[
        {
            'headline': 'Apple to invest $1 billion in North Carolina campus, create at least 3,000 jobs',
            'source': 'CNBC',
            'url': 'https://www.cnbc.com/technology/',
            'esg_score': 0.8,
            'esg_points': [
                'Apple is investing $1 billion in North Carolina as part of a plan to establish a new campus and engineering hub in the Research Triangle area.',
                'The company said it will create at least 3,000 new jobs in machine learning, artificial intelligence, software engineering and other fields.',
                'Apple will also establish a $100 million fund to support schools and community initiatives in the greater Raleigh-Durham area and across the state.'
            ]
        },
    ]
    }
    return jsonify(data)

if __name__ == '__main__':
    app.run(host='127.0.0.1', port=8080, debug=True)