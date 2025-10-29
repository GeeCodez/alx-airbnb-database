CREATE TYPE user_role AS ENUM ('guest', 'host', 'admin');
CREATE TYPE booking_status AS ENUM ('pending', 'confirmed', 'canceled');

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

