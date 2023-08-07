-- Additional Users
INSERT INTO Users (first_name, last_name, email, created_at)
VALUES ('Sarah', 'Johnson', 'sarahjohnson@example.com', '2015-01-12 12:00:00'),
       ('Michael', 'Brown', 'michaelbrown@example.com', '2016-04-01 12:00:00'),
       ('Olivia', 'Davis', 'oliviadavis@example.com', '2017-03-05 12:00:00');

-- Additional Posts
INSERT INTO Post (user_id, post_text, post_date)
VALUES (3, 'Had a great time at the beach!', '2022-01-06 14:30:00'),
       (5, 'Enjoying the sunset!', '2022-01-07 18:15:00');

-- Additional Comments
INSERT INTO Comment (post_id, user_id, comment_text, comment_date)
VALUES (5, 2, 'Beautiful view!', '2022-01-07 19:00:00'),
       (4, 3, 'The weather is perfect!', '2022-01-05 13:30:00');

-- Additional Likes
INSERT INTO Likes (post_id, user_id, like_date)
VALUES (5, 1, '2022-01-07 19:30:00'),
       (3, 2, '2022-01-05 12:30:00');

-- Additional Friendships
INSERT INTO Friendships (user_id_1, user_id_2, frendship_date)
VALUES (4, 1, '2022-01-06 09:00:00'),
       (5, 3, '2022-01-07 11:30:00');

-- Additional Messages
INSERT INTO Messages (SenderId, ReceiverId, message_text, message_date)
VALUES (3, 2, 'Hey Jane, what are you up to?', '2022-01-03 14:00:00'),
       (2, 3, 'Just finished reading a great book!', '2022-01-03 14:05:00');

-- Additional User Locations
INSERT INTO UserLocation (user_id, location, last_updated)
VALUES (1, geography::Point(37.7749, -122.4194, 4326), GETDATE()),
       (3, geography::Point(51.5074, -0.1278, 4326), GETDATE()),
       (4, geography::Point(34.0522, -118.2437, 4326), GETDATE());


--2
INSERT INTO Users (first_name, last_name, email, created_at)
VALUES ('Harry', 'Potter', 'potter.harryk@example.com', '2023-03-03 12:00:00');
-- 2.1
SELECT DISTINCT COUNT(*) OVER() AS NewUsersCount
FROM Users
WHERE created_at >= '2023-01-01  12:00:00' AND created_at <= '2023-30-12  12:00:00';

-- 2.2
SELECT DISTINCT
    (COUNT(*) * 100.0 / SUM(COUNT(*)) OVER()) AS SegmentPercentage
FROM Users
WHERE created_at >= '2023-01-01  12:00:00' AND created_at <= '2023-30-12  12:00:00'
GROUP BY created_at;
-- 2.3  общее количество постов для каждого пользователя:
SELECT
    u.id,
    u.first_name,
    u.last_name,
    COUNT(p.id) OVER (PARTITION BY u.id) AS total_posts
FROM
    Users u
LEFT JOIN
    Post p ON u.id = p.user_id;
-- 2.4 распределяющая ранги пользователям в зависимости от общего количества лайков и комментариев
SELECT
    u.id,
    u.first_name,
    u.last_name,
    RANK() OVER (ORDER BY (COUNT(l.id) + COUNT(c.id)) DESC) AS user_rank
FROM
    Users u
LEFT JOIN
    Likes l ON u.id = l.user_id
LEFT JOIN
    Comment c ON u.id = c.user_id
GROUP BY
    u.id,
    u.first_name,
    u.last_name;



	--3
DECLARE @PageNumber INT = 6;
WITH OrderedResults AS (
    SELECT
        *,
        ROW_NUMBER() OVER (ORDER BY id) AS RowNum
    FROM
        Users
)
SELECT
    id,
    first_name,
    last_name,
    email,
    created_at
FROM
    OrderedResults
WHERE
    RowNum BETWEEN ((@PageNumber - 1) * 2) + 1 AND (@PageNumber * 2);


	--4
select * from Users;
WITH RankedDuplicates AS (
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY email ORDER BY id) AS RowNum
    FROM
        Users
)
DELETE FROM RankedDuplicates
WHERE RowNum > 1;


--5
select * from users;
select * from Friendships;

INSERT INTO Friendships (user_id_1, user_id_2, frendship_date)
VALUES (8, 1, '2023-01-05 09:00:00'),
       (8, 3, '2023-01-04 11:30:00'),
	   (10, 2, '2023-01-04 11:30:00'),
	   (7, 4, '2023-01-03 11:30:00'),
	   (10, 5, '2023-01-04 11:30:00'),
	   (4, 2, '2023-01-02 11:30:00');
SELECT
    user_id,
    first_name,
    last_name,
    month_start,
    COUNT(*) AS followers_count
FROM (
    SELECT
        u.id AS user_id,
        u.first_name,
        u.last_name,
        DATEADD(MONTH, DATEDIFF(MONTH, 0, f.frendship_date), 0) AS month_start,
        ROW_NUMBER() OVER (PARTITION BY u.id, DATEADD(MONTH, DATEDIFF(MONTH, 0, f.frendship_date), 0) ORDER BY f.frendship_date DESC) AS rn
    FROM
        Users u
    JOIN
        Friendships f ON u.id = f.user_id_2
    WHERE
        f.frendship_date >= DATEADD(MONTH, -6, GETDATE())
) AS subquery
WHERE
    rn = 1
GROUP BY
    user_id,
    first_name,
    last_name,
    month_start
ORDER BY
    user_id,
    month_start;



	--6
SELECT
    post_id,
    user_id,
    first_name,
    last_name,
    likes_count
FROM (
    SELECT
        p.id AS post_id,
        u.id AS user_id,
        u.first_name,
        u.last_name,
        COUNT(*) AS likes_count,
        RANK() OVER (ORDER BY COUNT(*) DESC) AS rank
    FROM
        Post p
    JOIN
        Likes l ON p.id = l.post_id
    JOIN
        Users u ON l.user_id = u.id
    GROUP BY
        p.id,
        u.id,
        u.first_name,
        u.last_name
) AS subquery
WHERE
    rank = 1;


