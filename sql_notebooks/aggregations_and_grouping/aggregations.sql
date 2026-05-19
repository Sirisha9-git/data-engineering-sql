-- source : samples.nyctaxi.trips
-- columns : tpep_pickup_datetime, tpep_dropoff_datetime

-- problem : Remove duplicate taxi trips based on pickup/dropoff timestamps.
select 
tpep_pickup_datetime,
tpep_dropoff_datetime,
trip_distance,
fare_amount,
pickup_zip,
dropoff_zip
from(
    select * ,
    row_number() over(
        partition by tpep_pickup_datetime,tpep_dropoff_datetime
        order by fare_amount desc
    ) as top_trip_fare
from
samples.nyctaxi.trips
)
where top_trip_fare=1

----------------------------------------------------------------------------------------------------------------------------------------------

