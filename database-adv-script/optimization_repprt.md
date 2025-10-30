# Query Performance Report

## Overview

This report analyzes the performance of a complex join query involving the following tables:

- `users`
- `booking`
- `payment`
- `property`

The query returns 3 rows based on multiple joins. The execution plan was obtained using PostgreSQL's `EXPLAIN ANALYZE`.

---

## Query Plan Summary

```text
Nested Loop  (cost=2.15..6.75 rows=3 width=766)
  Join Filter: (b.property_id = pr.property_id)
  ->  Hash Join  (cost=2.15..5.60 rows=3 width=234)
        Hash Cond: (u.user_id = b.user_id)
        ->  Seq Scan on users u  (cost=0.00..3.03 rows=103 width=90)
        ->  Hash  (cost=2.12..2.12 rows=3 width=144)
              ->  Hash Join  (cost=1.07..2.12 rows=3 width=144)
                    Hash Cond: (p.booking_id = b.booking_id)
                    ->  Seq Scan on payment p  (cost=0.00..1.03 rows=3 width=60)
                    ->  Hash  (cost=1.03..1.03 rows=3 width=84)
                          ->  Seq Scan on booking b  (cost=0.00..1.03 rows=3 width=84)
  ->  Materialize  (cost=0.00..1.04 rows=3 width=532)
        ->  Seq Scan on property pr  (cost=0.00..1.03 rows=3 width=532)
