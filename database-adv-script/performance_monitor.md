# Booking Table Optimization and Performance Report

This README contains a full guide on the `booking` table optimization, including partitioning by `start_date`, query performance monitoring, bottleneck analysis, optimizations, and performance improvements. It serves as both documentation and a performance tracking report.

---

## 1. Booking Table Overview

### 1.1 Table Structure

```sql
Table "public.booking"

Column       | Type                          | Nullable | Default
-------------+-------------------------------+---------+---------------------------
booking_id   | uuid                           | not null | uuid_generate_v4()
property_id  | uuid                           |          |
user_id      | uuid                           |          |
start_date   | date                           | not null |
end_date     | date                           | not null |
total_price  | numeric(10,2)                  | not null |
status       | booking_status                 | not null | 'pending'::booking_status
created_at   | timestamp without time zone    | not null | CURRENT_TIMESTAMP

Indexes:
booking_pkey          PRIMARY KEY (booking_id)
booking_id_index       btree (booking_id)
property_id_b_index    btree (property_id)
