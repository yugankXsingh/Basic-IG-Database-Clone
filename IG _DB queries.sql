--  5 oldest users
SELECT
  *
FROM
  users
ORDER BY
  created_at
LIMIT
  0, 5;
-- -----------------------------------------------------
-- Most popular Registration day of week
SELECT
  DAYOFWEEK(DATE(created_at)) AS weekDay,
  COUNT(*)
FROM
  users
GROUP BY
  DAYOFWEEK(DATE(created_at));
-- -----------------------------------------------------
-- using DAYNAME()
SELECT
  DAYNAME(created_at) AS 'Registered on',
  COUNT(*) as 'Number of users'
FROM
  users
GROUP BY
  DAYNAME(created_at)
ORDER BY
  'Number of users';
-- -----------------------------------------------------
-- finding inactive users with no posts
-- -----------------------------------------------------
SELECT
  users.id,
  username,
  IFNULL(image_url, 0) AS posts
FROM
  users
  LEFT JOIN photos ON users.id = photos.user_id
WHERE
  photos.id IS NULL;
-- ------------------------------------------------------
-- most liked photos and its users
-- ------------------------------------------------------
SELECT
  photos.id as 'photo_id',
  image_url,
  count(*) AS likes -- COUNT(likes.user_id) is also correct and more clear to understand how group is formed
FROM
  photos
  JOIN likes ON photos.id = likes.photo_id
GROUP BY
  photos.id
ORDER BY
  likes DESC
LIMIT
  0, 3;
SELECT
  photos.id AS 'photo_id',
  photos.image_url,
  COUNT(*) AS likes,
  username,
  -- COUNT(likes.user_id) is also correct and more clear to understand how group is formed
  photos.user_id
FROM
  photos
  INNER JOIN likes ON photos.id = likes.photo_id
  INNER JOIN users ON users.id = photos.user_id
GROUP BY
  photos.id,
  photos.user_id
ORDER BY
  likes DESC;
--  we can group by photos.id as well!
-- ---------------------------------------------------------
-- ---------------------------------------------------------
-- How many times does a user post?
-- ---------------------------------------------------------
SELECT
  users.id,
  username,
  COUNT(photos.image_url) AS total_posts
FROM
  users
  INNER JOIN photos ON users.id = photos.user_id
GROUP BY
  users.id
ORDER BY
  total_posts DESC;
-- -----------------------------------------------------------
-- calculating average post per user using subquery
-- -----------------------------------------------------------
-- total number of photos / total number of users
SELECT
  (
    SELECT
      COUNT(*)
    FROM
      photos
  ) / (
    SELECT
      COUNT(*)
    FROM
      users
  ) AS 'avg_post per User';
-- ------------------------------------------------------------
-- top hashtags
-- ------------------------------------------------------------
SELECT
  tags.id,
  tag_name,
  COUNT(*) AS Times_used
FROM
  tags
  INNER JOIN photo_tags ON photo_tags.tag_id = tags.id
GROUP BY
  tags.id
ORDER BY
  Times_used DESC;
-- ------------------------------------------------------------
-- users who have liked every single photo on the site
-- ------------------------------------------------------------
SELECT
  users.id,
  username,
  COUNT(*) AS photos_liked,
  CASE
    WHEN COUNT(*) = 257 THEN 'BOT'
    ELSE 'User Account'
  END AS Acc_TYPE
FROM
  users
  join likes ON users.id = likes.user_id
GROUP BY
  users.id
ORDER BY
  photos_liked DESC;
-- ----------------------------------------------------------------------------------------
SELECT
  users.id,
  username,
  COUNT(*) AS photos_liked
FROM
  users
  join likes ON users.id = likes.user_id
GROUP BY
  users.id
HAVING
  photos_liked = (
    SELECT
      COUNT(*)
    FROM
      photos
  )
ORDER BY
  photos_liked DESC;
-- ------------------------------------------------------------------------------------------
-- number of followers for each user
-- ------------------------------------------------------------------------------------------
SELECT
  users.*,
  COUNT(*) AS followers
FROM
  USERS
  LEFT JOIN follows ON follows.followee_id = users.id
GROUP BY
  users.id
ORDER BY
  followers DESC;
-- ------------------------------------------------------------------------------------------
-- How many users is each person following? 
-- ------------------------------------------------------------------------------------------
SELECT
  users.*,
  COUNT(*) AS following
FROM
  USERS
  LEFT JOIN follows ON follows.follower_id = users.id
GROUP BY
  users.id
ORDER BY
  following DESC;
-- ---------------------------------------------------------------------------------------------
-- displaying users , followers , follwoing in a single row
-- ---------------------------------------------------------------------------------------------
SELECT
  u.id,
  u.username,
  -- Count of followers (people who follow *this* user)
  COUNT(DISTINCT f1.follower_id) AS followers,
  -- Count of followings (people this user follows)
  COUNT(DISTINCT f2.followee_id) AS following
FROM
  users u -- Join for followers (other users following this user)
  LEFT JOIN follows f1 ON f1.followee_id = u.id -- Join for followings (this user following others)
  LEFT JOIN follows f2 ON f2.follower_id = u.id
GROUP BY
  u.id,
  u.username
ORDER BY
  followers DESC;
-- f1 counts the number of times a user is followed.
-- f2 counts the number of users they’re following.
-- Both are joined to the same users table.
-- DISTINCT ensures no double-counting (in case of weird data).
-- GROUP BY gives you a single row per user.
-- ORDER BY followers DESC shows the most followed users first (you can change it to following too).
-- ----------------------------------------------------------------------------------------------------