--Users
CREATE or alter PROCEDURE spAddNewUser
	@id INT,
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @Email VARCHAR(100)
AS
BEGIN
    INSERT INTO Users (id, first_name, last_name, email)
    VALUES (@id, @FirstName, @LastName, @Email)
END

exec spAddNewUser @id=22, @FirstName='ad', @LastName='va', @Email= 'sdadss';
select * from log;
--Posts

--create
CREATE or alter PROCEDURE AddPost
    @user_id int,
    @post_text nvarchar(max),
    @post_date datetime
AS
BEGIN
    INSERT INTO Post (user_id, post_text, post_date)
    VALUES (@user_id, @post_text, @post_date);
END

--select
CREATE or alter PROCEDURE GetPostByUserId
    @user_id int
AS
BEGIN
    SELECT P.*, U.email, U.first_name, U.last_name 
    FROM Post P join Users U on P.user_id = U.id 
    WHERE user_id = @user_id;
END

CREATE or alter PROCEDURE GetPostsWithUserInfo
AS
BEGIN
    SELECT U.email, U.first_name, U.last_name, P.post_text, P.post_date
    FROM Post P join Users U on P.user_id = U.id 
END

--Comments
CREATE PROCEDURE CreateComment
  @post_id INT,
  @user_id INT,
  @comment_text NVARCHAR(MAX),
  @comment_date DATETIME
AS
BEGIN
  INSERT INTO Comment (post_id, user_id, comment_text, comment_date)
  VALUES (@post_id, @user_id, @comment_text, @comment_date)
END

 CREATE or alter PROCEDURE ReadCommentsByPost
  @post_id INT
AS
BEGIN
  SELECT C.id, C.comment_text, C.comment_date, U.email, U.first_name, U.last_name
  FROM Comment C
  INNER JOIN Users U ON C.user_id = U.id
  WHERE C.post_id = @post_id
END

--LIKES

CREATE PROCEDURE ReadLikesByPost
  @post_id INT
AS
BEGIN
  SELECT Likes.id, Users.first_name, Users.last_name, Likes.like_date
  FROM Likes
  INNER JOIN Users ON Likes.user_id = Users.id
  WHERE Likes.post_id = @post_id
END


CREATE PROCEDURE CreateLike
  @post_id INT,
  @user_id INT,
AS
BEGIN
  INSERT INTO Likes (post_id, user_id, like_date)
  VALUES (@post_id, @user_id, GETDATE())
END

exec CreateLike @post_id=1, @user_id=5;

--FRIENDSHIP
CREATE PROCEDURE ReadFriendsByUser
  @user_id INT
AS
BEGIN
  SELECT Users.id, Users.first_name, Users.last_name, Friendships.frendship_date
  FROM Friendships
  INNER JOIN Users ON Friendships.user_id_2 = Users.id
  WHERE Friendships.user_id_1 = @user_id
  UNION
  SELECT Users.id, Users.first_name, Users.last_name, Friendships.frendship_date
  FROM Friendships
  INNER JOIN Users ON Friendships.user_id_1 = Users.id
  WHERE Friendships.user_id_2 = @user_id
END



CREATE PROCEDURE CreateFriendship
  @user_id_1 INT,
  @user_id_2 INT,
AS
BEGIN
  INSERT INTO Friendships (user_id_1, user_id_2, frendship_date)
  VALUES (@user_id_1, @user_id_2, GETDATE())
END

exec CreateFriendship @user_id_1=1, @user_id_2=5;

--MESSAGES

CREATE PROCEDURE InsertMessage 
    @sender_id INT,
    @receiver_id INT,
    @message_text NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Messages (sender_id, receiver_id, message_text, message_date)
    VALUES (@sender_id, @receiver_id, @message_text, GETDATE());
END

exec InsertMessage @sender_id=1 @receiver_id=2 @message_text='Hi';

--read the dialog 
CREATE OR ALTER PROCEDURE ReadMessagesByUser
    @sender_id INT,
    @receiver_id INT
AS
BEGIN
    SELECT M.*, S.email AS sender_email, R.email AS receiver_email
    FROM Messages M
    JOIN Users S ON M.sender_id = S.id
    JOIN Users R ON M.receiver_id = R.id
    WHERE (M.sender_id = @sender_id AND M.receiver_id = @receiver_id) OR (M.sender_id = @receiver_id AND M.receiver_id = @sender_id)
    ORDER BY M.message_date ASC;
