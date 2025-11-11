-- Step 1: Create the Database
DROP DATABASE IF EXISTS Car_ShowRoom;
CREATE DATABASE Car_ShowRoom;
USE Car_ShowRoom;

-- Step 2: Create Cars Table
DROP TABLE IF EXISTS cars;
CREATE TABLE cars (
    Car_ID VARCHAR(100) PRIMARY KEY,
    Brand VARCHAR(100),
    Model VARCHAR(100),
    Year INT,
    Color VARCHAR(100),
    Engine_Type VARCHAR(100),
    Transmission VARCHAR(100),
    Price FLOAT,
    Quantity_In_Stock INT,
    Status VARCHAR(100)
);

-- Load Cars Data
SET GLOBAL local_infile = 1;
LOAD DATA LOCAL INFILE 'C:/Users/Lenovo/OneDrive/Documents/SQL Programming/Cars.csv'
INTO TABLE cars
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

-- Step 3: Create Customers Table
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
    Customer_ID VARCHAR(100) PRIMARY KEY,
    Name VARCHAR(100),
    Gender VARCHAR(100),
    Age INT,
    Phone VARCHAR(100),
    Email VARCHAR(100),
    City VARCHAR(100)
);

-- Load Customers Data
LOAD DATA LOCAL INFILE 'C:/Users/Lenovo/OneDrive/Documents/SQL Programming/Customers.csv'
INTO TABLE customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

-- Step 4: Create Sales Table
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (
    Sale_ID VARCHAR(100) PRIMARY KEY,
    Customer_ID VARCHAR(100),
    Car_ID VARCHAR(100),
    Sale_Date DATE,
    Quantity INT,
    Sale_Price FLOAT,
    Payment_Method VARCHAR(100),
    Salesperson VARCHAR(100),
    FOREIGN KEY (Car_ID) REFERENCES cars(Car_ID),
    FOREIGN KEY (Customer_ID) REFERENCES customers(Customer_ID)
);

-- Load Sales Data
LOAD DATA LOCAL INFILE 'C:/Users/Lenovo/OneDrive/Documents/SQL Programming/Sales.csv'
INTO TABLE sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

-------------------------------------------------------------------------------------------------------
 #                           1. Sales Performance & Revenue Insights
 
# Q.1) What is the total revenue generated from all car sales? 

SELECT ROUND(SUM(Sale_Price * Quantity),2) AS Total_Revenue
FROM sales ;

# Q.2) Which car brand or model has the highest total sales revenue?

SELECT c.Brand, c.Model, 
       ROUND(SUM(s.Quantity * s.Sale_Price),2) Highest_Total_Sales
        FROM cars AS c
JOIN sales AS s
ON c.Car_ID = s.Car_ID
GROUP BY c.Brand, c.Model
ORDER BY Highest_Total_Sales DESC
LIMIT 1 ;

# Q.3) Which month or year had the highest number of car sales?

SELECT MONTH(Sale_Date) AS Month,
       YEAR(Sale_Date) AS Year,
       SUM(Quantity) AS Total_Cars_Sales
FROM sales 
GROUP BY MONTH(Sale_Date),
         YEAR(Sale_Date)
ORDER BY Total_Cars_Sales DESC
LIMIT 1 ;

# Q.4) What is the average sale price of cars sold overall?

SELECT ROUND(AVG(Sale_Price),2) AS Avg_Sales_Price 
FROM sales ;

# Q.5) Who are the top 5 salespersons by total sales amount?

SELECT * FROM 
(SELECT *,
DENSE_RANK() OVER(ORDER BY Sale_Price DESC) AS Salespersons_Ranking
FROM sales) AS T1 
LIMIT 5 ;

# Q.6) What are the top 5 most sold car models by quantity?

SELECT c.Model, SUM(s.Quantity) AS Total_Quantity_Sold
FROM cars AS c
LEFT JOIN sales AS s
ON c.Car_ID = s.Car_ID
GROUP BY c.Model
ORDER BY Total_Quantity_Sold DESC 
LIMIT 5 ;

# Q.7) Which payment method (cash, loan, credit) is most preferred by customers?

SELECT Payment_Method, 
       COUNT(*) AS Total_Count
FROM sales
GROUP BY Payment_Method
ORDER BY Total_Count DESC ;

# Q.8) What is the average quantity sold per sale transaction?

SELECT AVG(Quantity) AS Avg_Quantity
FROM sales ;

# Q.9) What is the total number of cars sold vs. total cars in stock?

SELECT SUM(s.Quantity) AS Total_Car_Sold , 
       SUM(c.Quantity_In_Stock) AS Total_Car_Stock
FROM cars AS c
JOIN sales AS s
ON c.Car_ID = s.Car_ID ;

