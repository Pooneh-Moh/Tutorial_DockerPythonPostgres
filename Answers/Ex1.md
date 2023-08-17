# Ex1 
## Provide the Entity-Relationship (ER) model and Data Definition Language (DDL) file:

**Entities:**
* Entity `C`:
   - Attributes: `c_id` (Primary Key), `value`

* Entity `F2`:
   - Attributes: `f2_id` (Primary Key), `c2_id` (Foreign Key referencing `C`), `c3_id` (Foreign Key referencing `C`)

* Entity `F4`:
   - Attributes: `f4_id` (Primary Key), `c4_id` (Foreign Key referencing `C`), `c5_id` (Foreign Key referencing `C`)

* Entity `F3`:
   - Attributes: `f3_id` (Primary Key), `f4_id` (Foreign Key referencing `F4`)

* Entity `F1`:
   - Attributes: `f1_id` (Primary Key), `c1_id` (Foreign Key referencing `C`), `f2_id` (Foreign Key referencing `F2`), `f3_id` (Foreign Key referencing `F3`)

**f1I(c1I, f2I(c2I, c3I), f3I(f4I(c4I, c5I))) -> C1**
*	F1I : takes arguments from domain A, B, C -> results in C1
*	F2I : takes arguments from domain D & E -> results in C2
*	F3I : No arguments -> results in C3
*	F4l : takes arguments from domain F, G -> results in C4 
Evaluate the inner functions:
*	f4I(c4I, c5I) -> C4 
*	f2I(c2I, c3I) -> C2 
*	f3I(f4I(c4I, c5I)) -> C3 
The final result is C1 as mentioned

**Now the SQL code:**

'''
    -- Create tables for domains and codomains

    CREATE TABLE Domain (
        domain_id INT PRIMARY KEY,
        name VARCHAR(255)
    );

    CREATE TABLE Codomain (
        codomain_id INT PRIMARY KEY,
        name VARCHAR(255)
    );

    -- Create table for functions
    CREATE TABLE Function (
        function_id INT PRIMARY KEY,
        name VARCHAR(255),
        domain_id INT,
        codomain_id INT,
        additional_properties VARCHAR(255),
        FOREIGN KEY (domain_id) REFERENCES Domain(domain_id),
        FOREIGN KEY (codomain_id) REFERENCES Codomain(codomain_id)
    );

    -- Create table for compositions
    CREATE TABLE Composition (
        parent_function_id INT,
        child_function_id INT,
        FOREIGN KEY (parent_function_id) REFERENCES Function(function_id),
        FOREIGN KEY (child_function_id) REFERENCES Function(function_id)
    );

    -- Create table for constants
    CREATE TABLE Constant (
        constant_id INT PRIMARY KEY,
        value VARCHAR(255),
        domain_id INT,
        FOREIGN KEY (domain_id) REFERENCES Domain(domain_id)
    );

    -- Define domains and codomains
    INSERT INTO Domain (domain_id, name) VALUES (1, 'A');
    INSERT INTO Domain (domain_id, name) VALUES (2, 'B');
    INSERT INTO Domain (domain_id, name) VALUES (3, 'C');
    -- ... Define other domains and codomains ...

    -- Define functions
    INSERT INTO Function (function_id, name, domain_id, codomain_id) VALUES (1, 'f1I', 1, 3);
    INSERT INTO Function (function_id, name, domain_id, codomain_id) VALUES (2, 'f2I', 2, 3);
    INSERT INTO Function (function_id, name, domain_id, codomain_id) VALUES (3, 'f3I', 0, 3); -- No domain, specialized handling
    INSERT INTO Function (function_id, name, domain_id, codomain_id) VALUES (4, 'f4I', 1, 3);
    -- ... Define other functions ...

    -- Define constants
    INSERT INTO Constant (constant_id, value, domain_id) VALUES (1, 'c1I', 1);
    INSERT INTO Constant (constant_id, value, domain_id) VALUES (2, 'c2I', 2);
    INSERT INTO Constant (constant_id, value, domain_id) VALUES (3, 'c3I', 2);
    -- ... Define other constants ...

    -- Define compositions
    INSERT INTO Composition (parent_function_id, child_function_id) VALUES (1, 2);
    INSERT INTO Composition (parent_function_id, child_function_id) VALUES (2, 3);
    INSERT INTO Composition (parent_function_id, child_function_id) VALUES (3, 4);

    -- Run the main formula query
    SELECT f1I.name, f1I.domain_id, f1I.codomain_id
    FROM Function f1I
    JOIN Composition c1 ON f1I.function_id = c1.parent_function_id
    JOIN Function f2I ON c1.child_function_id = f2I.function_id
    JOIN Composition c2 ON f2I.function_id = c2.parent_function_id
    JOIN Function f3I ON c2.child_function_id = f3I.function_id
    JOIN Composition c3 ON f3I.function_id = c3.parent_function_id
    JOIN Function f4I ON c3.child_function_id = f4I.function_id
    WHERE f1I.name = 'f1I'
    AND c1.parent_function_id = 1
    AND c2.parent_function_id = 2
    AND c3.parent_function_id = 3;
'''

