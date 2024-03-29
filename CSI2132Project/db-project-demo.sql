-- ----------------------------
-- Table structure for students
-- ----------------------------
DROP TABLE IF EXISTS students;
CREATE TABLE students (
  id serial PRIMARY KEY,
  name varchar(45) NOT NULL,
  surname varchar(45) NOT NULL,
  email varchar(100) NOT NULL CHECK (email LIKE '_%@_%._%')
);

-- ----------------------------
-- Records of students
-- ----------------------------
INSERT INTO students VALUES ('1', 'Cristiano', 'Ronaldo', 'cr7@mail.com');
INSERT INTO students VALUES ('2', 'Lionel', 'Messi', 'lm10@mail.com');
INSERT INTO students VALUES ('3', 'Pedro', 'Wilkinson', 'Salma74@yahoo.com');
INSERT INTO students VALUES ('4', 'Lana', 'Larkin', 'Dale_Jast@yahoo.com');
INSERT INTO students VALUES ('5', 'Daniel', 'Kovacek', 'Janelle_Anderson@gmail.com');
INSERT INTO students VALUES ('6', 'Stewart', 'Botsford', 'Delaney4@yahoo.com');
INSERT INTO students VALUES ('7', 'Charlotte', 'Shanahan', 'Damon_Cremin@yahoo.com');
INSERT INTO students VALUES ('8', 'Pete', 'Bauch', 'Aisha55@yahoo.com');
INSERT INTO students VALUES ('9', 'Lori', 'Baumbach', 'Jude8@yahoo.com');
INSERT INTO students VALUES ('10', 'Ignacio', 'Kuhn', 'Shea_Hayes@hotmail.com');
INSERT INTO students VALUES ('11', 'Marsha', 'Kon', 'Brigitte.Macejkovic@gmail.com');
INSERT INTO students VALUES ('12', 'Lora', 'Mann', 'Orland_Welch@hotmail.com');
-- ----------------------------
-- Table structure for grades
-- ----------------------------
DROP TABLE IF EXISTS grades;
CREATE TABLE IF NOT EXISTS grades (
  id int PRIMARY KEY,
  course_name varchar(45) NOT NULL,
  grade int NOT NULL CHECK (grade >= 0 AND grade <= 100),
  student_id int NOT NULL REFERENCES students(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- ----------------------------
-- Records of grades
-- ----------------------------
INSERT INTO grades VALUES ('1', 'PAC', '87', '1');
INSERT INTO grades VALUES ('2', 'SHO', '93', '1');
INSERT INTO grades VALUES ('3', 'PAS', '82', '1');
INSERT INTO grades VALUES ('4', 'DRI', '88', '1');
INSERT INTO grades VALUES ('5', 'DEF', '34', '1');
INSERT INTO grades VALUES ('6', 'PHY', '75', '1');
INSERT INTO grades VALUES ('7', 'PAC', '85', '2');
INSERT INTO grades VALUES ('8', 'SHO', '92', '2');
INSERT INTO grades VALUES ('9', 'PAS', '91', '2');
INSERT INTO grades VALUES ('10', 'DRI', '95', '2');
INSERT INTO grades VALUES ('11', 'DEF', '34', '2');
INSERT INTO grades VALUES ('12', 'PHY', '65', '2');




-- Create the customer table
CREATE TABLE customer (
    customerID serial PRIMARY KEY,
    firstName VARCHAR(50),
    lastName VARCHAR(50),
    dateOfBirth DATE,
    idType VARCHAR(20),
    idNumber VARCHAR(50)
);

-- Insert 15 records into the customer table
INSERT INTO customer (firstName, lastName, dateOfBirth, idType, idNumber) VALUES
('John', 'Doe', '1990-05-15', 'Driver License', 'DL123456'),
('Jane', 'Smith', '1985-08-22', 'Passport', 'P1234567'),
('Michael', 'Johnson', '1978-12-10', 'Driver License', 'DL789012'),
('Emily', 'Brown', '1995-03-25', 'Passport', 'P2345678'),
('David', 'Martinez', '1982-07-18', 'Driver License', 'DL345678'),
('Sarah', 'Garcia', '1998-09-30', 'Passport', 'P3456789'),
('James', 'Lopez', '1973-01-05', 'Driver License', 'DL456789'),
('Jessica', 'Wilson', '1989-06-12', 'Passport', 'P4567890'),
('Daniel', 'Taylor', '1975-11-28', 'Driver License', 'DL567890'),
('Ashley', 'Miller', '1992-04-20', 'Passport', 'P5678901'),
('Christopher', 'Anderson', '1980-10-15', 'Driver License', 'DL678901'),
('Amanda', 'Jackson', '1993-07-08', 'Passport', 'P6789012'),
('Robert', 'Thompson', '1977-02-14', 'Driver License', 'DL7890123'),
('Michelle', 'White', '1984-05-27', 'Passport', 'P7890123'),
('William', 'Harris', '1991-08-03', 'Driver License', 'DL890123');


-- Create table hotelChain with a name column
CREATE TABLE hotelChain (
    chainID SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    centralOfficeAddress VARCHAR(255) ,
    numberOfHotels INT ,
    contactEmail VARCHAR(255) ,
    phoneNumber VARCHAR(20)
);

-- Insert 7 records into hotelChain
INSERT INTO hotelChain (name, centralOfficeAddress, numberOfHotels, contactEmail, phoneNumber)
VALUES
    ('HotelChain1', '123 Main Street, City1, State1, Country1', 10, 'info@hotelchain1.com', '+1234567890'),
    ('HotelChain2', '456 Elm Street, City2, State2, Country2', 15, 'info@hotelchain2.com', '+2345678901'),
    ('HotelChain3', '789 Oak Street, City3, State3, Country3', 20, 'info@hotelchain3.com', '+3456789012'),
    ('HotelChain4', '321 Pine Street, City4, State4, Country4', 25, 'info@hotelchain4.com', '+4567890123'),
    ('HotelChain5', '654 Cedar Street, City5, State5, Country5', 30, 'info@hotelchain5.com', '+5678901234'),
    ('HotelChain6', '987 Birch Street, City6, State6, Country6', 35, 'info@hotelchain6.com', '+6789012345'),
    ('HotelChain7', '210 Maple Street, City7, State7, Country7', 40, 'info@hotelchain7.com', '+7890123456');




 CREATE TABLE hotels (
     hotelID SERIAL PRIMARY KEY,
     chainID INT NOT NULL,
     name VARCHAR(100) NOT NULL,
     category INT NOT NULL,
     numberOfRooms INT NOT NULL,
     address VARCHAR(255) ,
     contactEmail VARCHAR(255) ,
     phoneNumber VARCHAR(20),
     FOREIGN KEY (chainID) REFERENCES hotelChain(chainID)
 );



 -- Insert records into hotels
 INSERT INTO hotels (chainID, name, category, numberOfRooms, address, contactEmail, phoneNumber)
 VALUES
     -- Hotel Chain 1
     (1, 'Hotel1', 5, 200, '123 Main St, City1, State1, Country1', 'hotel1@hotelchain1.com', '+1234567890'),
     (1, 'Hotel2', 4, 150, '456 Elm St, City1, State1, Country1', 'hotel2@hotelchain1.com', '+1234567890'),
     (1, 'Hotel3', 3, 100, '789 Oak St, City1, State1, Country1', 'hotel3@hotelchain1.com', '+1234567890'),
     (1, 'Hotel4', 2, 80, '321 Pine St, City1, State1, Country1', 'hotel4@hotelchain1.com', '+1234567890'),
     (1, 'Hotel5', 1, 50, '654 Cedar St, City1, State1, Country1', 'hotel5@hotelchain1.com', '+1234567890'),
     (1, 'Hotel6', 1, 50, '987 Birch St, City1, State1, Country1', 'hotel6@hotelchain1.com', '+1234567890'),
     (1, 'Hotel7', 2, 80, '210 Maple St, City1, State1, Country1', 'hotel7@hotelchain1.com', '+1234567890'),
     (1, 'Hotel8', 3, 100, '753 Walnut St, City1, State1, Country1', 'hotel8@hotelchain1.com', '+1234567890'),

     -- Hotel Chain 2
     (2, 'Hotel9', 5, 200, '123 Oak St, City2, State2, Country2', 'hotel9@hotelchain2.com', '+2345678901'),
     (2, 'Hotel10', 4, 150, '456 Cedar St, City2, State2, Country2', 'hotel10@hotelchain2.com', '+2345678901'),
     (2, 'Hotel11', 3, 100, '789 Pine St, City2, State2, Country2', 'hotel11@hotelchain2.com', '+2345678901'),
     (2, 'Hotel12', 2, 80, '321 Maple St, City2, State2, Country2', 'hotel12@hotelchain2.com', '+2345678901'),
     (2, 'Hotel13', 1, 50, '654 Elm St, City2, State2, Country2', 'hotel13@hotelchain2.com', '+2345678901'),
     (2, 'Hotel14', 1, 50, '987 Birch St, City2, State2, Country2', 'hotel14@hotelchain2.com', '+2345678901'),
     (2, 'Hotel15', 2, 80, '210 Cedar St, City2, State2, Country2', 'hotel15@hotelchain2.com', '+2345678901'),
     (2, 'Hotel16', 3, 100, '753 Walnut St, City2, State2, Country2', 'hotel16@hotelchain2.com', '+2345678901');




-- Create table rooms
CREATE TABLE rooms (
    roomID SERIAL PRIMARY KEY,
    hotelID INT NOT NULL,
    roomNumber VARCHAR(20) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    capacity INT NOT NULL,
    views VARCHAR(20) , -- Merged column for seaView and mountainView
    problems BOOLEAN ,
    petFriendly BOOLEAN N,
    FOREIGN KEY (hotelID) REFERENCES hotels(hotelID)
);


-- Insert records into rooms
INSERT INTO rooms (hotelID, roomNumber, price, capacity, views, problems, petFriendly)
VALUES
    -- Hotel 1
    (1, '101', 100.00, 2, 'Sea', false, true),
    (1, '102', 120.00, 2, 'Mountain', true, true),
    (1, '103', 150.00, 4, 'Sea, Mountain', false, false),
    (1, '104', 200.00, 4, 'Sea', false, true),
    (1, '105', 180.00, 3, 'Mountain', true, true),

    -- Hotel 2
    (2, '201', 80.00, 2, 'Sea', false, true),
    (2, '202', 90.00, 2, 'Mountain', false, true),
    (2, '203', 110.00, 3, 'Sea, Mountain', false, true),
    (2, '204', 120.00, 3, 'Sea', true, false),
    (2, '205', 100.00, 2, 'Mountain', true, true),



    -- Hotel 30
    (30, '301', 150.00, 4, 'Mountain', false, true),
    (30, '302', 200.00, 4, 'Sea', false, true),
    (30, '303', 180.00, 3, 'Sea, Mountain', true, false),
    (30, '304', 220.00, 4, 'Sea', false, true),
    (30, '305', 250.00, 5, 'Sea', true, false);


CREATE TABLE booking (
    bookingID SERIAL PRIMARY KEY,
    roomID INT NOT NULL,
    customerID INT NOT NULL,
    startDate DATE NOT NULL,
    endDate DATE NOT NULL,
    depositAmount DECIMAL(10, 2) ,
    FOREIGN KEY (roomID) REFERENCES rooms(roomID),
    FOREIGN KEY (customerID) REFERENCES customers(customerID)
);

-- Insert records into booking
INSERT INTO booking (roomID, customerID, startDate, endDate, depositAmount)
VALUES
    (1, 1, '2024-04-01', '2024-04-05', 100.00),
    (2, 2, '2024-04-02', '2024-04-06', 120.00),
    (3, 3, '2024-04-03', '2024-04-07', 150.00),
    (4, 4, '2024-04-04', '2024-04-08', 200.00),
    (5, 5, '2024-04-05', '2024-04-09', 180.00);