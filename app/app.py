import psycopg2
import logging
import sqlite3  
# Database connection parameters
db_params = {
    'host': 'db',
    'database': 'database',
    'user': 'username',
    'password': 'secret',
    'port': '5432'
}

# Establish a connection to the database
conn = psycopg2.connect(**db_params)

# Create a cursor
cur = conn.cursor()
### quary shows the dummy data here 
### Assuming performing the code step by step. (before constructing the data base)
# quary = '''



# '''

# cur.execute(quary)
# conn.commit()
try:
    
    cur.execute('SELECT * FROM compositions')
    logging.info("record is created")
    compositions = cur.fetchall()
    print('\nCompositions:')
    for composition in compositions:
        print(composition)

    cur.execute('SELECT * FROM functions')
    functions = cur.fetchall()
    print('\nFunctions:')
    for function in functions:
        print(function)

    #### From dummy data, this matrches the function but with some dummy data :) 
    cur.execute('SELECT * FROM Properties')
    Properties = cur.fetchall()
    print('\nProperties:')
    for Property in Properties:
        print(Property)
    
    # cur.execute('SELECT * FROM functions2')
    # functions = cur.fetchall()
    # print('\nFunctions:')
    # for function in functions:
    #     print(function)

    
except Exception as e:
    logging.error("record is doublicated", e)
finally:
    cur.close()
    conn.close()