## iii) Elaborate on the different common approaches and technologies that exist to implement the interface with the back-end.
To impliment the interface with the back-end, differnt techs exists. 
1. *APIs*: such as GraphicQL, or REST (HTTP methods and URLS)
2. *Serve-side frimware*: Node.js (JavaScript runtime), Ruby on Rails (web app frimware), Django (python firmware), Express
3. *WebSockets*: allow bidirectional communication between the client and the server. This is especially useful for real-time applications such as chat apps or live data updates
4. *Message Queues and Event-Driven Architecture*: MQTT server, RabbitMQ, Kafka, or AWS SQS
communicate asynchronously by sending and receiving messages. This approach is useful for handling background tasks, events. 
5. *Serverless*: allowing developers to focus solely on writing code. Services like AWS Lambda and Azure Functions execute code in response to events, making them well-suited for specific tasks or microservices.
6. *Authentication and Authorization*: to protect back-end APIs, such as: JWT (JSON Web Tokens) 
7. *Database Integration*: to sort and integrate the DB, such as:  relational databases (MySQL, PostgreSQL) and NoSQL databases. 
8. *API managment platforms*: AWS API Gateway, and Azure API Management provide features for API documentation, versioning, analytics, and security management.
9. *Dockers*: enables packaging applications and their dependencies into containers 
10. *Microservices*: In this architecture, an application is composed of small, independent services that communicate via APIs. Each service focuses on a specific task, making it easier to scale, maintain, and deploy different parts of the application.

## iv) Elaborate on the decisions driving the definition of the database schema, as well as on the design patterns used in the system.

### What to consider when designing a schema:
- To determine the structure of the tables and columns accordingly. 
- Identify any relationships between entities within the system and ensure that they are properly represented in the design
- consider any constraints or triggers that may be necessary for maintaining data integrity
- Ensure that tables and columns are properly named, as this will make them easier to understand
- Maintain consistency when designing the schema and avoid redundant data where possible. 
- Test the database schema thoroughly to ensure that it meets the needs of users
  

### database schemas:
There are 3 common types of database schemas: Conceptual, logical and physical model design.
1. Conceptual:
    A high-level presentation of the structure and relationships in a database. It describes the main concepts of data, as well as how they are related to each other. A conceptual schema does not go into detail about specific objects such as tables, views, and columns; instead, it focuses on abstract concepts and how they relate to one another. 
   
   The purpose of a conceptual schema is to provide an overall view of the structure and relationships in a database. It helps users understand the underlying structure, as well as identify any potential problems or inconsistencies before they make their way into data applications or impact insights derived from analytics. This type of schema can also be used by database developers to design more detailed schemas.
2. Logical schema:
    A logical schema is an intermediate level of detail between a conceptual and physical database design. It provides a more detailed description of the data, including specific objects such as tables and columns. A logical schema outlines the structure and relationships between various entities within a database, as well as how data is stored in the tables.

    The purpose of a logical schema is to ensure that data is logically organized and stored efficiently. It helps users identify the relationships between entities, providing even more ways than a conceptual schema to identify issues in the schema early. Logical schemas are particularly useful for developers because they provide a better understanding of how data is structured and can be used to design even more detailed schemas as needed.
