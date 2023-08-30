from flask import render_template, request, redirect, session
import base64
file_name = "users.csv"

def process_registration():
    # Registration Logic
    if request.method == 'POST':
        name = request.form['username']
        password = request.form['password']
        if not user_exists(name, password):
            register_user(name, password)
            session['username'] = name
            return redirect('/lobby')
    return render_template('register.html')

def process_login():
    # Login Logic
    if request.method == 'POST':
        name = request.form['username']
        password = request.form['password']
        if user_exists(name, password):
            session['username'] = name
            return redirect('/lobby')
        else:
           return redirect('/register')
    return render_template('login.html')

def user_exists(name, password):
    # Check if the user exists in the CSV file
    with open(file_name, mode='r', newline='') as file:
        for row in file:
            if row != "":
                row_name, row_password = row.strip().split(',')
                base64_bytes = row_password.encode('ascii')
                pass_bytes = base64.b64decode(base64_bytes)
                row_password = pass_bytes.decode('ascii')
                if row_name == name and row_password == password:
                    return True
    return False

def register_user(name, password):
    # Register user in the CSV file
    pass_bytes = password.encode('ascii')
    base64_bytes = base64.b64encode(pass_bytes)
    password = base64_bytes.decode('ascii')
    with open(file_name, mode='a', newline='') as file:
        file.write(f'{name},{password}\n')

def logout():
    session.pop('username', None)
    return redirect('/register')
