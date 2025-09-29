CREATE TABLE user_profiles (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  profile_data JSONB  -- You can use JSON or JSONB (binary JSON)
);


INSERT INTO user_profiles (name, profile_data)
VALUES 
  ('Alice', '{"age": 30, "email": "alice@example.com", "interests": ["reading", "hiking"]}'),
  ('Bob', '{"age": 25, "email": "bob@example.com", "interests": ["gaming", "cooking"]}');


-- Get all users with age over 28:

SELECT name, profile_data->>'age' AS age
FROM user_profiles
WHERE (profile_data->>'age')::INT > 28;


-- Get users who like hiking:

SELECT name
FROM user_profiles
WHERE profile_data->'interests' @> '["hiking"]';

-- Update JSON Data



