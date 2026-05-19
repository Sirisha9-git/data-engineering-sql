-- Filter Indian users created in Feb-2026 and phone is not NULL.
-----------------------------------------------------------------
-- source table and data.

CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    country VARCHAR(50) NOT NULL,
    signup_month VARCHAR(10) NOT NULL,   -- format: Jan-2026
    phone VARCHAR(20)            -- nullable
);

INSERT INTO employee (emp_id, emp_name, country, signup_month, phone) VALUES
(101, 'John Miller', 'USA', 'Jan-2026', '214-555-7821'),
(102, 'Priya Shah', 'India', 'Feb-2026', '111-111-1111'),
(111, 'Noah Shah', 'India', 'Feb-2026', NULL),
(103, 'Carlos Ruiz', 'Mexico', 'Mar-2026', '469-555-1198'),
(104, 'Emily Clark', 'UK', 'Apr-2026', NULL),
(105, 'David Kim', 'South Korea', 'May-2026', '817-555-4420'),
(106, 'Sara Ibrahim', 'UAE', 'Jun-2026', NULL),
(107, 'Liam O’Connor', 'Ireland', 'Jul-2026', '972-555-8831'),
(108, 'Mei Lin', 'China', 'Aug-2026', NULL),
(109, 'Ahmed Khan', 'Pakistan', 'Sep-2026', '682-555-3309'),
(110, 'Olivia Brown', 'Canada', 'Oct-2026', NULL);

select * from employee;

-- Filter Indian users created in Feb-2026 and phone is not NULL.
select * 
from employee
where  country='India'
and signup_month = 'Feb-2026'
and phone is not null