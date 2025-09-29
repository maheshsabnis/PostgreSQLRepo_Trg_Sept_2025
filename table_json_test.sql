CREATE TABLE json_test (
    id SERIAL PRIMARY KEY,
    col JSON NOT NULL
);

INSERT INTO json_test (col)
VALUES ('[{"name":"Mickey Mouse","age":10},{"name":"Donald Duck","age":5}]');

Select * from json_test;


-- JSON Object Queries
-- Extract names from a JSON array of objects
WITH json_test (col) AS (
  VALUES (json '[{"name":"Mickey Mouse","age":10},{"name":"Donald Duck","age":5}]')
)
SELECT y.x->>'name' AS name
FROM json_test jt,
LATERAL (SELECT json_array_elements(jt.col) x) y;
