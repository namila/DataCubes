/* Creating database */
CREATE DATABASE RollupAndCube;
USE RollupAndCube;


/* Create Table */

CREATE TABLE Products(
  ProductId INT PRIMARY KEY IDENTITY(1,1),
  Product VARCHAR(25),
  ProductType VARCHAR(25),
  ProductCategory VARCHAR(25),
  Sales Decimal
);

/* Filling dummy Data */
DECLARE @cnt INT = 0;

WHILE @cnt < 1000
BEGIN
   INSERT INTO 
     dbo.Products(ProductType, ProductCategory, Product, Sales) 
   VALUES
     (CONCAT('Type', (ABS(CHECKSUM(NEWID()) % 10) + 0)), CONCAT('Category', (ABS(CHECKSUM(NEWID()) % 20) + 0)), CONCAT('Product',@cnt), (ABS(CHECKSUM(NEWID()) % 100000) + 2000)) 
   SET 
     @cnt = @cnt + 1;
END;


/* Summery of the Hierachy (RollUp)*/

SELECT 
  dbo.Products.ProductType, dbo.Products.ProductCategory, dbo.Products.Product, SUM(dbo.Products.Sales) AS Sales
FROM 
  dbo.Products
GROUP BY ROLLUP 
  (dbo.Products.ProductType, dbo.Products.ProductCategory, dbo.Products.Product)


/* Summery of the Every combination (Cube)*/

SELECT 
  dbo.Products.ProductType, dbo.Products.ProductCategory, dbo.Products.Product, SUM(dbo.Products.Sales) AS Sales
FROM 
  dbo.Products
GROUP BY CUBE 
  (dbo.Products.ProductType, dbo.Products.ProductCategory, dbo.Products.Product)
