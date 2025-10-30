-- INITTIAL QUERY TO CHECK PERFORMANCE BY RETRIEVING ALL RECORDS FROM ALL TABLES
EXPLAIN 
SELECT u.*,p.*,b.*,pr.* FROM users u
JOIN booking b ON u.user_id = b.user_id
JOIN property pr ON b.property_id = pr.property_id
JOIN payment p ON b.booking_id = p.booking_id;


-- FINAL QUERY TO CHECK PERFORMANCE BY JOINING ALL TABLES BASED ON THEIR RELATIONSHIPS

SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.role,
    b.booking_id,
    b.start_date,
    b.status AS booking_status,
    pr.property_id,
    pr.name AS property_name,
    pr.location,
    p.payment_id,
    p.amount,
    p.payment_date
FROM booking b
JOIN users u ON b.user_id = u.user_id
JOIN property pr ON b.property_id = pr.property_id
JOIN payment p ON b.booking_id = p.booking_id;
