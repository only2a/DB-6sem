
INSERT INTO Users ( first_name, last_name, email, created_at)
VALUES ( 'John', 'Doe', 'johndoe@example.com', '2020-04-01 12:00:00'),
       ( 'Jane', 'Smith', 'janesmith@example.com', '2019-01-01 12:00:00'),
       ( 'Bob', 'Johnson', 'bobjohnson@example.com', '2021-02-01 12:00:00'),
       ( 'Emily', 'Davis', 'emilydavis@example.com', '2016-10-12 12:00:00'),
       ( 'Mike', 'Wilson', 'mikewilson@example.com', '2018-11-07 12:00:00');


INSERT INTO Post ( user_id, post_text, post_date)
VALUES ( 1, 'Hello, world!', '2022-01-01 12:00:00'),
       ( 2, 'Check out this photo I took!', '2022-01-02 15:30:00'),
       ( 3, 'Just finished a great workout!', '2022-01-03 10:45:00'),
       ( 4, 'What a beautiful day!', '2022-01-04 11:20:00'),
       ( 5, 'Can''t wait for the weekend!', '2022-01-05 17:00:00');


INSERT INTO Comment ( post_id, user_id, comment_text, comment_date)
VALUES ( 1, 2, 'Hi John, welcome to the social network!', '2022-01-02 13:00:00'),
       ( 2, 3, 'Great photo, Jane!', '2022-01-03 16:00:00'),
       ( 3, 1, 'Keep up the good work, Bob!', '2022-01-04 11:00:00'),
       ( 4, 5, 'I know, right? :)', '2022-01-05 12:30:00');


INSERT INTO Likes ( post_id, user_id, like_date)
VALUES ( 1, 3, '2022-01-02 14:00:00'),
       ( 2, 1, '2022-01-03 17:00:00'),
       ( 2, 4, '2022-01-03 18:00:00'),
       ( 3, 5, '2022-01-04 12:00:00'),
       ( 4, 2, '2022-01-04 13:00:00');


INSERT INTO Friendships ( user_id_1, user_id_2, frendship_date)
VALUES ( 1, 2, '2022-01-01 13:00:00'),
       ( 1, 3, '2022-01-02 10:00:00'),
       ( 2, 4, '2022-01-03 12:00:00'),
       ( 3, 5, '2022-01-04 15:00:00'),
       ( 4, 5, '2022-01-05 16:00:00');


INSERT INTO Messages ( SenderId, ReceiverId, message_text, message_date)
VALUES ( 1, 2, 'Hey Jane, how are you?', '2022-01-01 13:00:00'),
       ( 2, 1, 'I''m good, thanks! How about you?', '2022-01-01 13:05:00'),
       ( 1, 2, 'I''m doing well too. Have you seen the latest post from Bob?', '2022-01-02 10:00:00'),
       ( 2, 1, 'No, I haven''t. What did he post?', '2022-01-02 10:05:00'),
       ( 1, 2, 'A photo of his workout routine. Looks intense!', '2022-01-02 10:10:00'),
       ( 2, 1, 'Wow, that''s impressive!', '2022-01-02 10:15:00'),
       ( 1, 3, 'Hey Bob, just wanted to say great post!', '2022-01-03 11:00:00'),
       ( 3, 1, 'Thanks John, I appreciate it!', '2022-01-03 11:05:00'),
       ( 1, 4, 'Hey Emily, how''s it going?', '2022-01-04 14:00:00'),
       ( 4, 1, 'I''m good, thanks for asking! How about you?', '2022-01-04 14:05:00');

INSERT INTO UserLocation (user_id, location, last_updated)
VALUES (1, geography::Point(47.6097, -122.3331, 4326), GETDATE());

INSERT INTO UserLocation (user_id, location, last_updated)
VALUES (2, geography::Point(51.5072, -0.1276, 4326), GETDATE());

INSERT INTO UserLocation (user_id, location, last_updated)
VALUES (3, geography::Point(40.7128, -74.0060, 4326), GETDATE());

INSERT INTO UserLocation (user_id, location, last_updated)
VALUES (4, geography::Point(51.5074, -0.1278, 4326), GETDATE());

INSERT INTO UserLocation (user_id, location, last_updated)
VALUES (5, geography::Point(34.0522, -118.2437, 4326), GETDATE());