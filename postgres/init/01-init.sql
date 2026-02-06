-- PostgreSQL initialization script for Ignition

-- Create additional databases if needed
-- CREATE DATABASE ignition_history;

-- Create extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Grant privileges
GRANT ALL PRIVILEGES ON DATABASE ignition TO ignition;

-- Create schema for Ignition data (optional)
-- CREATE SCHEMA IF NOT EXISTS scada;
