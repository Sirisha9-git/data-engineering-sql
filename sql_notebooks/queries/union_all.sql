--  Merge buyers and sellers into one user list
-----------------------------------------------
-- source tables and data
CREATE TABLE buyers (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(100) NOT NULL,
    country VARCHAR(50) NOT NULL
);

CREATE TABLE sellers (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(100) NOT NULL,
    country VARCHAR(50) NOT NULL
);

INSERT INTO buyers (user_id, user_name, country) VALUES
(1, 'John Miller', 'USA'),
(2, 'Priya Shah', 'India'),
(3, 'Carlos Ruiz', 'Mexico'),
(4, 'Emily Clark', 'UK'),
(5, 'David Kim', 'South Korea');

INSERT INTO sellers (user_id, user_name, country) VALUES
(101, 'Liam O’Connor', 'Ireland'),
(102, 'Mei Lin', 'China'),
(103, 'Ahmed Khan', 'Pakistan'),
(104, 'Olivia Brown', 'Canada'),
(105, 'Sara Ibrahim', 'UAE');

-- Merge buyers and sellers into one user list
select user_id, user_name, country from buyers
union all
select user_id, user_name, country from sellers