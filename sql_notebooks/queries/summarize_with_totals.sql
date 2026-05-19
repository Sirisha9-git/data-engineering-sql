--Summarize each category and keep only those with 3+ orders
--------------------------------------------------------------
--Source table and data.

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    category VARCHAR(50) NOT NULL,
    amount DECIMAL(10,2) NOT NULL
);

INSERT INTO orders (order_id, category, amount) VALUES
(1, 'Electronics', 120.50),
(2, 'Electronics', 89.99),
(3, 'Electronics', 240.00),
(4, 'Electronics', 310.75),
(5, 'Electronics', 150.25),
(6, 'Books', 19.99),
(7, 'Books', 12.49),
(8, 'Clothing', 45.00),
(9, 'Clothing', 60.00),
(10, 'Clothing', 35.50);

select * from orders;

-- Summarize each category and keep only those with 3+ orders
select 
category,
sum(amount) as total_amount
from orders 
group by category
having count(*)>=3
