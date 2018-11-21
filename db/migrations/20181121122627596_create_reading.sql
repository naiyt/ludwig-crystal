-- +micrate Up
CREATE TABLE readings (
  id BIGSERIAL PRIMARY KEY,
  value INT,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);


-- +micrate Down
DROP TABLE IF EXISTS readings;
