from flask import Flask
from flask_bootstrap import Bootstrap
from flask import Blueprint, render_template, flash, redirect, url_for
import os

app = Flask(__name__, template_folder="templates", static_folder="static", static_url_path='')
production = os.getenv("PRODUCTION", True)
Bootstrap(app)

@app.route("/")
def main_page():
    return render_template('index.html')

def main():
    if not production:
        app.run(host="0.0.0.0", port=8080)

    if production:
        app.run(host="0.0.0.0", port=8080, debug=True)

if __name__ == "__main__":
    main()
