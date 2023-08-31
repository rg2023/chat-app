from flask import request, session
from datetime import datetime

def append_message(room_id, message):
    with open(f'rooms/{room_id}.txt', 'a') as room_file:
        timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        if 'username' in session:
            username = session['username']
        else:
          username='guest'
        room_file.write(f'[{timestamp}] {username}: {message}\n')

def get_all_messages(room_id):
    with open(f'rooms/{room_id}.txt', 'r') as room_file:
        messages = room_file.read()
    return messages
def clear_messages(room):
  """Clears all messages in the current room."""
  if request.method == "POST":
    name_to_remove= session['username']
    with open(f'rooms/{room}.txt', 'r') as f:
        lines=f.readlines()  
    with open(f'rooms/{room}.txt', 'w') as file:
            for line in lines:
                 if name_to_remove not in line:
                    file.write(line)    
