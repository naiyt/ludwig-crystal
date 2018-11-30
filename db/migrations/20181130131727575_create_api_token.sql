-- +micrate Up
CREATE TABLE api_tokens (
  id BIGSERIAL PRIMARY KEY,
  token VARCHAR NOT NULL UNIQUE,
  user_id INT REFERENCES users ON DELETE CASCADE,
  expires_at TIMESTAMP,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);


-- +micrate Down
DROP TABLE IF EXISTS api_tokens;