3. Physical schema:
    A physical schema is the most detailed level of a database design. It describes how data is physically stored in the system and outlines specific objects such as tables, columns, indexes, and views. A physical schema also includes information about the storage media used for each table, such as a cloud data warehouse or data lakehouse, as well as any constraints or triggers associated with the data or storage methodology .

    he purpose of a physical schema is to provide a detailed description of how data is stored in the system. It helps database developers determine which storage media should be used for each table and ensure that data is logically organized. Additionally, it can help identify any potential issues or inconsistencies before they occur. By having an established physical schema, developers can ensure that data is stored efficiently and easily retrieved when needed.

### Data patterns
Patterns are reusable solutions to common problems. Good patterns shoub be:
- generic and can be applied anywhere in your model
- can thus be mixed and matched with other patterns to solve more complex problems
- do not repeat information because this helps maintain data integrity
- database system-agnostic (I’ve used focused on relational/SQL databases because those are the most popular)
- intuitive and easy to understand!


Some patterns are more strict and local and some are more generic and global. 
![Alt text](image.png)

To denote the flexibility of the model I use 5 levels. L0 is the least flexible. L4 is the most flexible:

- L0: solves the problem ad-hoc (this tends to be the simplest thing you can think of, though the inflexibility can be a major shortcoming)
- L1: better, but still some downsides
- L2: solves the problem in one place in a generic way so that future changes are easier to make
- L3: allows reapplying pattern in the same place of the model without changing the schema
- L4: allows reapplying pattern anywhere in the model without changing the schema


### Architecture Patterns of NoSQL: 
1. Key-Value Store Database: 
   most basic models of NoSQL databases, the data is stored in form of Key-Value Pairs. The key is usually a sequence of strings, integers or characters but can also be a more advanced data type. The value is typically linked or co-related to the key. The key-value pair storage databases generally store data as a hash table where each key is unique. The value can be of any type (JSON, BLOB(Binary Large Object), strings, etc). This type of pattern is usually used in shopping websites or e-commerce applications.
   - Advantages:
     - Can handle large amounts of data and heavy load, 
     - Easy retrieval of data by keys. 
   - Limitations:
     - Complex queries may attempt to involve multiple key-value pairs which may delay performance. 
     - Data can be involving many-to-many relationships which may collide. 
  
2. Column Store Database:
   Rather than storing data in relational tuples, the data is stored in individual cells which are further grouped into columns. Column-oriented databases work only on columns. They store large amounts of data into columns together. Format and titles of the columns can diverge from one row to other. Every column is treated separately. But still, each individual column may contain multiple other columns like traditional databases. 
   - Advantages:
     - Data is readily available 
     - Queries like SUM, AVERAGE, COUNT can be easily performed on columns.
  
3. Document Database:
   The document database fetches and accumulates data in form of key-value pairs but here, the values are called as Documents. Document can be stated as a complex data structure. Document here can be a form of text, arrays, strings, JSON, XML or any such format. The use of nested documents is also very common. It is very effective as most of the data created is usually in form of JSONs and is unstructured. 
   - Advantages: 
      - This type of format is very useful and apt for semi-structured data. 
      - Storage retrieval and managing of documents is easy
    - Limitations:
      - Handling multiple documents is challenging 
      - Aggregation operations may not work accurately.
4. Graph Database:
   Clearly, this architecture pattern deals with the storage and management of data in graphs. Graphs are basically structures that depict connections between two or more objects in some data. The objects or entities are called as nodes and are joined together by relationships called Edges. Each edge has a unique identifier. Each node serves as a point of contact for the graph. This pattern is very commonly used in social networks where there are a large number of entities and each entity has one or many characteristics which are connected by edges. The relational database pattern has tables that are loosely connected, whereas graphs are often very strong and rigid in nature
   - Advantages: 
     - Fastest traversal because of connections. 
     - Spatial data can be easily handled. 
   - Limitations:
     - Wrong connections may lead to infinite loops. 

