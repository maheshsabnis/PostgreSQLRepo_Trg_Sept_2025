-- Parent table
CREATE TABLE cities (
  name       TEXT,
  population REAL,
  elevation  INT  -- in feet
);

-- Child table inherits from cities
CREATE TABLE capitals (
  state CHAR(2) UNIQUE NOT NULL
) INHERITS (cities);



INSERT INTO cities (name, population, elevation)
VALUES 
  ('Seattle', 733000, 520),
  ('Phoenix', 1680000, 1085),
  ('Boston', 675000, 141),
  ('Austin', 974000, 489);


INSERT INTO capitals (name, population, elevation, state)
VALUES 
  ('Sacramento', 525000, 30, 'CA'),
  ('Albany', 98000, 200, 'NY'),
  ('Denver', 715000, 5280, 'CO'),
  ('Atlanta', 498000, 1050, 'GA');

