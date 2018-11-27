-- +micrate Up
CREATE TABLE entries (
  id BIGSERIAL PRIMARY KEY,
  device VARCHAR,
  date_string TIMESTAMP,
  sgv INT,
  delta FLOAT,
  direction VARCHAR,
  filtered INT,
  unfiltered INT,
  rssi INT,
  noise INT,
  sys_time TIMESTAMP,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);


-- +micrate Down
DROP TABLE IF EXISTS entries;
