--ANALYSIS BEFORE INDEXES
EXPLAIN ANALYSE
SELECT * FROM users WHERE role='admin';

--CREATE INDEXS
CREATE INDEX property_id_index ON property(property_id);
CREATE INDEX property_id_b_index ON booking(property_Id);
CREATE INDEX booking_id_index ON booking(booking_id);
CREATE INDEX booking_id_p_index ON payment(booking_id);
CREATE INDEX email_index ON users(email);

--ANALYSIS AFTER INDEXES
EXPLAIN ANALYSE
SELECT * FROM users WHERE role='admin';