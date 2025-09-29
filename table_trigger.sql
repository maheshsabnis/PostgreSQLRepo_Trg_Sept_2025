-- Audit Table

CREATE TABLE user_audit (
    user_id INT,
    old_email TEXT,
    new_email TEXT,
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create the Trigger Function
CREATE OR REPLACE FUNCTION log_user_email_change()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.email IS DISTINCT FROM NEW.email THEN
        INSERT INTO user_audit(user_id, old_email, new_email)
        VALUES (OLD.id, OLD.email, NEW.email);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Attach the Trigger to the Table

CREATE TRIGGER user_email_update_trigger
AFTER UPDATE ON users
FOR EACH ROW
EXECUTE FUNCTION log_user_email_change();

Select * from users;
update users set name='Alice Patil', email='alice.patil@reservation.com' where name='Alice';
select * from user_audit;
