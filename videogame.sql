CREATE DATABASE IF NOT EXISTS videogame;
USE videogame;

CREATE TABLE Customer (
    customer_id INT AUTO_INCREMENT,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(60) NOT NULL,
    first_name VARCHAR(60) NOT NULL,
    last_name VARCHAR(60) NOT NULL,
    address_1 VARCHAR(60) NOT NULL,
    address_2 VARCHAR(60),
    province VARCHAR(60) NOT NULL,
    city VARCHAR(60) NOT NULL,
    postal_code VARCHAR(6) NOT NULL,
    phone VARCHAR(11) NOT NULL,
    PRIMARY KEY (customer_id)
    );
    
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATETIME NOT NULL,
    PRIMARY KEY (order_id),
    FOREIGN KEY (customer_id) REFERENCES Customer (customer_id)
    );
    
CREATE TABLE Order_Track (
	order_id INT AUTO_INCREMENT,
    order_status ENUM('Processing', 'Shipped', 'Delivered'),
    date DATETIME NOT NULL, 
    FOREIGN KEY (order_id) REFERENCES Orders (order_id)
    );

CREATE TABLE Genre (
	genre_id INT AUTO_INCREMENT, 
    genre_name VARCHAR(60) NOT NULL,
    PRIMARY KEY (genre_id)
);

CREATE TABLE Platform (
	platform_id INT AUTO_INCREMENT, 
    platform_name VARCHAR(60) NOT NULL,
    PRIMARY KEY (platform_id)
);
    
CREATE TABLE Products (
    product_id INT AUTO_INCREMENT,
    genre_id INT NOT NULL,
    platform_id INT NOT NULL, 
    product_name VARCHAR(255) NOT NULL, 
    game_description TEXT,
    release_date DATE NOT NULL, 
    max_play_num TINYINT NOT NULL,
    storage_size DECIMAL(5,2) NOT NULL, 
    online_play BOOLEAN NOT NULL, 
    unit_price DECIMAL (5,2) NOT NULL, 
    stock INT NOT NULL,
    PRIMARY KEY (product_id),
    FOREIGN KEY (genre_id) REFERENCES Genre (genre_id),
    FOREIGN KEY (platform_id) REFERENCES Platform (platform_id)
);

CREATE TABLE Order_Details (
    order_id INT NOT NULL AUTO_INCREMENT,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders (order_id),
    FOREIGN KEY (product_id) REFERENCES Products (product_id)
);
    
INSERT INTO `Customer` VALUES 
(1,'samsmith@hotmail.com','w349fhiodbt', 'Sam', 'Smith', '248 Woodhaven Road', NULL, 'Ontario', 'Kitchener', 'N2C1V5', '5192615555'), 
(2,'joejones@gmail.com', 'fiwbwiebg4', 'Joe', 'Jones', '40 Cardill Crescent', NULL, 'Ontario', 'Waterloo', 'N2L3Y6', '5192617733'),
(3,'susan.wilde@gmail.com', 'dbiwfb3ircb3', 'Susan', 'Wilde', '771 Main Street', 'Unit 2', 'Saskatchewan', 'Canwood', 'S0J0K0', '5193134321'),
(4,'stephanie.singeris@gmail.com', 'hnxfvdsfgvser56', 'Stephanie', 'Singeris', '1020 Portsmouth Ave', 'Unit 1', 'Ontario', 'kingston', 'K7M1X3', '5196046680'),
(5,'milton.forbes@hotmail.com', 'qwwdbiefbrubf', 'Milton', 'Forbes', '12 Cheyanne Meadows Gate North', NULL, 'Alberta', 'Calgary', 'T3R1B7', '4035474328')
;

INSERT INTO `Orders` VALUES 
(1, 1, '2020-03-22 09:30:21'),
(2, 3, '2020-05-12 10:18:59'), 
(3, 2, '2020-08-21 14:22:48'),
(4, 1, '2020-10-18 19:30:18'),
(5, 5, '2020-11-14 08:00:02'),
(6, 2, '2020-11-15 11:04:23'),
(7, 1, '2020-11-16 12:45:38'),
(8, 4, '2020-11-17 16:21:33');

