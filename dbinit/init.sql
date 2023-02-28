CREATE DATABASE IF NOT EXISTS rzgf6652_test_db;

USE rzgf6652_test_db;

DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id          BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    name        VARCHAR(255) NOT NULL,
    email       VARCHAR(255) NOT NULL,
    password    VARCHAR(255) NOT NULL,
    image_path  VARCHAR(255) DEFAULT NULL,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    CONSTRAINT UQ_Users_Email UNIQUE (email)
);

INSERT INTO users(`id`, `name`, `email`, `password`, `image_path`, `created_at`) VALUES (1,'karl','karl@gmail.com','123456789','http','2023-02-02');

DELIMITER //
CREATE PROCEDURE create_and_return(IN name VARCHAR(255), IN email VARCHAR(255), IN password VARCHAR(255), IN image_path VARCHAR(255))
BEGIN
    INSERT INTO users(name, email, password, image_path) VALUES (name, email, password, image_path);
    SET @USER_ID = LAST_INSERT_ID();
    SELECT * FROM users WHERE id=@USER_ID;
END //
DELIMIER ;

-- DROP TABLE IF EXISTS comments;

CREATE TABLE comments (
    id          BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    content     VARCHAR(255) NOT NULL,
    user_id     BIGINT NOT NULL,
    game_id     BIGINT UNSIGNED NOT NULL,
    -- ID supp pour réponse à un autre commentaire? 
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES users (id) 
);

-- DROP TABLE IF EXISTS likes;

CREATE TABLE likes (
    id          BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    game_id     BIGINT UNSIGNED NOT NULL,
    user_id     BIGINT REFERENCES users (id),
    PRIMARY KEY (id),
    -- FOREIGN KEY (user_id) REFERENCES users (id) UTILE?
);

-- DROP TABLE IF EXISTS to_play;

CREATE TABLE to_play (
    id          BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    game_id     BIGINT UNSIGNED NOT NULL,
    user_id     BIGINT REFERENCES users (id),
    PRIMARY KEY (id),
    -- FOREIGN KEY (user_id) REFERENCES users (id) UTILE?
);
