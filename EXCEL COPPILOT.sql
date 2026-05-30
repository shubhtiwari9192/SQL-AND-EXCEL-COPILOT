create database assignments;

use assignments;
-- Question 1
-- Create Table and Insert 10,000 Rows

CREATE TABLE SalesData (
    CustomerID INT,
    Name VARCHAR(100),
    Age INT,
    City VARCHAR(50),
    PurchaseAmount DECIMAL(10,2),
    PurchaseDate DATE
);


DELIMITER $$

CREATE PROCEDURE InsertRandomData()
BEGIN
    DECLARE i INT DEFAULT 1;

    WHILE i <= 10000 DO

        INSERT INTO SalesData (
            CustomerID,
            Name,
            Age,
            City,
            PurchaseAmount,
            PurchaseDate
        )

        VALUES (
            i,
            CONCAT('Customer_', i),
            FLOOR(20 + (RAND() * 40)),

            ELT(FLOOR(1 + (RAND() * 5)),
                'Delhi',
                'Mumbai',
                'Kolkata',
                'Chennai',
                'Bangalore'
            ),

            ROUND(100 + (RAND() * 5000), 2),

            DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND() * 365) DAY)
        );

        SET i = i + 1;

    END WHILE;

END$$

DELIMITER ;

CALL InsertRandomData();

SELECT * FROM SalesData;

-- Question 2
-- Find Total Sales Per City
SELECT City,
       SUM(PurchaseAmount) AS TotalSales
FROM SalesData
GROUP BY City;

-- Top 5 Cities by Revenue
SELECT City,
       SUM(PurchaseAmount) AS TotalRevenue
FROM SalesData
GROUP BY City
ORDER BY TotalRevenue DESC
LIMIT 5;


-- Question 3
-- Customers with Purchases Above Average
SELECT *
FROM SalesData
WHERE PurchaseAmount >
(
    SELECT AVG(PurchaseAmount)
    FROM SalesData