DROP TABLE IF EXISTS properties;

CREATE TABLE properties (
  id SERIAL4 PRIMARY KEY,
  value INT2,
  number_of_bedrooms INT2,
  year_built INT2,
  buy_let_status BOOLEAN
);
