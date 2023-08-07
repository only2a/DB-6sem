-- Create database
CREATE DATABASE SocialNetwork;

-- Set new database as current database
USE SocialNetwork;

-- Create tables
CREATE TABLE Users (
    id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100)
);

CREATE TABLE Post (
    id INT PRIMARY KEY,
    user_id INT,
    post_text VARCHAR(MAX),
    post_date DATETIME,
    FOREIGN KEY (user_id) REFERENCES Users(id)
);

CREATE TABLE Comment (
    id INT PRIMARY KEY,
    post_id INT,
    user_id INT,
    comment_text VARCHAR(MAX),
    comment_date DATETIME,
    FOREIGN KEY (post_id) REFERENCES Post(id),
    FOREIGN KEY (user_id) REFERENCES Users(id)
);

CREATE TABLE Likes (
    id INT PRIMARY KEY,
    post_id INT,
    user_id INT,
    like_date DATETIME,
    FOREIGN KEY (post_id) REFERENCES Post(id),
    FOREIGN KEY (user_id) REFERENCES Users(id)
);

CREATE TABLE Friendships (
    id INT PRIMARY KEY,
    user_id_1 INT,
    user_id_2 INT,
    frendship_date DATETIME,
    FOREIGN KEY (user_id_1) REFERENCES Users(id),
    FOREIGN KEY (user_id_2) REFERENCES Users(id)
);

CREATE TABLE Messages (
    id INT PRIMARY KEY,
    sender_id INT,
    receiver_id INT,
    message_text VARCHAR(MAX),
    message_date DATETIME,
    FOREIGN KEY (sender_id) REFERENCES Users(id),
    FOREIGN KEY (receiver_id) REFERENCES Users(id)
);

create table log (
id INT PRIMARY KEY IDENTITY(1,1),
operation_text VARCHAR(MAX),
operation_date DATETIME,
);

drop table log