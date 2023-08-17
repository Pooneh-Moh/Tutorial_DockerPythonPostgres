-- Table for storing function information
-- The domain of the function (a predefined set or range of values)
-- The codomain of the function (another predefined set or range of values)
-- compositions: Stores information about composed functions.
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
    

    -- Define functions
    INSERT INTO Function (function_id, name, domain_id, codomain_id) VALUES (1, 'f1I', 1, 3);
    INSERT INTO Function (function_id, name, domain_id, codomain_id) VALUES (2, 'f2I', 2, 3);
    INSERT INTO Function (function_id, name, domain_id, codomain_id) VALUES (3, 'f3I', NULL, 3); -- No domain, specialized handling
    INSERT INTO Function (function_id, name, domain_id, codomain_id) VALUES (4, 'f4I', 1, 3);
    

    -- Define constants
    INSERT INTO Constant (constant_id, value, domain_id) VALUES (1, 'c1I', 1);
    INSERT INTO Constant (constant_id, value, domain_id) VALUES (2, 'c2I', 2);
    INSERT INTO Constant (constant_id, value, domain_id) VALUES (3, 'c3I', 2);
    

    -- Define compositions
    INSERT INTO Composition (parent_function_id, child_function_id) VALUES (1, 2);
    INSERT INTO Composition (parent_function_id, child_function_id) VALUES (2, 3);
    INSERT INTO Composition (parent_function_id, child_function_id) VALUES (3, 4);
    
    -- Insert composition of f4I with constants c4I and c5I
    INSERT INTO Composition (parent_function_id, child_function_id)
    SELECT function_id, 4 -- function_id of f4I
    FROM Constant
    WHERE value = 'c4I' OR value = 'c5I';


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


