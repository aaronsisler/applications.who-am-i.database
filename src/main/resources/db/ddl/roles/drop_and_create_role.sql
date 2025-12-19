-- Description: Drops a role if it exists and
-- creates it with a fixed password.
-- Always uses fixed password 'CHANGE_ME'

-- Usage: \set role_name 'desired_role_name'
-- Then execute this script.
-- Example:
-- \set role_name 'auth_app_user'
-- \i path/to/this/script.sql

-- Drop role if it exists
SELECT 'DROP ROLE IF EXISTS ' || quote_ident(:role_name) || ';'
\gexec
\echo Dropped role if existed: :role_name

-- Create role if it does not exist
SELECT 'CREATE ROLE ' || quote_ident(:role_name)
       || ' LOGIN PASSWORD ''CHANGE_ME'';'
WHERE NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = :role_name)
\gexec
\echo Created role: :role_name with password CHANGE_ME
