from flask import Flask, render_template, request, redirect, url_for
import mysql.connector
import json


app = Flask(__name__)


with open('/home/ben/Databases/secrets.json', 'r') as secretFile:
    creds = json.load(secretFile)['mysqlCredentials']

connection = mysql.connector.connect(**creds)

@app.route("/", methods=['GET'])
def show_movies():
    cursor = connection.cursor()
    cursor.execute("SELECT FilmID, Title, ReleaseDate, RunTimeMinutes FROM Movie")
    movies = cursor.fetchall()
    cursor.close()
    
    return render_template('index.html', movies=movies)

@app.route("/movie/<int:film_id>", methods=['GET'])
def show_characters(film_id):
    cursor = connection.cursor()
    query = """
        SELECT c.CharacterId, c.Name, p.FirstName, p.LastName
        FROM `Character` c
        JOIN `MovieCharacter` mc ON c.CharacterId = mc.CharacterId
        JOIN `Actor` a ON c.ActorId = a.ActorId
        JOIN `Person` p ON a.PersonID = p.PersonID
        WHERE mc.FilmID = %s
    """
    cursor.execute(query, (film_id,))
    characters = cursor.fetchall()


    query_directors = """
        SELECT p.FirstName, p.LastName
        FROM `MovieDirector` md
        JOIN `Person` p ON md.PersonID = p.PersonID
        WHERE md.FilmID = %s
    """
    cursor.execute(query_directors, (film_id,))
    directors = cursor.fetchall()
    
    cursor.close()
    
    return render_template('characters.html', characters=characters, directors=directors, film_id=film_id)

@app.route("/character/<int:character_id>")
def show_character(character_id):
    mycursor = connection.cursor()
    query = """
        SELECT c.Name, p.FirstName, p.LastName, a.FirstFilm, a.FavoriteColor, a.FavoriteGenre
        FROM `Character` c
        JOIN Person p ON c.ActorId = p.PersonID  -- Corrected the join to use ActorId
        JOIN Actor a ON a.ActorId = c.ActorId
        WHERE c.CharacterId = %s
    """
    mycursor.execute(query, (character_id,))
    actor_info = mycursor.fetchone() 
    mycursor.close()

    if actor_info:
        return render_template('actor_info.html', actor_info=actor_info)
    else:
        return "Character not found", 404

@app.route("/add_movie", methods=['POST'])
def add_movie():
    title = request.form['title']
    release_date = request.form['releaseDate']
    runtime = request.form['runtime']

    mycursor = connection.cursor()

  
    mycursor.execute("SELECT MAX(FilmID) FROM Movie")
    max_film_id = mycursor.fetchone()[0]


    if max_film_id is None:
        new_film_id = 1
    else:
        new_film_id = max_film_id + 1


    query = "INSERT INTO Movie (FilmID, Title, ReleaseDate, RunTimeMinutes) VALUES (%s, %s, %s, %s)"
    mycursor.execute(query, (new_film_id, title, release_date, runtime))
    connection.commit()
    mycursor.close()


    return redirect("/")


@app.route('/person', methods=['GET'])
def showPerson():
   

    mycursor = connection.cursor()

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
    elif request.args.get('delete') == 'true':
        deleteID = request.args.get('id')
        mycursor.execute("DELETE from Person where PersonID=%s", (deleteID,))
        connection.commit()

    mycursor.execute("Select PersonID, FirstName, LastName, BirthDate from Person")
    myresult = mycursor.fetchall()
    mycursor.close()
    return render_template('swtable.html', collection=myresult)


@app.route("/updatePerson")
def updatePerson():
    id = request.args.get('id')
    newFirst = request.args.get('first_name')
    newLast = request.args.get('last_name')
    newBirthDate = request.args.get('birthdate')
    if id is None:
        return "Error, id not specified"
    elif newFirst is not None and newLast is not None and newBirthDate is not None:
        mycursor = connection.cursor()
        mycursor.execute("UPDATE Person set FirstName=%s, LastName=%s, Birthdate=%s where PersonID=%s", (newFirst, newLast, newBirthDate, id))
        mycursor.close()
        connection.commit()
        return redirect(url_for('showPerson'))

    mycursor = connection.cursor()
    mycursor.execute("select FirstName, LastName, BirthDate from Person where PersonID=%s;", (id,))
    existingFirst, existingLast, existingBirthdate = mycursor.fetchone()
    mycursor.close()
    return render_template('tableUpdate.html', id=id, existingFirst=existingFirst, existingLast=existingLast, existingBirthdate=existingBirthdate)




if __name__ == "__main__":
    app.run(debug=True)
