--writing query to fetch the first and last name of the users as username and return all their booking
SELECT users.first_name ||' '|| users.last_name as  username, booking.booking_id
FROM users INNER JOIN booking 
ON users.user_id=booking.user_id;

--retrieving all properties and their reviews using the left join including those without reviews
SELECT property.name, review.comment, review.rating FROM property
LEFT JOIN review
ON property.property_id=review.property_id ORDER BY property.name;

--using full outer join to get all users and even if a user has not bookings
SELECT users.first_name ||' '|| users.last_name as username, booking.booking_id
FROM  users FULL OUTER JOIN booking
ON users.user_id=booking.user_id;

--using full outer join to get all users and their bookings including those without bookings and adding some more details
SELECT users.first_name ||' '|| users.last_name as username,booking.created_at, booking.booking_id, booking.start_date, booking.end_date
FROM users FULL OUTER JOIN booking
ON users.user_id=booking.user_id;