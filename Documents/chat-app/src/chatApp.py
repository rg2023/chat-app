from flask import Flask, render_template, redirect, session, request
from datetime import datetime
import user_manager
import room_manager
import chat_manager

app = Flask(__name__)
app.secret_key = "123"

@app.route('/', methods=['GET', 'POST'])
def home_page():
    return user_manager.process_registration()

@app.route('/register', methods=['GET', 'POST'])
def register():
    return user_manager.process_registration()

@app.route('/login', methods=['GET', 'POST'])
def login():
    return user_manager.process_login()

@app.route('/lobby', methods=['GET', 'POST'])
def lobby():
    return room_manager.process_lobby()

@app.route('/logout', methods=['GET'])
def logout():
    return user_manager.logout()

@app.route('/chat/<room_id>', methods=['GET', 'POST'])
def chat(room_id):
    return render_template('chat.html', room=room_id)


@app.route("/health")
def health():
    return "OK",200


@app.route('/api/chat/clear/<room>', methods=['POST'])
def clear(room):
    return chat_manager.clear_messages(room)
    

@app.route('/api/chat/<room_id>', methods=['GET', 'POST'])
def update_chat(room_id):
    if request.method == "POST":
        message = request.form['msg']
        chat_manager.append_message(room_id, message)

    messages = chat_manager.get_all_messages(room_id)
    return messages


if __name__ == '__main__':
    app.run(host="0.0.0.0", debug=True)
