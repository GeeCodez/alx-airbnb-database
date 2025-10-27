-- ===========================
-- NEW USERS
-- ===========================
INSERT INTO users (first_name, last_name, email, password_hash, role)
VALUES
('Frank', 'Thompson', 'frank@example.com', 'hash6', 'guest'),
('Grace', 'Harris', 'grace@example.com', 'hash7', 'guest'),
('Henry', 'Adams', 'henry@example.com', 'hash8', 'host'),
('Isabel', 'Clark', 'isabel@example.com', 'hash9', 'host'),
('Jack', 'Wong', 'jack@example.com', 'hash10', 'guest');

-- ===========================
-- NEW PROPERTIES
-- ===========================
INSERT INTO property (host_id, name, description, location, pricepernight)
SELECT h.user_id,
       p.name,
       p.description,
       p.location,
       p.price
FROM (
  VALUES
  ('Cozy Loft', 'Chic loft in city center with modern amenities.', 'San Francisco', 220.00),
  ('Lake House', 'Peaceful house by the lake with boat access.', 'Minnesota', 180.00),
  ('Urban Studio', 'Compact studio perfect for solo travelers.', 'Chicago', 120.00),
  ('Country Farmhouse', 'Spacious farmhouse with garden and barn.', 'Texas', 200.00)
) AS p(name, description, location, price),
LATERAL (
  SELECT user_id FROM users WHERE role = 'host' ORDER BY random() LIMIT 1
) AS h;

-- ===========================
-- NEW BOOKINGS
-- ===========================
INSERT INTO booking (property_id, user_id, start_date, end_date, total_price, status)
SELECT p.property_id,
       u.user_id,
       d.start_date,
       d.end_date,
       (p.pricepernight * (d.end_date - d.start_date))::DECIMAL AS total_price,
       d.status::status_s
FROM (
  VALUES
  ('2025-11-20'::DATE, '2025-11-25'::DATE, 'confirmed'),
  ('2025-12-05'::DATE, '2025-12-08'::DATE, 'pending'),
  ('2025-12-15'::DATE, '2025-12-18'::DATE, 'canceled'),
  ('2025-12-20'::DATE, '2025-12-27'::DATE, 'confirmed')
) AS d(start_date, end_date, status),
LATERAL (SELECT property_id, pricepernight FROM property ORDER BY random() LIMIT 1) AS p,
LATERAL (SELECT user_id FROM users WHERE role = 'guest' ORDER BY random() LIMIT 1) AS u;

-- ===========================
-- PAYMENTS (only for confirmed bookings)
-- ===========================
INSERT INTO payment (booking_id, amount, payment_method)
SELECT booking_id,
       total_price,
       (ARRAY['credit_card'::payment_m, 'paypal'::payment_m, 'stripe'::payment_m])[floor(random()*3 + 1)]
FROM booking
WHERE status = 'confirmed';

-- ===========================
INSERT INTO review (property_id, user_id, rating, comment)
SELECT p.property_id,
       u.user_id,
       (floor(random()*4) + 2)::INT,  -- ensures rating is between 2 and 5
       (ARRAY[
         'Wonderful experience!',
         'Very clean and comfortable.',
         'Great location but a bit noisy.',
         'Had an amazing time!',
         'Would definitely stay again!'
       ])[floor(random()*5 + 1)]
FROM property p
JOIN users u ON u.role = 'guest'
ORDER BY random()
LIMIT 8;

-- ===========================
-- MESSAGES
-- ===========================
INSERT INTO message (sender_id, recipient_id, message_body)
SELECT g.user_id, h.user_id,
       (ARRAY[
         'Is the property pet-friendly?',
         'Can we extend our stay by 2 nights?',
         'Thank you for hosting us!',
         'What time is check-in?',
         'Looking forward to our stay!'
       ])[floor(random()*5 + 1)]
FROM users g
JOIN users h ON g.role = 'guest' AND h.role = 'host'
ORDER BY random()
LIMIT 10;
