-- Get users who don’t have any matching orders
------------------------------------------------
-- sample source and data
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(100) NOT NULL,
    country VARCHAR(50)
);

CREATE TABLE orders1 (
    order_id INT PRIMARY KEY,
    user_id INT,
    amount DECIMAL(10,2),
    status VARCHAR(20),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

INSERT INTO users (user_id, user_name, country) VALUES
(1, 'John Miller', 'USA'),
(2, 'Priya Shah', 'India'),
(3, 'Carlos Ruiz', 'Mexico'),
(4, 'Emily Clark', 'UK'),
(5, 'David Kim', 'South Korea'),
(6, 'Mei Lin', 'China');   -- No orders

INSERT INTO orders1 (order_id, user_id, amount, status) VALUES
(101, 1, 120.50, 'Completed'),
(102, 1, 89.99, 'Completed'),
(103, 2, 45.00, 'Cancelled'),
(104, 3, 60.00, 'Completed'),
(105, 4, 35.50, 'Cancelled'),
(106, 5, 150.00, 'Completed');

-- Get users who don’t have any matching orders

-- using joins
select 
distinct u.user_id 
from 
users  u
left join orders1 o
on u.user_id = o.user_id
where o.user_id is null

-- using NOT EXISTS
select
distinct user_id
from users u
where NOT EXISTS(
    select 1 from orders1 o 
    where u.user_id = o.user_id
)