CREATE DATABASE DollMartDatabase;
USE DollMartDatabase;



CREATE TABLE Customer_Segment(
  seg_id VARCHAR(25) PRIMARY KEY,
  segment_name VARCHAR(25)
);

CREATE TABLE Customer(
  customer_id VARCHAR(25) PRIMARY KEY,
  name VARCHAR(50),
  address VARCHAR(50),
  state VARCHAR(25),
  city VARCHAR(25),
  country VARCHAR(25),
  customer_segment VARCHAR(25) FOREIGN KEY REFERENCES Customer_Segment(seg_id)
);


CREATE TABLE Product_Cat(
  prod_cat VARCHAR(25) PRIMARY KEY,
  description VARCHAR(MAX)
);

CREATE TABLE Product_Type(
  prod_type VARCHAR(25) PRIMARY KEY,
  description VARCHAR(MAX),
  prod_cat VARCHAR(25) FOREIGN KEY REFERENCES Product_Cat(prod_cat)
);

CREATE TABLE Product(
  product_id VARCHAR(25) PRIMARY KEY,
  description VARCHAR(MAX),
  unit_of_measurement VARCHAR(25),
  qty_in_hand Decimal,
  prod_type VARCHAR(25) FOREIGN KEY REFERENCES Product_Type(prod_type)
);


CREATE TABLE Order_Header(
  order_id VARCHAR(25) PRIMARY KEY,
  date Date,
  customer VARCHAR(25)
);

CREATE TABLE Order_Detail(
  order_id VARCHAR(25) FOREIGN KEY REFERENCES Order_Header(order_id),
  product_id VARCHAR(25) FOREIGN KEY REFERENCES Product(product_id),
  qty Decimal,
  unit_price Decimal 
);