# Q.10) Which car color sells the most and which sells the least?

-- Most Sold Color
SELECT 
    Color AS Most_Sold_Color,
    SUM(s.Quantity) AS Total_Sales
FROM 
    cars AS c
JOIN 
    sales AS s 
ON 
    c.Car_ID = s.Car_ID
GROUP BY 
    Color
ORDER BY 
    Total_Sales DESC
LIMIT 1;

-- Least Sold Color
SELECT 
    Color AS Least_Sold_Color,
    SUM(s.Quantity) AS Total_Sales
FROM 
    cars AS c
JOIN 
    sales AS s 
ON 
    c.Car_ID = s.Car_ID
GROUP BY 
    Color
ORDER BY 
    Total_Sales ASC
LIMIT 1;


 #                            2. Customer Insights & Segmentation
 
 # Q.11) What is the average age of customers purchasing cars?
 
SELECT ROUND(AVG(Age),2) AS Avg_Age 
FROM customers ;

# Q.12)  Which city contributes the most to total sales?
 
SELECT c.City, ROUND(SUM(s.Sale_Price * s.Quantity),2) AS Total_Sales
FROM 
customers AS c
LEFT JOIN sales AS s
ON c.Customer_ID = s.Customer_ID
GROUP BY c.City
ORDER BY Total_Sales DESC 
LIMIT 1 ;
 
# Q.13) Who are the repeat customers (customers appearing in multiple sales)?
 
SELECT *
FROM sales
WHERE Customer_ID IN (
    SELECT Customer_ID
    FROM sales
    GROUP BY Customer_ID
    HAVING COUNT(*) > 1
);

# Q.14) Do male or female customers tend to buy higher-priced cars?

SELECT 
    cu.Gender,
    ROUND(MIN(c.Price), 2) AS Min_Price,
    ROUND(MAX(c.Price), 2) AS Max_Price
FROM cars AS c
JOIN sales AS s
    ON c.Car_ID = s.Car_ID
JOIN customers AS cu
    ON cu.Customer_ID = s.Customer_ID
GROUP BY cu.Gender;

# Q.15) Which age group (e.g., <25, 25–40, 40–60, 60+) purchases the most cars?

SELECT 
	CASE 
		WHEN Age < 25 THEN '< 25' 
        WHEN Age BETWEEN 25 AND 40 THEN '25-40'
        WHEN Age BETWEEN 40 AND 60 THEN '40-60'
ELSE '60+'
END AS Age_Group ,
COUNT(Quantity) AS Total_Sold_Cars 
FROM customers AS c
LEFT JOIN sales AS s
ON c.Customer_ID = s.Customer_ID 
GROUP BY Age
ORDER BY Total_Sold_Cars DESC ;

# Q.16) Which customers have spent the highest total amount overall?

SELECT c.Customer_ID, ROUND(SUM(s.Quantity * s.Sale_Price),2) AS Total_Amount FROM 
customers AS c
RIGHT JOIN sales AS s
ON c.Customer_ID = s.Customer_ID
GROUP BY c.Customer_ID
ORDER BY Total_Amount DESC ;

# Q.17) Which city or region has the highest average purchase value?

SELECT c.City, ROUND(AVG(s.Quantity * s.Sale_Price),2) AS Avg_Purchase 
FROM customers AS c
LEFT JOIN sales AS s
ON c.Customer_ID = s.Customer_ID
GROUP BY c.City
ORDER BY Avg_Purchase DESC ;

# Q.18) How many new vs. returning customers make up total sales?

# New Customers 

SELECT * FROM customers
WHERE Customer_ID IN
(SELECT c.Customer_ID
FROM customers AS c
LEFT JOIN sales AS s
ON c.Customer_ID = s.Customer_ID
GROUP BY c.Customer_ID
HAVING COUNT(*) = 1 ) ;


# Returning customers

SELECT * FROM customers
WHERE Customer_ID IN
(SELECT c.Customer_ID
FROM customers AS c
LEFT JOIN sales AS s
ON c.Customer_ID = s.Customer_ID
GROUP BY c.Customer_ID
HAVING COUNT(*) > 1 ) ;

# Q.19) What is the most common car type or engine type preferred by customers?


SELECT 
    c.Car_ID,
    c.Brand,
    c.Model,
    c.Engine_Type,
    s.Sale_ID,
    s.Sale_Date,
    s.Quantity,
    s.Sale_Price,
    cr.Customer_ID,
    cr.Name
FROM cars AS c
JOIN sales AS s
    ON c.Car_ID = s.Car_ID
LEFT JOIN customers AS cr
    ON cr.Customer_ID = s.Customer_ID
