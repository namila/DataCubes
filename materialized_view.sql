
CREATE DATABASE MaterializedExample;
USE  MaterializedExample;

/* Creating the table */
CREATE TABLE Products(
  ProductID INT PRIMARY KEY IDENTITY(1,1),
  Product VARCHAR(25),
  Date VARCHAR(25),
  Sales Decimal
);

/* Filling dummy data */
DECLARE @cnt INT = 0;

WHILE @cnt < 1000
BEGIN
   INSERT INTO Products(Product, Date, Sales) VALUES(CONCAT('Product',@cnt), (ABS(CHECKSUM(NEWID()) % 20) + 2010),(ABS(CHECKSUM(NEWID()) % 100000) + 2000)) 
   SET @cnt = @cnt + 1;
END;



 DECLARE @columns NVARCHAR(MAX) = '';
 DECLARE @query NVARCHAR(MAX) = '';

/* Creating the column list of Dates */
 SELECT 
   @columns += QUOTENAME(UniqueDate) + ','
 FROM (
 SELECT 
   DISTINCT dbo.Products.Date AS UniqueDate  
 FROM 
   dbo.Products
 ) temp
 ORDER BY
   UniqueDate

 SET @columns = LEFT(@columns, LEN(@columns) - 1)

 /* Creating the query*/
 SET @query = '
 CREATE VIEW ProductView WITH SCHEMABINDING AS
   SELECT Product, '+@columns+' FROM (
     SELECT 
	   Date,
	   Product,
	   Sales
	FROM
	  dbo.Products
   ) temp
   PIVOT(
     SUM(Sales)
	 FOR Date IN ('+@columns+')
   ) AS PivotTable;
 ';

 /* Executing the query*/
 EXECUTE sp_executesql @query;
 
 

 SELECT * FROM ProductView
 DROP VIEW ProductView



