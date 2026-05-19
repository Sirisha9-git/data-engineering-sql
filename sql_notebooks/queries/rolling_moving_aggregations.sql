

-- source table and data
CREATE TABLE daily_revenue (
    revenue_date DATE PRIMARY KEY,
    revenue_amount DECIMAL(10,2) NOT NULL
);

INSERT INTO daily_revenue (revenue_date, revenue_amount) VALUES
('2026-01-01', 1000.00),
('2026-01-02', 1200.00),
('2026-01-03', 900.00),
('2026-01-04', 1500.00),
('2026-01-05', 1800.00),
('2026-01-06', 1600.00),
('2026-01-07', 2000.00),

('2026-01-08', 2200.00),
('2026-01-09', 2500.00),
('2026-01-10', 2300.00),
('2026-01-11', 2100.00),
('2026-01-12', 2600.00),
('2026-01-13', 2700.00),
('2026-01-14', 3000.00);

-- Compute running revenue over time
-- Get 7-day moving average of revenue
select
revenue_date,
sum(revenue_amount) over (
    order by revenue_date
    rows between unbounded preceding and current row
    )as running_total,
    sum(revenue_amount) over (
    order by revenue_date
    rows between 6 preceding and current row
)as 7_day_moving_sum,
avg(revenue_amount) over (
    order by revenue_date
    rows between 6 preceding and current row
)as 7_day_moving_avg
from daily_revenue
