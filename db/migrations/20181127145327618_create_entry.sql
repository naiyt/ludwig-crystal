-- +micrate Up
CREATE TABLE entries (
  id BIGSERIAL PRIMARY KEY,
  device VARCHAR NOT NULL,
  date_string VARCHAR NOT NULL,
  sgv INT NOT NULL,
  delta FLOAT NOT NULL,
  direction VARCHAR NOT NULL,
  filtered INT NOT NULL,
  unfiltered INT NOT NULL,
  rssi INT NOT NULL,
  noise INT NOT NULL,
  sys_time VARCHAR,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);


-- +micrate Down
DROP TABLE IF EXISTS entries;
