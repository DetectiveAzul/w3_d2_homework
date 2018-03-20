DROP TABLE bounties;
CREATE TABLE bounties (
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  species VARCHAR(255),
  bounty_value INT,
  danger_level VARCHAR(255),
  last_known_location VARCHAR(255),
  homeworld VARCHAR(255),
  favorite_weapon VARCHAR(255),
  cashed_in VARCHAR(255),
  collected_by VARCHAR(255)
);