WHERE c.Engine_Type = (
    SELECT c.Engine_Type
    FROM cars AS c
    JOIN sales AS s
        ON c.Car_ID = s.Car_ID
    GROUP BY c.Engine_Type
    ORDER BY COUNT(*) DESC
    LIMIT 1
);

# Q.20)	Do younger or older customers prefer automatic vs. manual transmission?

SELECT 
    CASE 
        WHEN cr.Age < 40 THEN 'Younger'
        ELSE 'Older'
    END AS Age_Group,
    c.Transmission,
    COUNT(*) AS Total_Customers
FROM cars AS c
JOIN sales AS s
    ON c.Car_ID = s.Car_ID
LEFT JOIN customers AS cr
    ON cr.Customer_ID = s.Customer_ID
GROUP BY Age_Group, c.Transmission
ORDER BY Age_Group, Total_Customers DESC;


 #                             3. Inventory & Stock Management


# Q.21)	Which cars are low in stock (below a threshold, e.g., <5 units)?

SELECT Brand, Model, Quantity_In_Stock
FROM cars
WHERE Quantity_In_Stock < 5 ;

# Q.22) Which cars are in stock but have zero sales (unsold inventory)?

SELECT * FROM 
        cars AS c
LEFT JOIN sales AS s
ON c.Car_ID = s.Car_ID
WHERE c.Car_ID IS NULL 
	  AND c.Quantity_In_Stock > 1 ;


# Q.23) What is the total value of inventory currently in stock?

SELECT ROUND((Price * Quantity_In_Stock),2) AS Total_Inventory_Value
FROM cars ;


# Q.24) How long (on average) does it take for a car to sell after being stocked?

SELECT 
    ROUND(AVG(YEAR(s.Sale_Date) - c.Year), 2) AS Avg_Years_To_Sell
FROM cars AS c
JOIN sales AS s 
    ON c.Car_ID = s.Car_ID;

# Q.25) Which brands or models have the fastest turnover rates?

SELECT 
    c.Brand,
    c.Model,
    ROUND(AVG(YEAR(s.Sale_Date) - c.Year), 2) AS Avg_Days_To_Sell
FROM cars AS c
JOIN sales AS s 
    ON c.Car_ID = s.Car_ID
GROUP BY c.Brand, c.Model
ORDER BY Avg_Days_To_Sell DESC ;

# Q.26) Are there any trends in stockouts for popular models or colors?

SELECT Brand, Color, 
       COUNT(*) AS Stockout_Count
 FROM cars 
WHERE Quantity_In_Stock = 0 
GROUP BY Brand, Color
ORDER BY Stockout_Count DESC ;


 #                             4. Profitability & Growth

# Q.27) Which car model gives the highest profit margin (Sale_Price vs. Cost_Price if available)?

SELECT c.Model,
       ROUND(AVG(s.Sale_Price),2) AS Avg_Sale_Price,
       ROUND(AVG(s.Sale_Price - c.Price),2) AS Avg_profit_margin
FROM cars AS c
JOIN sales AS s
ON c.Car_ID = s.Car_ID 
GROUP BY c.Model
ORDER BY Avg_profit_margin DESC ;

# Q.28) What is the monthly growth rate of total sales revenue?

SELECT 
    DATE_FORMAT(s.Sale_Date, '%Y-%m') AS Month,
    ROUND(SUM(s.Sale_Price), 2) AS Total_Revenue
FROM sales AS s
GROUP BY DATE_FORMAT(s.Sale_Date, '%Y-%m')
ORDER BY Month;

# Q.29) Which salesperson shows the most consistent sales performance over time?

SELECT 
    s.Salesperson,
    DATE_FORMAT(s.Sale_Date, '%Y-%m') AS Month,
    SUM(s.Sale_Price) AS Monthly_Sales
FROM sales AS s
GROUP BY s.Salesperson, DATE_FORMAT(s.Sale_Date, '%Y-%m')
ORDER BY s.Salesperson, Month;


# Q.30) 30.	What are the top 3 strategies (based on data) to increase sales — e.g., targeting high-spending customers, restocking fast-selling models, or promoting low-sale brands?

SELECT 
    Customer_ID,
    SUM(Sale_Price) AS Total_Spent
FROM sales
GROUP BY Customer_ID
ORDER BY Total_Spent DESC
LIMIT 10;  -- top customers



SELECT 
    c.Brand,
    SUM(s.Sale_Price) AS Total_Sales,
    SUM(c.Quantity_In_Stock) AS Remaining_Stock
FROM cars AS c
LEFT JOIN sales AS s ON c.Car_ID = s.Car_ID
GROUP BY c.Brand
ORDER BY Total_Sales ASC;


--------------------------------------------------------------------------------------------------------
