--query to find the number of booking by each user using the group by clause
SELECT u.first_name ||' '||u.last_name AS username , COUNT(b.booking_id) as total_bookings
FROM users u JOIN booking b ON u.user_id=b.user_id 
GROUP BY username;

SELECT p.name, COUNT(b.booking_id) AS total_bookings, RANK() OVER
    (ORDER BY count(b.booking_id) DESC) AS booking_rank
    FROM property p JOIN booking b ON p.property_id=b.property_id
    GROUP p.name;