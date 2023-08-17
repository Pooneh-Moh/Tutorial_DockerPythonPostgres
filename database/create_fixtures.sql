-- Create Domains table
-- Table with an example that can match the function 
CREATE TABLE Domains (
    domain_id SERIAL PRIMARY KEY,
    domain_name TEXT
);

-- Create Codomains table
CREATE TABLE Codomains (
    codomain_id SERIAL PRIMARY KEY,
    codomain_name TEXT
);

-- Create Properties table
CREATE TABLE Properties (
    property_id SERIAL PRIMARY KEY,
    property_name TEXT
);

-- Create Functions table
CREATE TABLE Functions (
    function_id SERIAL PRIMARY KEY,
    function_name TEXT,
    domain_id INT REFERENCES Domains(domain_id),
    codomain_id INT REFERENCES Codomains(codomain_id),
    property_id INT REFERENCES Properties(property_id)
);

-- Create Compositions table
CREATE TABLE Compositions (
    composition_id SERIAL PRIMARY KEY,
    outer_function_id INT REFERENCES Functions(function_id),
    inner_function_id INT REFERENCES Functions(function_id)
);
-- Insert values into Domains table
INSERT INTO Domains (domain_name) VALUES
    ('Real Numbers'),
    ('Integers'),
    ('Positive Integers');

-- Insert values into Codomains table
INSERT INTO Codomains (codomain_name) VALUES
    ('Real Numbers'),
    ('Integers');

-- Insert values into Properties table
INSERT INTO Properties (property_name) VALUES
    ('Monotonic'),
    ('Continuous');

-- Insert values into Functions table
INSERT INTO Functions (function_name, domain_id, codomain_id, property_id) VALUES
    ('f1', 1, 1, 1),
    ('f2', 2, 2, 2),
    ('f3', 3, 2, 1);

-- Insert values into Compositions table
INSERT INTO Compositions (outer_function_id, inner_function_id) VALUES
    (1, 2),
    (2, 3);
