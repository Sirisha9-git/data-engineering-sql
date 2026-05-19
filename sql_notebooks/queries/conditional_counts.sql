-- Get number of Completed and Cancelled orders
--------------------------------------------
-- Source table and data

CREATE TABLE order_status (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    stage VARCHAR(50) NOT NULL,      -- e.g., Created, Processing, Shipped
    status VARCHAR(20) NOT NULL      -- Completed, Cancelled
);

INSERT INTO order_status (order_id, customer_name, stage, status) VALUES
(1, 'John Miller', 'Created', 'Completed'),
(2, 'Priya Shah', 'Processing', 'Completed'),
(3, 'Carlos Ruiz', 'Shipped', 'Completed'),
(4, 'Emily Clark', 'Created', 'Cancelled'),
(5, 'David Kim', 'Processing', 'Completed'),
(6, 'Sara Ibrahim', 'Shipped', 'Cancelled'),
(7, 'Liam O’Connor', 'Created', 'Completed'),
(8, 'Mei Lin', 'Processing', 'Cancelled'),
(9, 'Ahmed Khan', 'Shipped', 'Completed'),
(10, 'Olivia Brown', 'Created', 'Completed');

select * from order_status;

-- Get number of Completed and Cancelled orders

-- funnel breakdown by stage
select 
status,
sum(case when status = 'Completed' then 1 else 0 end) as completed_orders,
sum(case when status='Cancelled' then 1 else 0 end) as cancelled_prders
from order_status
group by status;

-- Single Summary
select
sum(case when status = 'Completed' then 1 else 0 end) as completed_orders,
sum(case when status='Cancelled' then 1 else 0 end) as cancelled_orders
from order_status