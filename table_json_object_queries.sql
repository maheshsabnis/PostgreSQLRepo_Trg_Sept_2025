-- products
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name TEXT,
    details JSONB
);

INSERT INTO products (name, details) VALUES
('Laptop', '{"brand": "Apple", "specs": {"ram": "16GB", "storage": "512GB"}}'),
('Phone', '{"brand": "Samsung", "specs": {"ram": "8GB", "storage": "128GB"}}'),
('Tablet', '{"brand": "Microsoft", "specs": {"ram": "8GB", "storage": "256GB"}}'),
('Monitor', '{"brand": "Dell", "specs": {"size": "27in", "resolution": "4K"}}'),
('Keyboard', '{"brand": "Logitech", "specs": {"type": "Mechanical"}}'),
('Mouse', '{"brand": "Razer", "specs": {"dpi": "16000"}}'),
('Smartwatch', '{"brand": "Garmin", "specs": {"battery": "7 days"}}'),
('Speaker', '{"brand": "Bose", "specs": {"type": "Bluetooth"}}'),
('Camera', '{"brand": "Canon", "specs": {"megapixels": "24MP"}}'),
('Printer', '{"brand": "HP", "specs": {"type": "Laser"}}');

-- products — Filter by Nested Spec and Aggregate Brands
-- Find all products with at least 16GB RAM
SELECT name, details->'specs'->>'ram' AS ram
FROM products
WHERE details->'specs'->>'ram' = '16GB';

-- Count products by brand
SELECT details->>'brand' AS brand, COUNT(*) AS total
FROM products
GROUP BY details->>'brand';

-- Employees
CREATE TABLE employeesJsonData (
    id SERIAL PRIMARY KEY,
    profile JSONB
);

INSERT INTO employeesJsonData (profile) VALUES
('{"name": "Alice", "role": "Engineer", "skills": ["Python", "SQL"]}'),
('{"name": "Bob", "role": "Manager", "skills": ["Leadership", "Planning"]}'),
('{"name": "Charlie", "role": "Designer", "skills": ["Photoshop", "Illustrator"]}'),
('{"name": "Diana", "role": "Engineer", "skills": ["Java", "Docker"]}'),
('{"name": "Eve", "role": "HR", "skills": ["Recruiting", "Compliance"]}'),
('{"name": "Frank", "role": "Engineer", "skills": ["Go", "Kubernetes"]}'),
('{"name": "Grace", "role": "Support", "skills": ["Customer Service", "Zendesk"]}'),
('{"name": "Hank", "role": "Sales", "skills": ["Negotiation", "CRM"]}'),
('{"name": "Ivy", "role": "Engineer", "skills": ["C++", "Linux"]}'),
('{"name": "Jack", "role": "Finance", "skills": ["Excel", "Forecasting"]}');


-- employeesJsonData — Skill Matching and Role Aggregation

-- Find engineers who know Python
SELECT profile->>'name' AS name
FROM employeesJsonData
WHERE profile->>'role' = 'Engineer'
  AND 'Python' = ANY (SELECT jsonb_array_elements_text(profile->'skills'));

-- Count employeesJsonData per role
SELECT profile->>'role' AS role, COUNT(*) AS total
FROM employeesJsonData
GROUP BY profile->>'role';


-- properties tables

CREATE TABLE properties (
    id SERIAL PRIMARY KEY,
    features JSONB
);

INSERT INTO properties (features) VALUES
('{"rooms": [{"type": "bedroom", "size": "12x12"}, {"type": "kitchen", "size": "10x8"}]}'),
('{"rooms": [{"type": "living", "size": "15x20"}, {"type": "bathroom", "size": "6x8"}]}'),
('{"rooms": [{"type": "bedroom", "size": "10x10"}, {"type": "office", "size": "8x10"}]}'),
('{"rooms": [{"type": "garage", "size": "20x20"}]}'),
('{"rooms": [{"type": "bedroom", "size": "14x14"}, {"type": "balcony", "size": "5x10"}]}'),
('{"rooms": [{"type": "kitchen", "size": "12x10"}, {"type": "pantry", "size": "4x6"}]}'),
('{"rooms": [{"type": "bathroom", "size": "7x9"}, {"type": "closet", "size": "3x5"}]}'),
('{"rooms": [{"type": "living", "size": "18x22"}]}'),
('{"rooms": [{"type": "bedroom", "size": "11x13"}, {"type": "study", "size": "9x11"}]}'),
('{"rooms": [{"type": "basement", "size": "25x30"}]}');

