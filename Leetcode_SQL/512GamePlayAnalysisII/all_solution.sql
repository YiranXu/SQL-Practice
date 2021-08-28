/*Window function*/
SELECT player_id,device_id
FROM(
SELECT player_id,device_id, ROW_NUMBER() OVER(PARTITION BY player_id ORDER BY event_date) as rn
FROM Activity) a
WHERE rn=1

SELECT player_id,device_id
FROM(
SELECT player_id,device_id, RANK() OVER(PARTITION BY player_id ORDER BY event_date) as rn
FROM Activity) a
WHERE rn=1

/*Aggregation and Join*/
SELECT a.player_id, device_id
FROM(
SELECT player_id,min(event_date) as first_login
FROM Activity
GROUP BY player_id) sub INNER JOIN Activity a ON sub.first_login=a.event_date and sub.player_id=a.player_id

/*Aggregation 2*/
select player_id,device_id
from activity
where (player_id,event_date) 
in (select player_id,min(event_date) as event_date from activity group by player_id)