END

-- count of a user's posts
GO
CREATE or alter FUNCTION GetUserPostCount (@user_id INT)
RETURNS INT
AS
BEGIN
    DECLARE @post_count INT
    SELECT @post_count = COUNT(*) FROM Post WHERE user_id = @user_id
    RETURN @post_count
END
GO

-- count of a user's friends
CREATE or alter FUNCTION GetUserFriendCount (@user_id INT)
RETURNS INT
AS
BEGIN
    DECLARE @friend_count INT
    SELECT @friend_count = COUNT(*) FROM Friendships WHERE user_id_1 = @user_id OR user_id_2 = @user_id
    RETURN @friend_count
END
GO

---------------
CREATE FUNCTION CountUserComments
(
    @user_id INT
)
RETURNS INT
AS
BEGIN
    DECLARE @comment_count INT

    SELECT @comment_count = COUNT(*) FROM Comment WHERE user_id = @user_id

    RETURN @comment_count
END
go

---------------
CREATE OR ALTER PROCEDURE GetUserInfo
    @user_id INT
AS
BEGIN
    SELECT 
        U.id, 
        U.first_name, 
        U.last_name, 
        U.email,
        dbo.GetUserPostCount(@user_id) as posts_count,
        dbo.GetUserFriendCount(@user_id) as friends_count,
		dbo.CountUserComments(@user_id) as comments_count
    FROM Users U
    WHERE U.id = @user_id;
END
go

---------------
--TRIGGER--
CREATE or alter TRIGGER DeletePostData
ON Post
AFTER DELETE
AS
BEGIN
    DECLARE @post_id INT = (SELECT id FROM deleted)
    
    DELETE FROM Comment
    WHERE post_id = @post_id
    
    DELETE FROM Likes
    WHERE post_id = @post_id
END
go


CREATE or alter TRIGGER tr_log_user_operations
ON Users
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @operation_type VARCHAR(50);
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
        SET @operation_type = 'UPDATE';
    ELSE IF EXISTS (SELECT * FROM inserted)
        SET @operation_type = 'INSERT';
    ELSE IF EXISTS (SELECT * FROM deleted)
        SET @operation_type = 'DELETE';

    INSERT INTO log (operation_text, operation_date)
    VALUES (@operation_type + ' operation on Users table', GETDATE());
END;


---------------
CREATE or alter PROCEDURE DeletePostById
    @post_id INT
AS
BEGIN
    DELETE FROM Post WHERE id = @post_id;
END
---------------





exec ReadMessagesByUser @sender_id = 1, @receiver_id= 2;
exec ReadFriendsByUser @user_id = 1;
exec ReadLikesByPost @post_id = 2;
exec ReadCommentsByPost @post_id =3;
exec GetPostsWithUserInfo;
exec GetPostByUserId @user_id = 1;
exec GetUserInfo @user_id = 3;


go
CREATE VIEW PopularPosts AS
SELECT TOP 10 Post.id, post_text, COUNT(Likes.id) AS num_likes
FROM Post LEFT JOIN Likes ON Post.id = Likes.post_id
GROUP BY Post.id, post_text
ORDER BY num_likes DESC;
go

select * from PopularPosts;


go
CREATE VIEW UserActivity AS
SELECT Users.id, first_name, last_name, Post.id AS post_id, post_text, post_date, 
    Comment.id AS comment_id, comment_text, comment_date, 
    Likes.id AS like_id, like_date
FROM Users 
LEFT JOIN Post ON Users.id = Post.user_id 
LEFT JOIN Comment ON Users.id = Comment.user_id 
LEFT JOIN Likes ON Users.id = Likes.user_id;
go

select * from UserActivity;

go
CREATE VIEW PostDetails AS
SELECT Post.id, Post.post_text, Post.post_date, Users.first_name, Users.last_name, Users.email
FROM Post
 join Users ON Post.user_id = Users.id;
go

select * from PostDetails;


CREATE INDEX idx_Post_user_id ON Post (user_id);

CREATE NONCLUSTERED INDEX EmailNotNullIndex ON Users (id) WHERE email IS NOT NULL;

CREATE NONCLUSTERED INDEX PostDateIndex ON Post (post_date);


delete from USERS where id = 3;


