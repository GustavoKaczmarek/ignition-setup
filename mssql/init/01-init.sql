-- MSSQL initialization script for Ignition
-- Note: This script needs to be run manually or via a custom entrypoint
-- MSSQL container doesn't automatically execute scripts like PostgreSQL

-- Create database for Ignition
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'ignition')
BEGIN
    CREATE DATABASE ignition;
END
GO

USE ignition;
GO

-- Create a login for Ignition (optional)
-- CREATE LOGIN ignition_user WITH PASSWORD = 'Ignition123!';
-- CREATE USER ignition_user FOR LOGIN ignition_user;
-- GRANT db_owner TO ignition_user;
