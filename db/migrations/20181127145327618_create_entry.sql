-- +micrate Up
CREATE TABLE entries (
  id BIGSERIAL PRIMARY KEY,
  device VARCHAR NOT NULL,
  date_string VARCHAR NOT NULL,
  sgv INT NOT NULL,
  delta FLOAT,
  direction VARCHAR NOT NULL,
  filtered INT,
  unfiltered INT,
  rssi INT,
  noise INT,
  sys_time VARCHAR,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);


-- +micrate Down
DROP TABLE IF EXISTS entries;
