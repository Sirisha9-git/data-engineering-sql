-- source  : samples.nyctaxi.trips
-- columns : tpep_pickup_datetime, fare_amount, pickup_zip

-- Problem 1 : For each pickup ZIP code, and for each trip, calculate:
--            The average fare of the current trip + the previous 6 trips ordered by pickup time.
--            This gives a 7‑trip rolling average.

select 
pickup_zip,
tpep_pickup_datetime,
fare_amount,
AVG(fare_amount) over (                       -- average fare across the 7‑trip window.
  partition by  pickup_zip                    -- Creates a separate rolling calculation for each ZIP code.
  order by tpep_pickup_datetime               -- Ensures trips are processed in the order they occurred.
  rows between 6 preceding and current row    -- Defines a 7day‑trip row based rolling window.
) as rolling_6_day_average
from
samples.nyctaxi.trips
WHERE 
fare_amount is not null                       -- Removes null ZIPs and null fares to avoid skewing the rolling average.
AND pickup_zip is not null;

-----------------------------------------------------------------------------------------------------------------------------

-- Problem 2 : For each pickup ZIP code, and for each trip, calculate:
--            The rolling 1‑hour average fare

select 
pickup_zip,
tpep_pickup_datetime,
fare_amount,
AVG(fare_amount) over (
  partition by pickup_zip
  order by tpep_pickup_datetime
  RANGE BETWEEN INTERVAL 1 HOUR PRECEDING AND CURRENT ROW        -- Defines a 1 hour  time based rolling window.
) as rolling_1_hr_average
from 
samples.nyctaxi.trips
WHERE 
fare_amount is not null                       -- Removes null ZIPs and null fares to avoid skewing the rolling average.
AND pickup_zip is not null;
