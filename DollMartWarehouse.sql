CREATE DATABASE DollMartWarehouse;
USE DollMartWarehouse;


CREATE TABLE Date_Dimension(
  date_key INT IDENTITY(1,1) PRIMARY KEY,
  date date,
  year INT,
  month INT,
  day INT,
  quater INT
);


CREATE TABLE Country_Dimension(
  country_key INT IDENTITY(1,1) PRIMARY KEY,
  country_name VARCHAR(25),
  state VARCHAR(25),
  city VARCHAR(25)
);

CREATE TABLE Product_Dimension(
  product_key INT IDENTITY(1,1) PRIMARY KEY,
  product_id VARCHAR(25),
  product_description VARCHAR(MAX),
  unit_of_measurement VARCHAR(25),
  qty_in_hand DECIMAL,
  product_type VARCHAR(25),
  product_type_description VARCHAR(MAX),
  product_category VARCHAR(25),
  product_category_description VARCHAR(MAX)
);

CREATE TABLE Customer_Dimension(
  customer_key INT IDENTITY(1,1) PRIMARY KEY,
  customer_id VARCHAR(25),
  name VARCHAR(50),
  address VARCHAR(50),
  segment_id VARCHAR(25),
  segment_name VARCHAR(25),
  start_date date,
  end_date date,
  previouse_address VARCHAR(50)
);

CREATE TABLE Sales(
  date_key INT FOREIGN KEY REFERENCES Date_Dimension(date_key), 
  product_key INT FOREIGN KEY REFERENCES Product_Dimension(product_key),
  customer_key INT FOREIGN KEY REFERENCES Customer_Dimension(customer_key),
  country_key INT FOREIGN KEY REFERENCES Country_Dimension(country_key),
  order_id INT,
  qty DECIMAL,
  unit_price DECIMAL
);