## v) To assess the advantages and disadvantages of the proposed schema, define some interesting metrics (e.g. average ratio between total number of bits per record set to NULL and total size of the record, etc.) and show how they are affected when the number of functions, their arities or other factors vary. For example, the candidate could consider the impact of the composition depth metric, defined in Exercise 8.

1. **Average Ratio of NULL Values:**
   Metric: `(Total number of NULL values) / (Total number of records * Total number of attributes)`
   - Lower NULL ratios indicate more efficient storage and less wasted space.
   - High NULL ratios can lead to inefficient storage utilization.

   Impact of Factors:
   - As the number of functions increases, NULL ratios might increase if many attributes are not applicable to certain functions.
   - Higher composition depth could lead to more NULL values as not all attributes are relevant at all depths.

2. **Total Size of the Record:**
   Metric: Total size of all attributes combined in a record.
   - Smaller record sizes lead to efficient storage and better memory usage.
   - Larger record sizes may impact query performance and storage requirements.

   Impact of Factors:
   - Larger arities might lead to larger record sizes, especially if attributes are complex (e.g., strings instead of integers).
   - Deeper compositions could lead to larger record sizes due to more attributes being involved.

3. **Query Performance:**
   Metric: Execution time of common queries (e.g., selecting functions based on domain, computing compositions, retrieving specific attributes).
   - Faster query performance improves user experience and system responsiveness.
   - Poor query performance can frustrate users and degrade system performance.

   Impact of Factors:
   - Larger number of functions might lead to slower query performance if proper indexing is not in place.
   - Deeper compositions might require more complex queries, impacting performance.

4. **Composition Depth Metric:**
   Metric: Depth of the composition hierarchy.
   - Provides insight into the complexity of the composition structure.
   - Deeper compositions might increase query complexity and affect performance.

   Impact of Factors:
   - Deeper compositions might lead to increased query complexity and potentially slower performance.
   - Higher composition depths could result in more NULL values in the records.

5. **Storage Space Utilization:**
   Metric: Percentage of the database's allocated space used for actual data storage.
   - Efficient utilization of storage resources.
   - Poor space utilization can lead to increased costs and inefficiency.

   Impact of Factors:
   - More functions or attributes could lead to better space utilization if well-structured.
   - Poorly designed schema might result in wasted space.

6. **Number of Joins Required for Common Queries:**
   Metric: Number of join operations required to retrieve necessary information.
   - Fewer joins lead to simpler queries and potentially better performance.
   - Excessive joins can complicate queries and reduce performance.

   Impact of Factors:
   - Deeper compositions might require more joins, affecting query complexity.
   - Better-designed schema might reduce the need for excessive joins.

By varying factors such as the number of functions, their arities, and composition depth, you can observe how these metrics change and analyze the schema's performance under different conditions. Optimizing the schema design and indexing strategy based on the insights gained from these metrics can help address potential challenges and ensure efficient and scalable database performance.

### 4 . Consider a generic composition of type:
#### Assuming that the speed of the system in computing a composition (e.g. bits computed per unit of time) can be modeled as an exponential distribution of parameter λc, find a formula for the average execution time of a set S of compositions, knowing that the cardinality of S is a Bernoulli random variable with parameter B(n, p).

It is said that the composition can be modeled by exp of $\landa_c$. Therefore, it means that the average time (expected value) for an exponential distribution with parameter λc is 1 / λc. 
On the other side, for S, we have a Bernoulli random variable, which means, the expected value is np. @[https://www.sciencedirect.com/science/article/pii/S0898122110009284]. So now simply by myltyplying these two we can get to the value of np/λc. 

### Assuming that λc is unknown and that the response time of the system is affected by a statistical error, describe an experimental way to to estimate it, starting from a set S of compositions (make extra assumptions if needed).

Eventhough the value of $\landa_c$ is unknowen, yet we still have the exponentia disterbution (the exponatianl formula is intact). So, let's assume we are excuting the whole set, and also recording the observed excution time. So, now we can actually use a maximum liklihood method to estimate that value, with the recorede times from the excution. 