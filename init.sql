-- ======================================================
-- 0. Variables
-- ======================================================
\set db_name 'auth'
\set schema_name 'auth'
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
WHERE datname = :'db_name' AND pid <> pg_backend_pid();

DROP DATABASE IF EXISTS :db_name;

-- ======================================================
-- 2. Create roles
-- ======================================================

-- Role used only to (re)create the database — local dev convenience only
\set role_name :'db_creator'
\i   src/main/resources/db/ddl/roles/drop_and_create_role.sql

-- Your IDE/schema owner role
\set role_name :'ide_user'
\i src/main/resources/db/ddl/roles/drop_and_create_role.sql

-- The application role (lowest privilege)
\set role_name :'app_user'
\i src/main/resources/db/ddl/roles/drop_and_create_role.sql

-- Make the db_creator a member of ide_user so it can SET ROLE
GRANT :ide_user TO :db_creator;

-- ======================================================
-- 3. Create the database
-- ======================================================

CREATE DATABASE :db_name OWNER :db_creator;

-- ======================================================
-- 4. Connect as the DB creation user
-- ======================================================
\c :db_name :db_creator

-- ======================================================
-- 5. Install required extensions
-- ======================================================

-- Currently none required

-- ======================================================
-- 6. Create the schema (which will be owned by IDE user)
-- ======================================================

\i src/main/resources/db/ddl/schemas/10_auth_schema.sql

-- Hand off schema ownership so the IDE user manages DDL
ALTER SCHEMA auth OWNER TO :ide_user;

-- ======================================================
-- 7. Create tables using IDE user as owner
-- ======================================================
SET ROLE :ide_user;

\i src/main/resources/db/ddl/tables/10_app_user_table.sql;

RESET ROLE;

-- ======================================================
-- 8. Grant privileges to the app user (runtime)
-- ======================================================
SET ROLE :ide_user;

\i src/main/resources/db/ddl/grants/10_app_user_grants.sql;

RESET ROLE;