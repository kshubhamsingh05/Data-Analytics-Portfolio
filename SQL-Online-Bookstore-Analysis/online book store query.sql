

-- Create Database
CREATE DATABASE OnlineBookstore;

-- Switch to the database
 USE OnlineBookstore;

-- Create Tables
DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
    Book_ID INT PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price DECIMAL(10, 2),
    Stock INT
);
DROP TABLE IF EXISTS customers;
CREATE TABLE Customers (
    Customer_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);
DROP TABLE IF EXISTS orders;
CREATE TABLE Orders
(
    Order_ID INT PRIMARY KEY,
    Customer_ID INT,
    Book_ID INT,
    Order_Date VARCHAR(20),
    Quantity INT,
    Total_Amount DECIMAL(10,2),

    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
    FOREIGN KEY (Book_ID) REFERENCES Books(Book_ID)
);

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;


-- import
DELETE FROM Books;

BULK INSERT Books
FROM 'C:\SQL Project\Books.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0D0A'
);


--IMPORT
DELETE FROM Customers;

BULK INSERT Customers
FROM 'C:\SQL Project\Customers.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0D0A'
);

--IMPORT
DELETE FROM Orders;

BULK INSERT Orders
FROM 'C:\SQL Project\Orders.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0D0A'
);


SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;


-- 1) Retrieve all books in the "Fiction" genre:

select * from Books where Genre= 'Fiction'


-- 2) Find books published after the year 1950:
select * from Books where Published_Year >1950;

-- 3) List all customers from the Canada:
select * from Customers where Country = 'Canada';

-- 4) Show orders placed in November 2023:
select * from Orders where Order_Date Between '01-11-2023' AND '30-11-2023';

-- 5) Retrieve the total stock of books available:
  select sum(stock) as [Total stock] from Books; 

-- 6) Find the details of the most expensive book:
select max(price) as [most expensive book] from books;
--or
select TOP 1 * FROM Books 
ORDER BY price DESC;

-- 7) Show all customers who ordered more than 1 quantity of a book:
select * from Orders where Quantity > 1;

-- 8) Retrieve all orders where the total amount exceeds $20:

Select * from orders where Total_Amount > 20;
-- 9) List all genres available in the Books table:
select distinct Genre from Books ;

-- 10) Find the book with the lowest stock:
select min(Stock) as [lowest stock] from Books;
--or
select * from books order by Stock asc;

-- 11) Calculate the total revenue generated from all orders:
select sum(Total_Amount) as [Total Revenue] from Orders;




SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

-- Advance Questions : 

-- 1) Retrieve the total number of books sold for each genre:
select b.Genre, sum( o.Quantity) as Tpotal_sold_books from
Orders o join Books B 
on O.Book_ID = B.Book_ID
Group By b.Genre;


-- 2) Find the average price of books in the "Fantasy" genre:

select avg(Price) as averageprice from Books where Genre = 'Fantasy';

-- 3) List customers who have placed at least 2 orders:


 SELECT o.Customer_ID,  c.Name, COUNT(o.Order_ID) as Order_Count
FROM Orders o join customers c on o.Customer_ID = c.Customer_ID
GROUP BY o.Customer_ID , c.name 
HAVING COUNT(Order_ID) >= 2;

-- 4) Find the most frequently ordered book:
select top(1) b.Book_ID, b.Title,count( o.Order_ID) as ORDER_COUNT
from Orders o join Books B on O.Book_ID = B.Book_ID
group by b.Book_ID , b.Title
order by ORDER_COUNT desc  ;
-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
select Top(3) * from Books
where Genre='Fantasy'
order by price desc;


-- 6) Retrieve the total quantity of books sold by each author:
select  b.Author, sum(o.quantity) as Total_Books_Sold from Orders o join Books b on o.Book_ID=b.Book_ID
group by b.Author;

-- 7) List the cities where customers who spent over $30 are located:
select c.city, o. Total_Amount from Orders o join customers c on c.Customer_ID = o.Customer_ID 
where o.Total_Amount >30;

-- 8) Find the customer who spent the most on orders:
select c.customer_id, c.name, sum(o.total_amount) as total_spent
from Orders o
join customers c on o.Customer_ID=c.Customer_ID
group by c.Customer_ID, c.name 
order by total_spent desc;



