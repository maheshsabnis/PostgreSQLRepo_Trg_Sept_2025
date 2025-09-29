Select * from employee
-- 1. Row-Level Trigger
-- Audit table
CREATE TABLE employee_deletions (
    empno INT,
    deleted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Trigger function
CREATE OR REPLACE FUNCTION log_employee_deletion()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO employee_deletions(empno)
    VALUES (OLD.empno);
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trg_log_employee_deletion
AFTER DELETE ON employee
FOR EACH ROW
EXECUTE FUNCTION log_employee_deletion();

Insert into employee values
(10001, 'Sample Employee', 'Manager', 12200, 10);

delete from employee where empno=10001;




-- 2. Statement-Level Trigger

-- Fires once per SQL statement, regardless of how many rows are affected.

-- Example: Notify when any update happens on people table

select * from people;
-- Trigger function
CREATE OR REPLACE FUNCTION notify_people_update()
RETURNS TRIGGER AS $$
BEGIN
    PERFORM pg_notify('people_channel', 'people table updated');
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trg_notify_people_update
AFTER UPDATE ON people
FOR EACH STATEMENT
EXECUTE FUNCTION notify_people_update();

update people set age=30 where id=1;

-- 3. BEFORE Trigger

-- Executes before the event. Can modify or cancel the operation.
-- Example: Prevent inserting negative salary in employee

-- Trigger function
CREATE OR REPLACE FUNCTION validate_salary()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.salary < 0 THEN
        RAISE EXCEPTION 'Salary cannot be negative';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trg_validate_salary
BEFORE INSERT OR UPDATE ON employee
FOR EACH ROW
EXECUTE FUNCTION validate_salary();

Insert into employee values
(10003, 'Sample Employee', 'Manager', -112200, 10);





