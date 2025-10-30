-- File: partitioning.sql

-- 1️⃣ Create the partitioned table
CREATE TABLE booking_partitioned (
    booking_id UUID NOT NULL DEFAULT uuid_generate_v4(),
    property_id UUID,
    user_id UUID,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price NUMERIC(10,2) NOT NULL,
    status booking_status NOT NULL DEFAULT 'pending'::booking_status,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT booking_pk UNIQUE (booking_id, start_date)  -- include partition column
) PARTITION BY RANGE (start_date);

-- 2️⃣ Create monthly partitions (example: Jan, Feb, Mar 2025)
CREATE TABLE booking_2025_01 PARTITION OF booking_partitioned
    FOR VALUES FROM ('2025-01-01') TO ('2025-02-01');

CREATE TABLE booking_2025_02 PARTITION OF booking_partitioned
    FOR VALUES FROM ('2025-02-01') TO ('2025-03-01');

CREATE TABLE booking_2025_03 PARTITION OF booking_partitioned
    FOR VALUES FROM ('2025-03-01') TO ('2025-04-01');

-- 3️⃣ Create indexes on frequently queried columns per partition
CREATE INDEX idx_booking_2025_01_property ON booking_2025_01(property_id);
CREATE INDEX idx_booking_2025_01_user ON booking_2025_01(user_id);

CREATE INDEX idx_booking_2025_02_property ON booking_2025_02(property_id);
CREATE INDEX idx_booking_2025_02_user ON booking_2025_02(user_id);

CREATE INDEX idx_booking_2025_03_property ON booking_2025_03(property_id);
CREATE INDEX idx_booking_2025_03_user ON booking_2025_03(user_id);

-- 4️⃣ Migrate existing data into partitions
INSERT INTO booking_2025_01
SELECT * FROM booking
WHERE start_date >= '2025-01-01' AND start_date < '2025-02-01';

INSERT INTO booking_2025_02
SELECT * FROM booking
WHERE start_date >= '2025-02-01' AND start_date < '2025-03-01';

INSERT INTO booking_2025_03
SELECT * FROM booking
WHERE start_date >= '2025-03-01' AND start_date < '2025-04-01';

-- 5️⃣ Optional: rename original table and replace with partitioned table
ALTER TABLE booking RENAME TO booking_old;
ALTER TABLE booking_partitioned RENAME TO booking;

-- ✅ Notes:
-- Foreign keys referencing booking (e.g., payment.booking_id) will still work.
-- You can create new monthly partitions as needed.
-- The UNIQUE constraint now includes the partitioning column.
