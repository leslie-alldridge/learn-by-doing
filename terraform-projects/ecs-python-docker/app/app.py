import os

from flask import Flask
from flask.templating import render_template

app = Flask(__name__)


@app.route("/")
def index():
    url = "https://icatcare.org/app/uploads/2018/07/Thinking-of-getting-a-cat.png"
    return render_template("index.html", url=url)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=int(os.environ.get("PORT", 5000)))
