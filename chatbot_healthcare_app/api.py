import falcon
from flask import Flask, request, jsonify

# while True:
#     query = input("ask question")
#     result = falcon.chatbot(query)
#     print(result)
app = Flask(__name__)

@app.route('/api', methods = ['GET'])
def hello_world():
    d = {}
    inputchr= str(request.args['query'])
    answer = falcon.chatbot(inputchr)
    d['output'] = answer
    print(answer)
    return d

if __name__ == '__main__':
    app.run()

