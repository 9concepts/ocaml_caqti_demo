DROP TABLE IF EXISTS users;

CREATE TABLE users (
  user_id SERIAL PRIMARY KEY,
  name VARCHAR(128) NOT NULL,
  email VARCHAR (128) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'),
  UNIQUE(email)
);

INSERT INTO
  users (name, email)
VALUES
  ('test-user-1', 'test-1@example.com'),
  ('test-user-2', 'test-2@example.com'),
  ('test-user-3', 'test-3@example.com'),
  ('test-user-4', 'test-4@example.com');
