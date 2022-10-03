from flask import Flask, render_template
from myDB import csv_connection

app = Flask(__name__)
df = csv_connection()


@app.route('/')
def df_table():
    return render_template('index.html', tables=[df.to_html(classes='data', header="true")])


if __name__ == "__main__":
    app.run(host='0.0.0.0',port=5000)
