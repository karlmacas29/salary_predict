from flask import Flask, jsonify, request
from flask_cors import CORS
import numpy as np
import joblib

app = Flask(__name__)
CORS(app)

model = joblib.load('macasmodel.pkl')

@app.route('/salary',methods=['POST'])
def predict_val():
   experience = request.form['experience']
   user_input = np.array([[float(experience)]])
   predicted_salary = model.predict(user_input)
   r = request.form.get('experience')
   list = {'year': r, 'prdValue' : predicted_salary[0]}
   response = jsonify(list)
   response.headers.add('Access-Control-Allow-Origin', '*')
   return response

@app.route('/')
def route():
   return "Runing"

if __name__ == '__main__':
   app.run()