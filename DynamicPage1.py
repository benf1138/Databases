#! /usr/bin/env python3

from flask import Flask, render_template, request

app = Flask(__name__)

@app.route('/')
def index():
    return render_template("InputPage.html")


@app.route('/StaticWeb.html', methods=['GET'])
def renderTableGET():
    title = request.args.get('title')
    releasedate = request.args.get('releasedate')
    runtime = request.args.get('runtime')
    output = render_template('StaticWeb.html', title=title, releasedate=releasedate,runtime=runtime)
    return output 


if __name__ == '__main__':
    app.run(port=8000, debug=True, host="0.0.0.0")