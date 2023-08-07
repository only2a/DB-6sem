--1
CREATE TABLE Comment (
    id INT PRIMARY KEY IDENTITY(1,1),
    post_id INT,
    user_id INT,
    comment_text VARCHAR(MAX),
    comment_date DATETIME,
    parent_comment_id INT, -- new column added
    FOREIGN KEY (post_id) REFERENCES Post(id),
    FOREIGN KEY (user_id) REFERENCES Users(id),
    FOREIGN KEY (parent_comment_id) REFERENCES Comment(id) -- self-referencing foreign key
);

-- 2
CREATE PROCEDURE GetSubordinateComments
    @comment_id INT
AS
BEGIN
    WITH CommentHierarchy AS (
        -- Base case: find the comment with the specified ID
        SELECT id, post_id, user_id, comment_text, comment_date, parent_comment_id, 0 AS Level
        FROM Comment
        WHERE id = @comment_id
        UNION ALL
        -- Recursive case: find all child comments of the current level and join with their children
        SELECT child.id, child.post_id, child.user_id, child.comment_text, child.comment_date, child.parent_comment_id, Level + 1
        FROM Comment child
        JOIN CommentHierarchy parent ON parent.id = child.parent_comment_id
    )
    -- Return the results with an indication of the hierarchy level
    SELECT id, post_id, user_id, comment_text, comment_date, parent_comment_id, Level
    FROM CommentHierarchy
    ORDER BY Level, id;
END


exec GetSubordinateComments 6;

-- 3

CREATE PROCEDURE AddSubordinateComment
    @parent_comment_id INT,
    @post_id INT,
    @user_id INT,
    @comment_text VARCHAR(MAX),
    @comment_date DATETIME
AS
BEGIN
    INSERT INTO Comment (post_id, user_id, comment_text, comment_date, parent_comment_id)
    VALUES (@post_id, @user_id, @comment_text, @comment_date, @parent_comment_id);
END


EXEC AddSubordinateComment 
    @parent_comment_id = 1, 
    @post_id = 1, 
    @user_id = 2, 
    @comment_text = 'This is a new subordinate comment', 
    @comment_date = '1900-01-01 00:00:00.000';



-- 4
CREATE PROCEDURE MoveSubordinateComments
    @oldParentId INT,
    @newParentId INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Find all comments that are children of the old parent comment
    DECLARE @childComments TABLE (id INT);
    INSERT INTO @childComments
    SELECT id FROM Comment WHERE parent_comment_id = @oldParentId;

    -- Update the parent comment ID of the child comments to the new parent comment ID
    UPDATE Comment SET parent_comment_id = @newParentId WHERE id IN (SELECT id FROM @childComments);

    -- Recursively move the child comments and their descendants to the new parent comment
    DECLARE @currentParentId INT = @oldParentId;
    WHILE EXISTS (SELECT * FROM @childComments)
    BEGIN
        DECLARE @tempComments TABLE (id INT);

        -- Find all comments that are children of the current parent comment
        INSERT INTO @tempComments
        SELECT id FROM Comment WHERE parent_comment_id = @currentParentId;

        -- Update the parent comment ID of the child comments to the new parent comment ID
        UPDATE Comment SET parent_comment_id = @newParentId WHERE id IN (SELECT id FROM @tempComments);

        -- Add the child comments to the list of comments to be processed in the next iteration
        INSERT INTO @childComments
        SELECT id FROM @tempComments;

        -- Remove the processed comments from the list
        DELETE FROM @childComments WHERE id IN (SELECT id FROM @tempComments);

        -- Set the current parent ID to the next comment in the list
        SET @currentParentId = @newParentId;
    END
END

EXEC MoveSubordinateComments 1, 6; -- Move all child comments under comment 1 to comment 5





-- 5
create database SN2_l5_t5;

use SN2_l5_t5;

CREATE TABLE Users (
    id INT PRIMARY KEY IDENTITY(1,1),
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100)
);

CREATE TABLE Post (
    id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT,
    post_text VARCHAR(MAX),
    post_date DATETIME,
    FOREIGN KEY (user_id) REFERENCES Users(id)
);

