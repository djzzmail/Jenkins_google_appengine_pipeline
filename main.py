from flask import Flask, request


def create_app():
   return app

app = Flask(__name__)



@app.route('/')
def index():
    ret="""build din azure dev rbc:<br>

     """

    return ret



if __name__ == '__main__':
#    app.run(host='0.0.0.0', port= 8181)
    app.run()

