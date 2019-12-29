/* Creating table */

DROP TABLE SalesInformation;
CREATE TABLE SalesInformation
(
  SaleId INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL,
  Product VARCHAR(20),
  Year INTEGER,
  Country VARCHAR(20),
  Sales DECIMAL
) PARTITION BY LIST (Country)(
    PARTITION Country1 VALUES('Country1'),
    PARTITION Country2 VALUES('Country2'),
    PARTITION Country3 VALUES('Country3'),
    PARTITION Country4 VALUES('Country4'),
    PARTITION Country5 VALUES('Country5'),
    PARTITION Country6 VALUES('Country6'),
    PARTITION Country7 VALUES('Country7'),
    PARTITION Country8 VALUES('Country8'),
    PARTITION Country9 VALUES('Country9'),
    PARTITION Country10 VALUES('Country10'),
    PARTITION OtherCountry VALUES(DEFAULT)
);

/* Filling table with data */
DECLARE
  product_counter NUMBER := 1;
  year NUMBER := 2010;
  country_counter NUMBER := 1;
BEGIN

  /* Looping through each product */
  WHILE product_counter < 101
  LOOP
    country_counter := 1;

    /* Looping through each country */
    WHILE country_counter < 11
    LOOP
      year := 2010;

    /* Looping through each year*/
      WHILE year < 2020
      LOOP
        INSERT INTO SalesInformation(Product, Year, Country, Sales)
        VALUES(CONCAT('Product',product_counter), year, CONCAT('Country', country_counter), ROUND(DBMS_RANDOM.VALUE(10000,1000000)));
        year := year + 1;
      END LOOP;

      country_counter := country_counter + 1;
    END LOOP;

    product_counter := product_counter + 1;
  END LOOP;
END;


/* Creating a table without partitions */
DROP TABLE SalesInformationNotPartitioned;
CREATE TABLE SalesInformationNotPartitioned
(
  SaleId INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL,
  Product VARCHAR(20),
  Year INTEGER,
  Country VARCHAR(20),
  Sales DECIMAL,
  PRIMARY KEY (SaleId)
);

/* Filling data */
DECLARE
  product_counter NUMBER := 1;
  year NUMBER := 2010;
  country_counter NUMBER := 1;
BEGIN

  /* Looping through each product */
  WHILE product_counter < 101
  LOOP
    country_counter := 1;

    /* Looping through each country */
    WHILE country_counter < 11
    LOOP
      year := 2010;

    /* Looping through each year*/
      WHILE year < 2020
      LOOP
        INSERT INTO SalesInformationNotPartitioned(Product, Year, Country, Sales)
        VALUES(CONCAT('Product',product_counter), year, CONCAT('Country', country_counter), ROUND(DBMS_RANDOM.VALUE(10000,1000000)));
        year := year + 1;
      END LOOP;

      country_counter := country_counter + 1;
    END LOOP;

    product_counter := product_counter + 1;
  END LOOP;
END;

/* Creating a table with partitions*/
DROP TABLE SalesInformationPartitioned;
CREATE TABLE SalesInformationPartitioned
(
  SaleId INTEGER,
  Product VARCHAR(20),
  Year INTEGER,
  Country VARCHAR(20),
  Sales DECIMAL,
  PRIMARY KEY(SaleId)
) PARTITION BY LIST (Country)(
    PARTITION Country1 VALUES('Country1'),
    PARTITION Country2 VALUES('Country2'),
    PARTITION Country3 VALUES('Country3'),
    PARTITION Country4 VALUES('Country4'),
    PARTITION Country5 VALUES('Country5'),
    PARTITION Country6 VALUES('Country6'),
    PARTITION Country7 VALUES('Country7'),
    PARTITION Country8 VALUES('Country8'),
    PARTITION Country9 VALUES('Country9'),
    PARTITION Country10 VALUES('Country10'),
    PARTITION OtherCountry VALUES(DEFAULT)
);

/* Checking for the possibility of migration*/
BEGIN
   DBMS_REDEFINITION.can_redef_table('NAMDB', 'SalesInformationNotPartitioned');
end;

/* Migrating data*/
BEGIN
  DBMS_REDEFINITION.start_redef_table(
    uname      => 'NAMDB',
    orig_table => 'SalesInformationNotPartitioned',
    int_table  => 'SalesInformationPartitioned');
END;








