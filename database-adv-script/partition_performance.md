# Booking Table Partitioning - README

## Overview

The `booking` table has been partitioned by the `start_date` column using **range partitioning**.  
Each partition represents one month, which improves query performance for date-based queries and simplifies maintenance.

### Benefits
- Faster queries filtering by `start_date` due to **partition pruning**.
- Easier maintenance: old partitions can be dropped instead of deleting individual rows.
- Indexes can be applied to individual partitions for better performance.
- Preserves relationships with foreign keys (e.g., `payment.booking_id`).

---

## Partitioning Implementation

### 1. Partitioned Table Structure

```sql
CREATE TABLE booking_partitioned (
    booking_id UUID NOT NULL DEFAULT uuid_generate_v4(),
    property_id UUID,
    user_id UUID,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price NUMERIC(10,2) NOT NULL,
    status booking_status NOT NULL DEFAULT 'pending'::booking_status,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT booking_pk UNIQUE (booking_id, start_date)
) PARTITION BY RANGE (start_date);

CREATE TABLE booking_2025_01 PARTITION OF booking_partitioned
    FOR VALUES FROM ('2025-01-01') TO ('2025-02-01');

CREATE TABLE booking_2025_02 PARTITION OF booking_partitioned
    FOR VALUES FROM ('2025-02-01') TO ('2025-03-01');

CREATE TABLE booking_2025_03 PARTITION OF booking_partitioned
    FOR VALUES FROM ('2025-03-01') TO ('2025-04-01');
CREATE INDEX idx_booking_2025_01_property ON booking_2025_01(property_id);
CREATE INDEX idx_booking_2025_01_user ON booking_2025_01(user_id);
-- Repeat for other partitions
