DROP TABLE IF EXISTS tickets;
DROP TABLE IF EXISTS screenings;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS films;

CREATE TABLE customers (
  id SERIAL PRIMARY KEY,
  name VARCHAR,
  funds DECIMAL(4,2)
);

CREATE TABLE films (
  id SERIAL PRIMARY KEY,
  title VARCHAR,
  price DECIMAL(4,2)
);

CREATE TABLE screenings (
  id SERIAL PRIMARY KEY,
  screening_time VARCHAR,
  capacity INT,
  film_id INT REFERENCES films(id) ON DELETE CASCADE
);

CREATE TABLE tickets (
  id SERIAL PRIMARY KEY,
  customer_id INT REFERENCES customers(id) ON DELETE CASCADE,
  screening_id INT REFERENCES screenings(id) ON DELETE CASCADE
);
