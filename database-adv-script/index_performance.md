#Analysing performance using EXPLAIN ANALYSE

# Performance before indexes
Seq Scan on users  (cost=0.00..3.29 rows=11 width=90) (actual time=0.032..0.058 rows=11 loops=1)
  Rows Removed by Filter: 92
  Planning Time: 3.779 ms
  Execution Time: 0.202 ms


#PERFORMANCE ANALYSES AFTER INDEX
Seq Scan on users  (cost=0.00..3.29 rows=11 width=90) (actual time=0.033..0.060 rows=11 loops=1)
Filter: (role = 'admin'::user_role)
Rows Removed by Filter: 92
Buffers: shared hit=2
Planning:
Buffers: shared hit=133
Planning Time: 3.968 ms
Execution Time: 0.108 ms