CREATE TABLE Comment (
    id INT PRIMARY KEY IDENTITY(1,1),
    post_id INT,
    user_id INT,
    parent_comment_id INT NULL,
    comment_text VARCHAR(MAX),
    comment_date DATETIME,
    path VARCHAR(MAX) NULL,
    FOREIGN KEY (post_id) REFERENCES Post(id),
    FOREIGN KEY (user_id) REFERENCES Users(id),
    FOREIGN KEY (parent_comment_id) REFERENCES Comment(id)
);

drop table Comment

INSERT INTO Users (first_name, last_name, email)
VALUES ('John', 'Doe', 'johndoe@email.com'),
       ('Jane', 'Doe', 'janedoe@email.com'),
       ('Bob', 'Smith', 'bobsmith@email.com'),
       ('Alice', 'Johnson', 'alicejohnson@email.com');

-- Insert some test data into the Post table
INSERT INTO Post (user_id, post_text, post_date)
VALUES (1, 'This is a test post by John', '2022-01-01 10:00:00'),
       (2, 'This is a test post by Jane', '2022-01-02 11:00:00'),
       (1, 'Another test post by John', '2022-01-03 12:00:00'),
       (3, 'Test post by Bob', '2022-01-04 13:00:00');

-- Insert some test data into the Comment table

INSERT INTO Comment (post_id, user_id, parent_comment_id, comment_text, comment_date, path)
VALUES 
    (1, 1, NULL, 'This is a comment by John on his own post', '2022-01-01 12:00:00', '/1/'),
    (1, 2, 1, 'This is a reply by Jane to John''s comment', '2022-01-01 13:00:00', '/1/2/'),
    (1, 3, NULL, 'This is a comment by Bob on John''s post', '2022-01-01 14:00:00', '/3/'),
    (1, 4, 2, 'This is a reply by Alice to Jane''s comment', '2022-01-01 15:00:00', '/1/2/4/');

	
CREATE PROCEDURE GetCommentWithChildren
    @commentId INT
AS
BEGIN
    WITH CommentTree AS (
        SELECT id, post_id, user_id, parent_comment_id, comment_text, comment_date, path, 0 AS Level
        FROM Comment
        WHERE id = @commentId
        UNION ALL
        SELECT c.id, c.post_id, c.user_id, c.parent_comment_id, c.comment_text, c.comment_date, c.path, Level + 1
        FROM Comment c
        INNER JOIN CommentTree ct ON ct.id = c.parent_comment_id
    )
    SELECT id, post_id, user_id, parent_comment_id, comment_text, comment_date, path, Level
    FROM CommentTree
    ORDER BY path
END


EXEC GetCommentWithChildren @commentId = 3;



CREATE PROCEDURE sp_AddSubordinateComment
    @parent_comment_id INT,
    @post_id INT,
    @user_id INT,
    @comment_text VARCHAR(MAX),
    @comment_date DATETIME
AS
BEGIN
    -- Get the path of the parent comment
    DECLARE @parent_path VARCHAR(MAX);
    SELECT @parent_path = path FROM Comment WHERE id = @parent_comment_id;

    -- Get the maximum path value for the parent comment's children
    DECLARE @max_path VARCHAR(MAX);
    SELECT @max_path = MAX(path) FROM Comment WHERE path LIKE @parent_path + '%';

    -- Determine the new path value for the new comment
    DECLARE @new_path VARCHAR(MAX);
    IF @max_path IS NULL
        SET @new_path = @parent_path + '1/';
    ELSE
        SET @new_path = @parent_path + CAST(CAST(RIGHT(@max_path, CHARINDEX('/', REVERSE(@max_path)) - 1) AS INT) + 1 AS VARCHAR(10)) + '/';

    -- Insert the new comment with its path
    INSERT INTO Comment (post_id, user_id, parent_comment_id, comment_text, comment_date, path)
    VALUES (@post_id, @user_id, @parent_comment_id, @comment_text, @comment_date, @new_path);
END

EXEC sp_AddSubordinateComment @parent_comment_id = 3, @post_id = 1, @user_id = 2, @comment_text = 'This is a reply by Jane to Bob''s comment', @comment_date = '2022-01-01 14:00:00';
