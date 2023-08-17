import psycopg2
import threading
import logging

# Initialize logging
logging.basicConfig(filename='system_log.log', level=logging.INFO)

# Connect to the PostgreSQL database
db_params = {
    'host': 'db',
    'database': 'database',
    'user': 'username',
    'password': 'secret',
    'port': '5432'
}
conn = psycopg2.connect(**db_params)
cur = conn.cursor()
# quary = '''
# CREATE TABLE table_b2 (
#     id SERIAL PRIMARY KEY,
#     client_id INTEGER REFERENCES table_a(id),
#     item VARCHAR(255),
#     order_number VARCHAR(50)
# );

# '''
# cur.execute(quary)
# conn.commit()
try:
    # Start a transaction
    conn.autocommit = False

    # Create a threading lock to ensure thread-safe database operations
    db_lock = threading.Lock()

    def load_file_a():
        with open('./app/a.txt', 'r') as file_a:
            lines = file_a.readlines()
            for line in lines:
                parts = line.strip().split(',')
                client_name_A, phone_number_A, address_A = parts        
                with db_lock:
                    cur.execute("INSERT INTO table_a (name, phone, address) VALUES (%s, %s, %s) RETURNING id;",
                                (client_name_A, phone_number_A, address_A))
                    client_id = cur.fetchone()[0]
                    cur.execute("INSERT INTO table_b2 (client_id) VALUES (%s);", (client_id,))
        
                    logging.info("File A loaded successfully.")           

    def load_file_b():
        with open('./app/b.txt', 'r') as file_a:
            lines = file_a.readlines()
            for line in lines:
                parts = line.strip().split(',')
                client_name_B, phone_number_B, address_B = parts  
                with db_lock:
                    cur.execute("INSERT INTO table_a (name, phone, address) VALUES (%s, %s, %s) RETURNING id;",
                                (client_name_B, phone_number_B, address_B))
                    client_id = cur.fetchone()[0]
                    cur.execute("INSERT INTO table_b2 (client_id) VALUES (%s);", (client_id,))
        
                    logging.info("File B loaded successfully.")   

    # Start a transaction
    conn.autocommit = False
    
    # Some othe infor to insert 
    client_data2 = [("Client C", "124567894", "Address C"),
                   ("Client D", "984664341", "Address D")]

    for client in client_data2:
        cur.execute("INSERT INTO table_a (name, phone, address) VALUES (%s, %s, %s) RETURNING id;", client)
        client_id = cur.fetchone()[0]
        cur.execute("INSERT INTO table_b2 (client_id, item, order_number) VALUES (%s, %s, %s);", (client_id, "Item X", "12365"))
    
    conn.commit() 
    
    # Load Files A and B concurrently using threads
    thread_a = threading.Thread(target=load_file_a)
    thread_b = threading.Thread(target=load_file_b)
    
    thread_a.start()
    thread_b.start()
    
    thread_a.join()
    thread_b.join()
    
    # Complete the transaction
    conn.commit()
    
except Exception as e:
    # Log the error and rollback transaction
    logging.error(f"Error: {str(e)}")
    conn.rollback()

finally:
    # Clean up
    cur.close()
    conn.close() 

