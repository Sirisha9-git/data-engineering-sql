-- Duplicate record check
-------------------------

-- Check if there any duplicate records in the table using GROUPBY+HAVING

SELECT *, 
COUNT(*) as cnt
FROM
samples.nyctaxi.trips
group by ALL
having count(*)>1;


-- Check if there any duplicate records in the table using WINDOW FUNCTIONS

select * from(
select *,
count(*) over(partition by * ) as dup_cnt
from 
samples.nyctaxi.trips
) 
where dup_cnt>1

------------------------------------------------------------------------------------------------------------------------------------------------------

-- Duplicate key check
----------------------