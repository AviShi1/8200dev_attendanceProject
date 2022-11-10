import mysql.connector
import pandas as pd
import os
from dotenv import load_dotenv
#from attendance import config_all


#if we want to redownload the files from our machine we need to write "config_all()" before "load_dotenv()" 
def csv_connection():
    load_dotenv()
    temp_data = pd.read_csv('./attendance.csv', index_col=False, delimiter=',')
    temp_df = temp_data[['names', 'average']].copy()
    new_df = pd.DataFrame()

    db = mysql.connector.connect(
        host='db',
        user='root',
        passwd='aviaot2020',
        database=os.'attenDev'
    )

    if db.is_connected():
        mycursor = db.cursor()
        mycursor.execute("CREATE DATABASE IF NOT EXISTS attenDev;")
        mycursor.execute("use attenDev;")
        mycursor.execute("select database()")
        fetching = mycursor.fetchone()
        print("You are now connected to: ", fetching)
        mycursor.execute('DROP TABLE IF EXISTS attenDB;')
        mycursor.execute("CREATE TABLE attenDB(Names VARCHAR(50), average VARCHAR(50))")
        print("Your tables has been created!")
        for i, row in temp_df.iterrows():
            mycursor.execute("INSERT INTO attenDev.attenDB VALUES (%s,%s)", tuple(row))
            db.commit()

    # mycursor.execute("CREATE DATABASE attenDev")
    mycursor.execute("SELECT * FROM attenDev.attenDB;")
    rows=mycursor.fetchall()
    new_df=pd.read_sql("SELECT * FROM attenDev.attenDB;", db)
    db.close()
    return new_df
