# Airbnb Database Normalization to 3NF

## Objective
The goal of this project is to apply database normalization principles to ensure that the Booking Platform database is structured in **Third Normal Form (3NF)**. This reduces redundancy, avoids update anomalies, and ensures data integrity.

## Initial Schema
The initial database schema was based on the following entities and attributes:

- **User**: `user_id (PK)`, `first_lastname`, `email`, `password_hash`, `phone_number`, `role (guest, host, admin)`, `created_at`
- **Property**: `property_id (PK)`, `host_id (FK → User)`, `name`, `description`, `location`, `pricepernight`, `created_at`, `updated_at`
- **Booking**: `booking_id (PK)`, `property_id (FK → Property)`, `user_id (FK → User)`, `start_date`, `end_date`, `total_price`, `status`, `created_at`
- **Payment**: `payment_id (PK)`, `booking_id (FK → Booking)`, `amount`, `payment_date`, `payment_method`
- **Review**: `review_id (PK)`, `property_id (FK → Property)`, `user_id (FK → User)`, `rating`, `comment`, `created_at`
- **Message**: `message_id (PK)`, `sender_id (FK → User)`, `recipient_id (FK → User)`, `message_body`, `sent_at`

## Normalization Steps

### Step 1: 1NF
- Ensured all attributes are atomic.
- Each table has a primary key.
- No repeating groups or arrays exist.

### Step 2: 2NF
- All tables have single-column primary keys.
- No partial dependencies were found.

### Step 3: 3NF
- Identified transitive dependencies:
  - `total_price` in Booking is derived from `pricepernight * number_of_nights` and can be calculated rather than stored.
  - Users have different roles (guest, host, admin). Role-specific attributes will be separated into their own tables when all details are available.
- Adjusted design to avoid redundancy and ensure attributes depend only on primary keys.

### Step 4: Role-specific Tables
- While the current 3NF maintains a single Users table, future improvements will include separate tables for **Guests**, **Hosts**, and **Admins** to store role-specific attributes without creating nulls in the Users table.

### Step 5: Other Considerations
- Payment methods may be normalized into a lookup table in future iterations.
- Relationships between entities are defined using foreign keys to maintain referential integrity.

## Current 3NF Tables


> **Note:** The final normalized form including all role-specific tables and derived attributes adjustments will be added when all details for guests, hosts, and admins are finalized.

## Summary
This database design ensures:
- Atomic attributes and elimination of redundancy.
- Referential integrity through foreign keys.
- Flexibility for future expansion to handle role-specific attributes and additional lookup tables.