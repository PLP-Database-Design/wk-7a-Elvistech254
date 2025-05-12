-- Question 1
CREATE TABLE ProductDetail1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100)
);

INSERT INTO ProductDetail1NF (OrderID, CustomerName, Product) VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');


-- Question 2


CREATE TABLE OrderDetails1NF (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

INSERT INTO Orders (OrderID, CustomerName) VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');



INSERT INTO OrderItems (OrderID, Product, Quantity) VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);


SELECT 
    OrderID, 
    CustomerName, 
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', n.n), ',', -1)) AS Product
FROM 
    ProductDetail
JOIN (
    SELECT 1 AS n UNION ALL
    SELECT 2 UNION ALL
    SELECT 3 UNION ALL
    SELECT 4 UNION ALL
    SELECT 5
) AS n
ON CHAR_LENGTH(Products) - CHAR_LENGTH(REPLACE(Products, ',', '')) >= n.n - 1;


--- Question 2 Achieving 2NF (Second Normal Form) 🧩

 USE electronistore;
CREATE TABLE OrderDetails (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100),
    Quantity INT
);

INSERT INTO OrderDetails (OrderID, CustomerName, Product, Quantity) VALUES
(101, 'John Doe', 'Laptop', 2),
(101, 'John Doe', 'Mouse', 1),
(102, 'Jane Smith', 'Tablet', 3),
(102, 'Jane Smith', 'Keyboard', 1),
(102, 'Jane Smith', 'Mouse', 2),
(103, 'Emily Clark', 'Phone', 1);



CREATE TABLE Orders AS
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- OrderItems table (OrderID + Product → Quantity)
CREATE TABLE OrderItems AS
SELECT OrderID, Product, Quantity
FROM OrderDetails;