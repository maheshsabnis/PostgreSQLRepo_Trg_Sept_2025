-- The MVCC Example

CREATE TABLE accounts (
    id SERIAL PRIMARY KEY,
    name TEXT,
    balance INT
);


-- Insert a row
INSERT INTO accounts (name, balance) VALUES ('Mahesh', 200);
SELECT *, xmin, xmax FROM accounts;

-- Transaction A
BEGIN;
SELECT * FROM accounts WHERE name = 'Alice';
-- Sees balance = 100
-- Still running...

-- Transaction B
BEGIN;
UPDATE accounts SET balance = 2400 WHERE name = 'Alice';
COMMIT;

-- Inspecting MVCC Internals
-- xmin: Transaction ID that inserted or last updated the row

-- xmax: Transaction ID that deleted or superseded the row (if any)

SELECT *, xmin, xmax FROM accounts;

-- Example 2: Update Creates a New Version

SELECT ctid, xmin, xmax, * FROM accounts;



-- Delete Visibility
BEGIN;
DELETE FROM accounts WHERE name = 'Alice';
-- Row is marked for deletion
BEGIN;
SELECT * FROM accounts WHERE name = 'Alice';
-- Still sees Alice if Transaction C hasn’t committed
SELECT ctid, xmin, xmax, * FROM accounts;
Select * from accounts

