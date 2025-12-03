DROP TABLE IF EXISTS booking_commercials;
DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS rooms;
DROP TABLE IF EXISTS guests;


CREATE TABLE rooms (
room_id INT PRIMARY KEY,
room_number VARCHAR(10) NOT NULL,
room_type VARCHAR(50)
);


CREATE TABLE guests (
guest_id INT PRIMARY KEY,
guest_name VARCHAR(100)
);


CREATE TABLE bookings (
booking_id INT PRIMARY KEY,
guest_id INT,
room_id INT,
start_date DATE,
end_date DATE,
booked_at DATETIME,
FOREIGN KEY (guest_id) REFERENCES guests(guest_id),
FOREIGN KEY (room_id) REFERENCES rooms(room_id)
);


CREATE TABLE items (
item_id INT PRIMARY KEY,
item_name VARCHAR(100),
rate DECIMAL(10,2)
);


CREATE TABLE booking_commercials (
bc_id INT PRIMARY KEY,
booking_id INT,
item_id INT,
quantity INT,
FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
FOREIGN KEY (item_id) REFERENCES items(item_id)
);


-- Sample data
INSERT INTO rooms VALUES
(1, '101', 'Single'),
(2, '102', 'Double'),
(3, '201', 'Suite');


INSERT INTO guests VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie');


INSERT INTO bookings VALUES
(1, 1, 1, '2021-10-30', '2021-11-02', '2021-10-29 18:23:00'),
(2, 2, 2, '2021-11-05', '2021-11-06', '2021-11-05 09:10:00'),
(3, 3, 3, '2021-11-20', '2021-11-21', '2021-11-20 14:00:00'),
(4, 1, 2, '2021-12-01', '2021-12-03', '2021-12-01 08:00:00');


INSERT INTO items VALUES
(1, 'Breakfast', 150.00),
(2, 'Lunch', 300.00),
(3, 'Spa', 800.00),
(4, 'Extra Bed', 500.00);


INSERT INTO booking_commercials VALUES
(1, 1, 1, 2),
(2, 1, 2, 1), 
(3, 2, 1, 1), 
(4, 2, 4, 1), 
(5, 3, 3, 1), 
(6, 3, 2, 2), 
(7, 4, 1, 3), 
(8, 4, 4, 1); 