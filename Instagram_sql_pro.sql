-- A) Marketing Analysis:
-- 1. The five oldest users on Instagram from the provided database.
use ig_clone;

SELECT * FROM users
ORDER BY created_at ASC
LIMIT 5;

-- 2. Identify users who have never posted a single photo on Instagram.
SELECT photos.user_id,photos.image_url,users.id,users.username
from users
left join photos on photos.user_id=users.id 
 where photos.user_id is null  ;
 
-- 3.  Determine the winner(most like on single photo) of the contest and provide their details to the team. 
SELECT users.username, photos.image_url, COUNT(likes.user_id) AS total_likes
FROM users
JOIN photos ON users.id = photos.user_id
JOIN likes ON photos.id = likes.photo_id
GROUP BY users.username, photos.image_url
ORDER BY total_likes DESC
LIMIT 1;
-- 4.  Identify and suggest the top five most commonly used hashtags on the platform
SELECT tags.tag_name, COUNT(photo_tags.photo_id) AS tag_count
FROM tags
JOIN photo_tags ON tags.id = photo_tags.tag_id
GROUP BY tags.tag_name
ORDER BY tag_count DESC
LIMIT 5;
-- 5.  Determine the day of the week when most users register on Instagram.
SELECT DAYNAME(created_at) AS registration_day, COUNT(*) AS registration_count
FROM users
GROUP BY registration_day
ORDER BY registration_count DESC;

-- B) Investor Metrics:
-- 1. Calculate the average number of posts per user on Instagram. Also, provide the total number of photos on Instagram divided by the total number of users.
SELECT COUNT(*) / COUNT(DISTINCT user_id) AS avg_posts_per_user
FROM photos;
-- 2.  Identify users (potential bots) who have liked every single photo on the site, as this is not typically possible for a normal user.
SELECT user_id
FROM likes
GROUP BY user_id
HAVING COUNT(DISTINCT photo_id) = (SELECT COUNT(*) FROM photos);
 


