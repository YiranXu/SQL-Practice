--1.Method 1. Group by
SELECT player_id,MIN(event_date) as "first_login"
FROM Activity
GROUP BY player_id 
--2.WINDOW FUCTION (ROW_NUMBER)
SELECT player_id,event_date as first_login
FROM
(SELECT player_id,event_date,ROW_NUMBER() OVER (PARTITION BY player_id ORDER BY event_date ASC) as rn
FROM Activity) a
WHERE rn=1
--3. WINDOW FUNCTION USING RANK()
SELECT player_id,event_date as "first_login"
FROM(
SELECT player_id,event_date,RANK() OVER (PARTITION BY player_id ORDER BY event_date ASC) as rnk FROM Activity) a
WHERE rnk=1