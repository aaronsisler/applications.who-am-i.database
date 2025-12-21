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
-- Connect as the DB creation user
-- ======================================================
\c :dbname :db_creator

-- ======================================================
-- Create the schema (which will be owned by IDE user)
-- ======================================================

\i ../ddl/schemas/10_auth_schema.sql

-- Hand off schema ownership so the IDE user manages DDL
ALTER SCHEMA auth OWNER TO :ide_user;