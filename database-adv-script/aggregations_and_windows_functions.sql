--query to find the number of booking by each user using the group by clause
select u.first_name ||' '||u.last_name as username , count(b.booking_id) as total_bookings
from users u join booking b on u.user_id=b.user_id 
group by username;

select p.name, count(b.booking_id) as total_bookings, rank() OVER
    (ORDER BY count(b.booking_id) DESC) as booking_rank
    from property p join booking b on p.property_id=b.property_id
    group by p.name;