-- Create database
CREATE DATABASE SocialNetwork;




drop table UserLocation;

drop table Comment;
drop table Likes;
drop table Friendships;
drop table Messages;
drop table Post;
drop table Users;
-- Set new database as current database
USE SocialNetwork;

-- Create tables
CREATE TABLE Users (
    id INT PRIMARY KEY IDENTITY(1,1),
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
	created_at DATETIME,
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
    comment_text VARCHAR(MAX),
    comment_date DATETIME,
    FOREIGN KEY (post_id) REFERENCES Post(id),
    FOREIGN KEY (user_id) REFERENCES Users(id)
);

CREATE TABLE Likes (
    id INT PRIMARY KEY IDENTITY(1,1),
    post_id INT,
    user_id INT,
    like_date DATETIME,
    FOREIGN KEY (post_id) REFERENCES Post(id),
    FOREIGN KEY (user_id) REFERENCES Users(id)
);

CREATE TABLE Friendships (
    id INT PRIMARY KEY IDENTITY(1,1),
    user_id_1 INT,
    user_id_2 INT,
    frendship_date DATETIME,
    FOREIGN KEY (user_id_1) REFERENCES Users(id),
    FOREIGN KEY (user_id_2) REFERENCES Users(id)
);

CREATE TABLE Messages (
    id INT PRIMARY KEY IDENTITY(1,1),
    SenderId INT,
    ReceiverId INT,
    message_text VARCHAR(MAX),
    message_date DATETIME,
    FOREIGN KEY (SenderId) REFERENCES Users(id),
    FOREIGN KEY (ReceiverId) REFERENCES Users(id)
);

CREATE TABLE UserLocation (
    id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT,
    location geography,
    last_updated DATETIME,
    FOREIGN KEY (user_id) REFERENCES Users(id)
);