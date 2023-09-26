from flask import render_template, request
import os

room_names = []
my_path = os.environ.get('path')

def process_lobby():
    if request.method == 'POST':
        room_name = request.form['new_room']
        if room_name not in room_names:
            create_room(room_name)
    return render_template('lobby.html', room_names=room_names)

def create_room(room_name):
    room_names.append(room_name)
    with open(f"{my_path}{room_name}.txt", "w+") as room_file:
        pass

def append_message(room_id, message):
    with open(f"{my_path}{room_id}.txt", 'a') as room_file:
        room_file.write(message)

def get_all_messages(room_id):
    with open(f"{my_path}{room_id}.txt", 'r') as room_file:
        messages = room_file.read()
    return messages
