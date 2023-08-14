-------------------
---Part-1

DROP DATABASE IF EXISTS EerciseDb
DROP TABLE IF EXISTS ProductInfo
DROP TABLE IF EXISTS CompanyInfo

-- Create the database
CREATE DATABASE ExerciseDb;

-- Use the created database
USE ExerciseDb;

-- Create CompanyInfo table
CREATE TABLE CompanyInfo (
    CId INT PRIMARY KEY,
    CName VARCHAR(255)
);

-- Insert data into CompanyInfo table
INSERT INTO CompanyInfo (CId, CName)
VALUES
    (1, 'Samsung'),
    (2, 'HP'),
    (3, 'Apple'),
    (4, 'Dell'),
    (5, 'Toshiba'),
    (6, 'Redmi');

-- Create Productlnfo table
CREATE TABLE ProductInfo (
    PId INT PRIMARY KEY,
    PName VARCHAR(255),
    PPrice DECIMAL(10, 2),
	PMDate DATE,
	CId int,
	FOREIGN KEY (CId) REFERENCES CompanyInfo(CId) 
);
-- Insert data into Productlnfo table
INSERT INTO ProductInfo (PId, PName, PPrice,PMDate,CId)
VALUES
    (101, 'Laptop', 55000.90,'12/12/2023',1),
    (102, 'Laptop', 35000.90,'12/12/2012',2),
    (103, 'Mobile', 15000.90,'12/03/2012',2),
    (104, 'Laptop', 135000.90,'12/12/2012',3),
    (105, 'Mobile', 65000.90,'12/12/2012',3),
    (106, 'Laptop', 35000.90,'12/12/2012',5),
    (107, 'Mobile', 35000.90,'12/01/2022',5),
    (108, 'Earpod', 1000.90,'12/01/2022',3),
    (109, 'Laptop', 85000.90,'12/12/2021',6),
    (110, 'Mobile',55000.70,'12/12/2020',1);


SELECT C.CName AS CompanyName, P.PId, P.PName, P.PPrice, P.PMDate
FROM CompanyInfo C
LEFT JOIN ProductInfo P ON C.Cid = P.CId;

SELECT P.PName AS ProductName, C.CName AS CompanyName
FROM ProductInfo P
INNER JOIN CompanyInfo C ON P.CId = C.Cid;

SELECT C.CName as CompanyName,P.PName AS ProductName
FROM CompanyInfo C
CROSS JOIN ProductInfo P;

-----------------------------
--PART-2
CREATE TABLE Products (
    PId INT PRIMARY KEY,
    PQ INT,
    PPrice float,
    Discount float
);

-- Insert records into Products table
INSERT INTO Products (PId, PQ, PPrice, Discount)
VALUES
    (1, 5, 100.00, 10.00),
    (2, 10, 50.00, 5.00),
    (3, 2, 200.00, 15.00);

CREATE FUNCTION dbo.CalculateDiscountedPrice(@price FLOAT, @discount FLOAT)
RETURNS FLOAT
AS
BEGIN
    DECLARE @discounted_price FLOAT;
    SET @discounted_price = @price - (@price * @discount / 100);
    RETURN @discounted_price;
END;

SELECT PId,
       PPrice AS Price,
       Discount,
       dbo.CalculateDiscountedPrice(PPrice, Discount) AS PriceAfterDiscount
FROM Products;