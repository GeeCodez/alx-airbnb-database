INSERT INTO users (first_name, last_name, email, password_hash, role)
VALUES
('Alice', 'Smith', 'alice@example.com', 'hash1', 'guest'),
('Bob', 'Johnson', 'bob@example.com', 'hash2', 'host'),
('Carol', 'Williams', 'carol@example.com', 'hash3', 'admin');

INSERT INTO property (host_id, name, description, location, price_per_night)
VALUES
((SELECT user_id FROM users WHERE email='bob@example.com'),'Seaside Villa','A beautiful villa by the sea.','Miami, FL',250.00),
((SELECT user_id FROM users WHERE email= 'bob@example.com'), 'Mountain Cabin','Cozy cabin in the mountains.','Aspen, CO',180.00),
((SELECT user_id FROM users WHERE email= 'bob@example.com'), 'City Apartment','Modern apartment in the city center.','New York, NY',220.00);

-- Replace property_id and user_id with actual UUIDs from users/property tables
INSERT INTO booking (property_id, user_id, start_date, end_date, total_price, status)
VALUES
((SELECT property_id FROM property WHERE name='Seaside Villa'), 
 (SELECT user_id FROM users WHERE email='alice@example.com'), '2025-11-01', '2025-11-05', 1000.00, 'confirmed'),

((SELECT property_id FROM property WHERE name='Mountain Cabin'), 
 (SELECT user_id FROM users WHERE email='alice@example.com'), '2025-11-10', '2025-11-12', 360.00, 'pending'),

((SELECT property_id FROM property WHERE name='City Apartment'), 
 (SELECT user_id FROM users WHERE email='alice@example.com'), '2025-11-20', '2025-11-25', 600.00, 'confirmed');

-- Use the booking_id generated automatically
INSERT INTO payment (booking_id, amount, payment_method)
VALUES
((SELECT booking_id FROM booking WHERE total_price=1000.00), 1000.00, 'credit_card'),
((SELECT booking_id FROM booking WHERE total_price=360.00), 360.00, 'paypal'),
((SELECT booking_id FROM booking WHERE total_price=600.00), 600.00, 'stripe');

INSERT INTO review (property_id, user_id, rating, comment)
VALUES
((SELECT property_id FROM property WHERE name='Seaside Villa'), 
 (SELECT user_id FROM users WHERE email='alice@example.com'), 5, 'Amazing stay! Highly recommend.'),

((SELECT property_id FROM property WHERE name='Mountain Cabin'), 
 (SELECT user_id FROM users WHERE email='alice@example.com'), 4, 'Cozy cabin, great for a weekend.'),

((SELECT property_id FROM property WHERE name='City Apartment'), 
 (SELECT user_id FROM users WHERE email='alice@example.com'), 3, 'Nice apartment, but noisy area.');

INSERT INTO message (sender_id, receiver_id, message_body)
VALUES
((SELECT user_id FROM users WHERE email='alice@example.com'), 
 (SELECT user_id FROM users WHERE email='bob@example.com'), 'Hi Bob, I am interested in your villa.'),

((SELECT user_id FROM users WHERE email='bob@example.com'), 
 (SELECT user_id FROM users WHERE email='alice@example.com'), 'Hi Alice, the villa is available for your dates.'),

((SELECT user_id FROM users WHERE email='alice@example.com'), 
 (SELECT user_id FROM users WHERE email='bob@example.com'), 'Great, I will book it now!');
