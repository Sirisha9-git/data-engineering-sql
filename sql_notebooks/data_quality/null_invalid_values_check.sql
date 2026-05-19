-- Check for null and invalid values in data.
-- problem : Identify how many rows in the NYC Taxi Trips dataset contain NULL or invalid values in important columns such as passenger_count and fare_amount.
        -- Count how many rows have missing fare_amount. 
        -- Count how many rows have missing trip_distance.
        -- Count how many rows have missing pickup_zip.
        -- Count how many rows have missing dropoff_zip.

-- source : samples.nyctaxi.trips
-- columns : fare_amount, trip_distance,pickup_zip,dropoff_zip

select 
count(*) as toral_records,
sum(case when fare_amount is null then 1 else 0 end) as null_fare_amount,
sum(case when trip_distance is null then 1 else 0 end) as null_trip_distance,
sum(case when pickup_zip is null then 1 else 0 end) as null_pickup_zip,
sum(case when dropoff_zip is null then 1 else 0 end) as null_dropoff_zip
from
samples.nyctaxi.trips