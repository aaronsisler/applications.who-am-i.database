-- ======================================================
-- 0. Variables
-- ======================================================
\set dbname 'auth'
\set db_creator 'auth_database_creation_user'
\set ide_user 'auth_ide_user'
\set app_user 'auth_app_user'

-- Set message level to warning to reduce verbosity i.e. quiet NOTICE messages
SET client_min_messages = warning;

-- ======================================================
-- 1. Drop database if exists
-- ======================================================

SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE datname = :'dbname' AND pid <> pg_backend_pid();

DROP DATABASE IF EXISTS :dbname;

-- ======================================================
-- 2. Create roles
-- ======================================================

-- Role used only to (re)create the database — local dev convenience only
\set role_name :'db_creator'
\i roles/role_creation.sql

-- Your IDE/schema owner role
\set role_name :'ide_user'
\i roles/role_creation.sql

-- The application role (lowest privilege)
\set role_name :'app_user'
\i roles/role_creation.sql

-- Make the db_creator a member of ide_user so it can SET ROLE
GRANT :ide_user TO :db_creator;

-- ======================================================
-- 3. Create the database
-- ======================================================

CREATE DATABASE :dbname OWNER :db_creator;

-- ======================================================
-- 4. Connect as the DB creation user
-- ======================================================
\c :dbname :db_creator

-- ======================================================
-- 5. Install required extensions
-- ======================================================

-- Currently none required

-- ======================================================
-- 6. Create the schema (which will be owned by IDE user)
-- ======================================================

\i schemas/10_auth_schema.sql

-- Hand off schema ownership so the IDE user manages DDL
ALTER SCHEMA auth OWNER TO :ide_user;

-- ======================================================
-- 7. Create tables using IDE user as owner
-- ======================================================
SET ROLE :ide_user;

\i tables/10_app_user.sql;

RESET ROLE;

-- ======================================================
-- 8. Grant privileges to the app user (runtime)
-- ======================================================
SET ROLE :ide_user;

\i grants/10_auth_app_user_grants.sql;

RESET ROLE;