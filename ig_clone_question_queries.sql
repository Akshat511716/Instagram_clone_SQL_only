-- 1. Finding 5 oldest users  
SELECT *
FROM users 
ORDER BY created_at
LIMIT 5;

-- 2. What day of the week most users register on?
SELECT DAYNAME(created_at) AS Day, COUNT(*) AS number_of_registeration
FROM users
GROUP BY Day
ORDER BY number_of_registeration DESC;

-- 3. Find the users who have never posted a photo
SELECT username 
FROM users AS U
LEFT JOIN photos AS P
ON U.id = P.user_id
WHERE user_id IS NULL;

-- 4. Most liked photo
SELECT username, P.id ,P.image_url, COUNT(*) AS Likes
FROM photos AS P
INNER JOIN likes AS L ON P.id = L.photo_id
INNER JOIN users AS U ON P.user_id = U.id
GROUP BY P.id
ORDER BY Likes DESC
LIMIT 1;

-- 5. How many times does the average user post
SELECT (SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) FROM users) AS Average_user_posts;

-- 6. What are the top 5 most commonly used hashtags?
SELECT tag_name, COUNT(*) AS number_of_times_used
FROM photo_tags AS P
INNER JOIN tags AS T
ON P.tag_id = T.id
GROUP BY tag_id
ORDER BY number_of_times_used DESC
LIMIT 5;

-- 7. Find users who have liked every single photo on the site 
-- Bots on the site
SELECT username, user_id, COUNT(*) AS Number_of_likes
FROM users AS U
INNER JOIN likes AS L
ON U.id = L.user_id
GROUP BY L.user_id
HAVING Number_of_likes = (SELECT COUNT(*) FROM photos);


