-- 0. Set the database name variable
\set dbname 'auth'

-- 1. Create the base user if not exists
DO
$$
BEGIN
	IF NOT EXISTS (
		SELECT FROM pg_catalog.pg_roles WHERE rolname = 'auth_database_creation_user'
	) THEN
		CREATE USER auth_database_creation_user;
	END IF;
END
$$;

-- 2. Terminate connections and drop the database if it exists
SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE datname = :'dbname' AND pid <> pg_backend_pid();

-- 3. Create the database owned by the base user
DROP DATABASE IF EXISTS :dbname;
CREATE DATABASE :dbname OWNER auth_database_creation_user;

-- 4. Connect to the new database as the base user
\c :dbname auth_database_creation_user

-- 5. Create the schema
\i schemas/auth_schema.sql

-- 6. Create the app_user table in the auth schema
\i tables/10_app_user.sql