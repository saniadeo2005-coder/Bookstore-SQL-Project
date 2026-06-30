
--CREATED BOOKS TABLE 
CREATE TABLE Books1(
			Book_ID	INT ,
			Title	VARCHAR (150),
			Author	VARCHAR (100),
			Genre	VARCHAR (50),
			Published_Year	INT ,
			Price	NUMERIC (10,2),
			Stock	INT 

)
--CREATED Customers Table
CREATE TABLE Customers1
(
			Customer_ID	INT PRIMARY KEY,
			Name	VARCHAR (100) NOT NULL,
			Email	VARCHAR (150) NOT NULL,
			Phone	NUMERIC(10),
			City	VARCHAR (50),
			Country	VARCHAR (50)

)

--CREATED ORDERS TABLE 
CREATE TABLE Orders1(
			Order_ID	INT PRIMARY KEY,
			Customer_ID	INT ,
			Book_ID	DATE,
			Order_Date	INT,
			Quantity	INT,
			Total_Amount NUMERIC (10,2)

)
ALTER TABLE Orders1
ALTER COLUMN Customer_
SELECT * FROM Customers1;
SELECT * FROM Books1;
SELECT * FROM Orders1;


-- Import Book CSV file
COPY Books1 (Book_ID,	Title,	Author,	Genre,	Published_Year,	Price, Stock
)
FROM 'D:/Itz Aysh/SANIA\SQL_Project for portfolio/Books.csv'
CSV HEADER;

SELECT * FROM Customers1;
SELECT * FROM Books1;
SELECT * FROM Orders1;

--1 Retrieve all books in the "fiction " genre:
SELECT * FROM Books1
WHERE Genre='Fiction';

--2 find books published after the year 2016:
SELECT * FROM Customers1
WHERE published_Year>2016;

--3 List all customers from the CANADA:
SELECT * FROM Customers1
WHERE country='Canada';

--4 Show orders placed in '2023-05-26' to '2023-07-26':
SELECT * FROM Orders1
WHERE Order_date BETWEEN '2023-05-26' AND '2023-07-26';

--5 Retrieve the total stock of the books available :
SELECT SUM(stock) AS Total_stock FROM Books1;

--6 Find the datailes of the most expansive 5 books:
SELECT  * FROM Books1 ORDER BY Price DESC LIMIT 5;

--7 Show all customers who orders more than 1 quantity of a book:
SELECT * FROM Orders1
WHERE quantity>6;

--8 List all genres available in the books table:
SELECT DISTINCT genre FROM Books1;

--9 Find the books with the lowest price stock:
SELECT * FROM Books1 ORDER BY stock LIMIT 5 ;

-- 10 Calculate the total revenue genrated from all orders:
SELECT SUM(total_amount) AS Revenue FROM Orders;

--ADVANCE QUESTIONS :
-- 1 retrieve the total number of books sold for each genra :
SELECT b.Genre, SUM(o.Quantity) AS total_books_sold FROM Orders1 o
JOIN Books1 b ON o.book_id = b.book_id
GROUP BY b.Genre;


-- 2 find the average price of books in the "Fantasy" genre:
SELECT AVG (price) AS Average_price FROM Books1 
WHERE Genre = 'Fantasy';

-- 3 list Customers who placed at least 2 orders:
SELECT o.customer_id, c.name , COUNT (o.order_id) AS Order_count FROM Orders1 o 
JOIN Customers1 c ON o.customer_id=c.customer_id
GROUP BY 	O.CUSTOMER_id ,c.name
HAVING COUNT(order_id) >=2 ;

-- 4 Find the most frequently ordered book:
SELECT o.Book_id, b.title, COUNT (o.order_id) AS order_count FROM Orders1 o
JOIN Books1 b on o.book_id=b.book_id
GROUP BY o.book_id , b.title
ORDER BY order_count DESC LIMIT 1;

--Show the 3 most expensive books of 'Fantasy' Genre :
SELECT * FROM Books1
WHERE genre='Fantasy'
ORDER BY Price DESC LIMIT 3;

-- 6 Retrieve the total quantity of books sold by each autho:
SELECT b.author, SUM(o.quantity) AS total_books_sold FROM Orders1 o
JOIN Books1 b ON o.book_id=b.book_id
GROUP BY b.author;

-- 7 list the city where customers who spend over $30ar located:
SELECT DISTINCT c.city, total_Amount FROM Orders1 o
join Customers1 c ON o.customer_id=c.customer_id
WHERE o.total_Amount > 200;

-- 8 find the Customer who spend the most on orders:
SELECT c.customer_id, c.name , SUM(o.total_amount) AS total_spend FROM Orders o
JOIN Customers1 c ON O.customer_id = C.customer_id
GROUP BY c.customer_id
ORDER BY total_spend DESC;

-- 9 Calculate the stock remaining after fulfilling all orders:
SELECT b.book_id,b.title,b.stock,
COALESCE(SUM(o.quantity),0) AS order_quantity, b.stock - COALESCE(SUM(o.quantity),0) AS remaining_stock
FROM Books1 b
LEFT JOIN Orders1 o 
ON b.book_id = o.book_id
GROUP BY  b.book_id, b.title, b.stock
ORDER BY  b.stock;
   




