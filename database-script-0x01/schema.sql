CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE users(
user_id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(30) NOT NULL,
email VARCHAR(50) UNIQUE NOT NULL,
password_hash VARCHAR(50) NOT NULL,
role user_role NOT NULL,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE INDEX user_index ON users(user_id);

CREATE TABLE property(
property_id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
host_id UUID REFERENCES users(user_id),
name VARCHAR(50) NOT NULL,
description TEXT NOT NULL,
location VARCHAR(50) NOT NULL,
pricepernight DECIMAL NOT NULL,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE INDEX property_index ON property(property_id);

--CREATING THE BOOKING TABLE
CREATE TYPE status_s as ENUM('pending','confirmed','canceled');
CREATE TABLE booking (
booking_id UUID DEFAULT uuid_generate_v4() PRIMARY KEY ,
property_id UUID REFERENCES property(property_id),
user_id UUID REFERENCES users(user_id),
start_date DATE NOT NULL,
end_date DATE NOT NULL,
total_price DECIMAL NOT NULL,
status status_s NOT NULL,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--CREATING THE PAYMENT TABLE
CREATE TYPE payment_m as ENUM('credit_card','paypal','stripe');
CREATE TABLE payment (
payment_id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
booking_id UUID REFERENCES booking(booking_id),
amount DECIMAL NOT NULL,
payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
payment_method payment_m NOT NULL
);
CREATE INDEX booking_index ON payment(payment_id);

--creating the review table
CREATE TABLE review (
review_id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
property_id UUID REFERENCES property(property_id),
user_id UUID REFERENCES users(user_id),
rating INTEGER CHECK(rating >1 AND rating <=5) NOT NULL, 
comment TEXT NOT NULL,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE INDEX review_index ON review(review_id);

CREATE TABLE message(
message_id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
sender_id UUID REFERENCES users(user_id),
recipient_id UUID REFERENCES users(user_id),
message_body TEXT NOT NULL, 
sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE INDEX message_index ON message(message_id);

