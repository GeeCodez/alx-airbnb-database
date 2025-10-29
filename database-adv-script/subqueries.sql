SELECT name from property 
WHERE property_id IN (
    SELECT property_id FROM review
    GROUP BY property_id
    HAVING AVG(rating) > 4.0
);

-- correlated subquery to find users with more than 3 bookings
SELECT u.first_name || ' ' || u.last_name AS username
FROM users u
WHERE (
    SELECT COUNT(*) FROM booking b
    WHERE b.user_id = u.user_id
) > 3;