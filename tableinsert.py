#!/usr/bin/python3

from flask import Flask, render_template, request
import mysql.connector, os
import json


app = Flask(__name__)


@app.route('/', methods=['GET'])
def showSpeakers():
    with open('/home/ben/Databases/secrets.json', 'r') as secretFile:
        creds = json.load(secretFile)['mysqlCredentials']

    connection = mysql.connector.connect(**creds)

    mycursor = connection.cursor()

    # If there is a name and desc 'GET' variable, insert the new value into the database
    newFirst = request.args.get('firstname')
    newLast = request.args.get('lastname')
    newBirthDate = request.args.get('birthdate')
    if newFirst is not None and newLast is not None and newBirthDate is not None:
        mycursor.execute("select max(PersonID) from Person")
        result = mycursor.fetchone()
        max_person_id = result[0] if result[0] is not None else 0 
        new_person_id = max_person_id + 1

        mycursor.execute("INSERT into Person (PersonID, FirstName, LastName, BirthDate) values (%s,%s,%s,%s)", (new_person_id,newFirst, newLast, newBirthDate))
        connection.commit()

    # Fetch the current values of the speaker table
    mycursor.execute("Select FirstName, LastName, BirthDate from Person")
    myresult = mycursor.fetchall()
    mycursor.close()
    connection.close()
    return render_template('swtable.html', collection=myresult)
    #return "Hello world"


if __name__ == '__main__':
    app.run(port=8001, debug=True, host="0.0.0.0")