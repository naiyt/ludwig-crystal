-- +micrate Up
CREATE TABLE users (
  id BIGSERIAL PRIMARY KEY,
  email VARCHAR NOT NULL UNIQUE,
  hashed_password VARCHAR NOT NULL,
  -- This is a temporary column to be used to ensure we only have one user for now, until I implement
  -- permission levels
  singleton BOOL NOT NULL UNIQUE DEFAULT TRUE,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);


-- +micrate Down
DROP TABLE IF EXISTS users;