INSERT INTO `Order_Track` VALUES
(1, 'Processing','2020-03-22 9:30:21'),
(1, 'Shipped', '2020-03-23 11:40:46'),
(1, 'Delivered', '2020-03-26 16:21:21'),
(2, 'Processing', '2020-05-12 10:18:59'),
(2, 'Shipped', '2020-05-13 8:18:43'),
(2, 'Delivered', '2020-05-17 13:12:01'),
(3, 'Processing', '2020-08-21 14:22:48'), 
(3, 'Shipped', '2020-08-22 09:52:49'),
(3, 'Delivered', '2020-08-28 13:32:50'),
(4, 'Processing', '2020-10-18 19:30:18'),
(4, 'Shipped', '2020-10-19 09:43:23'), 
(4, 'Delivered', '2020-10-22 12:53:55'), 
(5, 'Processing', '2020-11-14 08:00:02'),
(5, 'Shipped', '2020-11-16 12:10:23'),
(5, 'Delivered', '2020-11-19 09:12:59'),
(6, 'Processing', '2020-11-15 11:04:23'),
(6, 'Shipped', '2020-11-16 10:40:41'),
(6, 'Delivered', '2020-11-20 15:31:25'),
(7, 'Processing', '2020-11-16 12:45:38'),
(7, 'Shipped', '2020-11-17 09:12:11'),
(8, 'Processing', '2020-11-17 16:21:33'), 
(8, 'Shipped', '2020-11-18 09:55:46');

INSERT INTO `Genre` VALUES 
(1, 'simulation'),
(2, 'adventure'), 
(3, 'sport'),
(4, 'shooter'), 
(5, 'racing'); 

INSERT INTO `Platform` VALUES 
(1, 'Nintendo Switch'),
(2, 'PlayStation 4'), 
(3, 'Xbox One');

INSERT INTO `Products` VALUES
(1001, 1, 1, 'Animal Crossing: New Horizons', 'Escape to a deserted island and create your own paradise as you explore, create, and customize in the Animal Crossing: New Horizons game. Your island getaway has a wealth of natural resources that can be used to craft everything from tools to creature comforts. You can hunt down insects at the crack of dawn, decorate your paradise throughout the day, or enjoy sunset on the beach while fishing in the ocean. The time of day and season match real life, so each day on your island is a chance to check in and find new surprises all year round.','2020-03-20', '1', '6.2', TRUE, '79.99', 20),
(1002, 3, 3, 'FIFA 21', 'Win as one on the street and in the stadium in FIFA 21 for Xbox 1. Fresh features let you enjoy even bigger victories together in Volta Football and FIFA Ultimate Team, manage every moment in Career Mode, and experience a new level of gameplay realism that rewards you for creativity and control, with unrivalled true-to-life authenticity.', '2020-10-09', '4', '50', TRUE, '79.99', 20),
(1003, 4, 2, 'Call of Duty: Cold War', 'Challenge historical figures and disturbing truths to prevent the enemy from shifting the global balance of power in Call of Duty: Black Ops Cold War for PlayStation 4. From East Berlin to Vietnam and the Soviet KGB headquarters, it offers thrilling action set during one of the most important geopolitical battles of the 20th century. Which side of history will win?', '2020-11-13', '4', '190', TRUE, '89.99', 30),
(1004, 2, 1, 'The Legend of Zelda: Breath of the Wild', 'Experience the Kingdom of Hyrule like never before in The Legend of Zelda: Breath of the Wild for Nintendo Switch. After Link wakes up from a 100-year slumber, he must explore the land he no longer remembers, travel through the open-air world, collect weaponry for combat, and strive to regain his memories.', '2017-03-03', '1', '13.4', FALSE, '79.99', 15), 
(1005, 5, 3, 'Need 4 Speed: Heat', 'Hustle by day and risk it all at night in Need for Speed Heat, a white-knuckle street racer, where the lines of the law fade as the sun starts to set. By day, Palm City hosts the Speedhunter Showdown, a sanctioned competition where you earn Bank to customize and upgrade your high-performance cars. At night, ramp up the intensity in illicit street races that build your reputation, getting you access to bigger races and better parts. But stay ready – cops are waiting and not all of them play fair.', '2019-11-08', '1', '28', TRUE, '29.99', 11);  

INSERT INTO `Order_Details` VALUES
(1, 1001, 2),
(2, 1005, 1), 
(3, 1004, 1),
(4, 1002, 1),
(5, 1003, 1),
(6, 1003, 1),
(7, 1003, 1),
(8, 1001, 1);