-- properties — Extract Room Types and Sizes
-- List all room types and sizes across properties
SELECT p.id, room->>'type' AS room_type, room->>'size' AS room_size
FROM properties p,
LATERAL jsonb_array_elements(p.features->'rooms') AS room;

-- Count how many properties have a bedroom
SELECT COUNT(*) AS bedroom_properties
FROM properties
WHERE EXISTS (
  SELECT 1
  FROM jsonb_array_elements(features->'rooms') AS room
  WHERE room->>'type' = 'bedroom'
);

-- orders table

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    items JSONB
);

INSERT INTO orders (items) VALUES
('[
    {"product": "Book", "qty": 2},
    {"product": "Pen", "qty": 5}
]'),
('[
    {"product": "Notebook", "qty": 3},
    {"product": "Pencil", "qty": 10}
]'),
('[
    {"product": "Bag", "qty": 1},
    {"product": "Marker", "qty": 4}
]'),
('[
    {"product": "Folder", "qty": 6}
]'),
('[
    {"product": "Stapler", "qty": 2},
    {"product": "Tape", "qty": 3}
]'),
('[
    {"product": "Scissors", "qty": 1},
    {"product": "Glue", "qty": 2}
]'),
('[
    {"product": "Ruler", "qty": 5}
]'),
('[
    {"product": "Calculator", "qty": 1},
    {"product": "Eraser", "qty": 6}
]'),
('[
    {"product": "Sharpener", "qty": 3}
]'),
('[
    {"product": "Whiteboard", "qty": 1}
]');

-- orders — Total Quantity per Product Across All Orders

-- Aggregate total quantity of each product
SELECT item->>'product' AS product, SUM((item->>'qty')::INT) AS total_qty
FROM orders,
LATERAL jsonb_array_elements(items) AS item
GROUP BY item->>'product';

-- user_strrings table

CREATE TABLE users_settings (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

INSERT INTO users (name) VALUES
('Alice'),
('Bob'),
('Charlie'),
('Diana'),
('Eve'),
('Frank'),
('Grace'),
('Hank'),
('Ivy'),
('Jack');



-- settings Table
CREATE TABLE settings (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    config JSONB
);


INSERT INTO settings (user_id, config) VALUES
(1,  '{"theme": "dark", "notifications": {"email": true, "sms": false}}'),
(2,  '{"theme": "light", "notifications": {"email": false, "sms": true}}'),
(3,  '{"theme": "dark", "notifications": {"email": true, "sms": true}}'),
(4,  '{"theme": "light", "notifications": {"email": false, "sms": false}}'),
(5,  '{"theme": "dark", "notifications": {"email": true}}'),
(6,  '{"theme": "light", "notifications": {"sms": true}}'),
(7,  '{"theme": "dark"}'),
(8,  '{"theme": "light"}'),
(9,  '{"theme": "dark", "notifications": {"email": false, "sms": true}}'),
(10, '{"theme": "light", "notifications": {"email": true, "sms": false}}'),
(1,  '{"theme": "dark", "notifications": {"email": true, "sms": true, "push": true}}'),
(2,  '{"theme": "light", "notifications": {"email": false, "sms": false, "push": false}}'),
(3,  '{"theme": "dark", "notifications": {"email": true, "sms": false}}'),
(4,  '{"theme": "light", "notifications": {"email": true}}'),
(5,  '{"theme": "dark", "notifications": {"email": false}}'),
(6,  '{"theme": "light", "notifications": {"sms": false}}'),
(7,  '{"theme": "dark", "notifications": {"email": true, "sms": true}}'),
(8,  '{"theme": "light", "notifications": {"email": true, "sms": true}}'),
(9,  '{"theme": "dark", "notifications": {"email": false, "sms": false}}'),
(10, '{"theme": "light", "notifications": {"email": true, "sms": true}}');

-- settings — Filter by Notification Preferences
-- Find users who have email notifications enabled
SELECT id, config->>'theme' AS theme
FROM settings
WHERE config->'notifications'->>'email' = 'true';

-- Count how many users prefer dark theme and have SMS enabled
SELECT COUNT(*) AS dark_sms_users
FROM settings
WHERE config->>'theme' = 'dark'
  AND config->'notifications'->>'sms' = 'true';

-- Join JSONB with Relational Data

SELECT u.name, s.config->>'theme' AS theme
FROM users u
JOIN settings s ON u.id = s.user_id
WHERE s.config->'notifications'->>'email' = 'true';

