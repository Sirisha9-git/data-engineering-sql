

-- Source table and data
CREATE TABLE products_sales (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    sales_amount DECIMAL(10,2) NOT NULL
);

INSERT INTO products_sales (product_id, product_name, category, sales_amount) VALUES
(1, 'iPhone 15', 'Electronics', 95000.00),
(2, 'Samsung S24', 'Electronics', 88000.00),
(3, 'Sony Headphones', 'Electronics', 42000.00),
(4, 'Dell XPS 13', 'Electronics', 76000.00),
(5, 'iPad Air', 'Electronics', 54000.00),
(6, 'Nike Air Max', 'Footwear', 30000.00),
(7, 'Adidas Ultraboost', 'Footwear', 45000.00),
(8, 'Puma Runner', 'Footwear', 18000.00),
(9, 'Reebok Classic', 'Footwear', 22000.00),
(10, 'New Balance 990', 'Footwear', 40000.00),
(11, 'Harry Potter', 'Books', 15000.00),
(12, 'Atomic Habits', 'Books', 32000.00),
(13, 'The Alchemist', 'Books', 28000.00),
(14, 'Deep Work', 'Books', 21000.00),
(15, 'Rich Dad Poor Dad', 'Books', 35000.00);

-- Get Top 3 Products by Sales Within Each Category
select t.*
from(
select
product_id,
product_name,
category,
sales_amount,
row_number() over(partition by category order by sales_amount desc) as cat_rank
from
products_sales) t
where t.cat_rank<=3 
order by t.category,t.cat_rank
