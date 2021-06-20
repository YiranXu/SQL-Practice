--MORE JOIN
--12.List the film title and the leading actor for all of the films 'Julie Andrews' played in.
--Solution 1: 
SELECT title,a.name 
FROM movie m JOIN casting c on m.id=c.movieid JOIN actor a on c.actorid=a.id 
WHERE movieid IN
(SELECT movieid FROM casting
WHERE actorid =
  (SELECT id FROM actor
  WHERE name='Julie Andrews'))
AND ord=1
--Solution 2:
SELECT m.title,a.name
FROM movie m JOIN casting c ON m.id=c.movieid JOIN actor a ON a.id=c.actorid
WHERE c.movieid IN (SELECT movieid
FROM casting c JOIN actor a ON (c.actorid=a.id AND name='Julie Andrews' ))
AND ord=1

/*13.Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles.*/
SELECT name
FROM casting JOIN actor ON casting.actorid=actor.id
WHERE ord=1
GROUP BY name
HAVING count(movieid)>=15
ORDER BY name

/*14.List the films released in the year 1978 ordered by the number of actors in the cast, then by title.*/
SELECT title,COUNT(actorid)
FROM movie JOIN casting ON movie.id=casting.movieid
WHERE yr=1978
GROUP BY title
ORDER BY COUNT(actorid) DESC,title 

/*15.List all the people who have worked with 'Art Garfunkel'.*/
SELECT name
FROM casting JOIN actor ON casting.actorid=actor.id 
WHERE movieid IN
(SELECT movieid
FROM casting JOIN actor ON casting.actorid=actor.id AND actor.name='Art Garfunkel')
AND name!='Art Garfunkel'
ORDER BY name 