-- PART 1. 

USE expense_tracker;

--  Q 1.1: Retrieve all data points (columns) from the "Expenses" table.
SELECT * FROM Expenses;


-- Q 1.2: Select only specific columns relevant to your analysis 
SELECT category, SUM(amount) AS Total_Category_Amount
FROM Expenses
GROUP BY category 
ORDER BY Total_Category_Amount DESC;

-- Q 1.3 Retrieve expenses charged between a specific date range (e.g., January 1, 2021, to December 15, 2024).
--  Remember to use the appropriate data type for the "date" column when specifying the date range in your query

-- Function to retrieve expenses between a specific date range. 
DELIMITER //

CREATE FUNCTION Expenses_Charged(startDate DATE, endDate DATE)
RETURNS INT
READS SQL DATA
DETERMINISTIC
BEGIN
	DECLARE Expenses_Dated INT;
	SELECT SUM(amount) INTO Expenses_Dated
	FROM Expenses
	WHERE date BETWEEN startDate AND endDate;
    RETURN Expenses_Dated;
    
END // 

DELIMITER ;

SELECT Expenses_Charged('2022-03-14', '2023-08-14') AS Total_Expenses;

-- PART 2. 
-- Q 2.1 : Find all expenses belonging to a specific category (e.g., "Entertainment").

DELIMITER //
CREATE FUNCTION Category_Expenses(category_chosen text)
RETURNS INT
READS SQL DATA
DETERMINISTIC
BEGIN
	SELECT category, SUM(amount) AS Total_Category_Amount
	FROM Expenses
    WHERE category = category_chosen;
 END //
 DELIMITER ;
 
 SELECT Category_Expenses('Others');
 
 -- Q 2.2 :  Find expenses with an amount greater than a certain value (e.g., $50)
  SELECT category, amount FROM expenses WHERE amount > 50;
  
  -- Q 2.3 : Refine your query to find expenses that meet multiple criteria. 
  --         For example, you might search for expenses greater than $75 AND belonging to the "Food" category.
  
  DELIMITER //
  CREATE PROCEDURE Find_Expense(category_chosen TEXT)
	BEGIN
	SELECT category, amount FROM expenses WHERE category = category_chosen AND amount > 75;
	END //
    
 Call Find_Expense('Entertainment'); 
 
 -- Q 2.4 : Modify your query to find expenses belonging to one category or another (e.g., "Transportation" OR "Groceries").
 
 DELIMITER //

CREATE PROCEDURE Category_Chosen (category1 TEXT, category2 TEXT)
BEGIN
    SELECT category, amount 
    FROM expenses 
    WHERE category = category1 OR category = category2;
END //

DELIMITER ;

 -- Q 2.5 : Write a query to display expenses unrelated to a specific category (e.g., "Rent").
DELIMITER //
CREATE PROCEDURE Category_Not_Chosen(category_not text)
BEGIN
	SELECT category, amount FROM expenses WHERE category != category_not;
END //

Call Category_Not_Chosen('Entertainment');
 
 
 -- PART 3
 -- Q 3.1 : Write a query to display all expenses sorted by amount in a specific order 
 --         (e.g., descending order for highest to lowest spending).
  SELECT category, amount FROM expenses ORDER BY amount DESC;
  
  -- Q 3.2 : Modify your query to sort expenses based on multiple columns. 
  --         For example, you might sort first by date (descending order) and then by category (ascending order) to see recent spending trends by category.
   
SELECT * FROM expenses ORDER BY amount DESC, date DESC, category ;

 -- PART 4 
 
   -- Q 4.1 :  Create a table named "Income" 
   
   CREATE TABLE Income (
   income_id INT PRIMARY KEY,
   amount DECIMAL(10,2) NOT NULL,
   date DATE NOT NULL,
   source VARCHAR(50) NOT NULL);
   
   -- Q 4.2 : Add a new column named "category" of type VARCHAR(50).
   
   ALTER TABLE Income
   ADD COLUMN category VARCHAR(50) NOT NULL;
   
   -- Q 4.3 : Remove the "source" column from the "Income" table.
   
    ALTER TABLE Income DROP COLUMN source;
-- Create the database (adjust the name if needed)
-- CREATE DATABASE IF NOT EXISTS expense_tracker;

-- Use the expense_tracker database
-- USE expense_tracker;

-- Create the Expenses table
-- CREATE TABLE IF NOT EXISTS Expenses (
--   expense_id INT PRIMARY KEY AUTO_INCREMENT,
--   amount DECIMAL(10,2) NOT NULL,
--   date DATE NOT NULL,
--   category VARCHAR(50) NOT NULL
-- );

-- Function to generate random date within a specific range (modify as needed)
-- DELIMITER //

-- CREATE FUNCTION GetRandomDate(startDate DATE, endDate DATE)
-- RETURNS DATE
-- READS SQL DATA
-- DETERMINISTIC
-- BEGIN
--   DECLARE randomDays INT;
--   SET randomDays = FLOOR(RAND() * (DATEDIFF(endDate, startDate) + 1));
--   RETURN DATE_ADD(startDate, INTERVAL randomDays DAY);
-- END; //

-- DELIMITER ;

-- Stored Procedure to insert sample data with random dates and categories (categories can be modified)
-- DELIMITER //

-- CREATE PROCEDURE InsertSampleData()
-- BEGIN
--   DECLARE counter INT DEFAULT 1;

--   WHILE counter <= 20 DO
--     INSERT INTO Expenses (amount, date, category)
--     VALUES (FLOOR(10 + RAND() * 100),
--             GetRandomDate(DATE_SUB(CURDATE(), INTERVAL 4 YEAR), CURDATE()),  -- Random date within the last 4 years
--             CASE WHEN counter % 4 = 0 THEN 'Groceries'
--                  WHEN counter % 4 = 1 THEN 'Entertainment'
--                  WHEN counter % 4 = 2 THEN 'Transportation'
--                  ELSE 'Other'
--             END);
--     SET counter = counter + 1;
--   END WHILE;
-- END; //

-- DELIMITER ;

-- Call the procedure to insert sample data
-- CALL InsertSampleData();

-- Drop the functions and procedures if they are no longer needed
-- DROP PROCEDURE IF EXISTS InsertSampleData;
-- DROP FUNCTION IF EXISTS GetRandomDate;


   


 


