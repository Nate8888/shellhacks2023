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

if __name__ == '__main__':
    app.run(host='127.0.0.1', port=8080, debug=True)