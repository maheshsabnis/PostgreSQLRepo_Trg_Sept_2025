-- Define a composite type
CREATE TYPE contact AS (
    name VARCHAR(100),
    phone VARCHAR(15)
);

-- Use it in a table
CREATE TABLE customer_contacts (
    contact_id SERIAL PRIMARY KEY,
    info contact
);

-- Insert data
INSERT INTO customer_contacts (info)
VALUES (ROW('Alice Smith', '+123456789'));

select * from customer_contacts;


-- Example: ENUM Type
-- Define an ENUM type
CREATE TYPE week_day AS ENUM (
    'Sunday', 'Monday', 'Tuesday', 'Wednesday',
    'Thursday', 'Friday', 'Saturday'
);

-- Use it in a table
CREATE TABLE opening_days (
    store_id INT,
    day week_day
);

Insert into opening_days values(1, 'Friday');

Select * from opening_days;


-- Domain Type

CREATE DOMAIN valid_email AS TEXT
CHECK (
  VALUE ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'
);

DROP Type valid_email;

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name TEXT,
  email valid_email
);
INSERT INTO users (name, email)
VALUES ('Alice', 'alice@example.com'),
       ('Bob', 'bob.smith@domain.org');



-- Range Type

CREATE TABLE reservation (
    room_id INT,
    reserved_period TSRANGE
);

-- Insert a reservation from 2 PM to 3 PM on Jan 1, 2025
INSERT INTO reservation (room_id, reserved_period)
VALUES (101, '[2025-01-01 14:00, 2025-01-01 15:00)');



Select * from reservation;











