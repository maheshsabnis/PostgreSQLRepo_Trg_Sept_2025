CREATE TABLE accounts (
    id SERIAL PRIMARY KEY,
    name TEXT,
    balance INT
);

Select * from accounts;

-- Insert initial records
INSERT INTO accounts (name, balance) VALUES
('Nilesh', 120),
('Vikas', 140),
('Akash', 160),
('Sanjay', 180)
;


SELECT * FROM pg_locks;

