SET log_lock_waits = ON;
SET deadlock_timeout = '1s';


-- Transaction A
BEGIN;
UPDATE accounts SET balance = balance - 100 WHERE id = 1;

-- Transaction B (This is Executed)
BEGIN;
UPDATE accounts SET balance = balance + 100 WHERE id = 2;

-- Transaction A (This is Executed)
UPDATE accounts SET balance = balance + 100 WHERE id = 2; -- waits for B

-- Transaction B
UPDATE accounts SET balance = balance - 100 WHERE id = 1; -- waits for A

select * from accounts;

 