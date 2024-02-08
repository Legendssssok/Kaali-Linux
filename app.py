from flask import Flask, render_template, request
from pyngrok import ngrok

app = Flask(__name__)

# Start ngrok when the Flask app starts
ngrok_url = ngrok.connect(5000)
print(" * Running on", ngrok_url)

@app.route('/')
def index():
    return render_template('index.html', ngrok_url=ngrok_url)

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
