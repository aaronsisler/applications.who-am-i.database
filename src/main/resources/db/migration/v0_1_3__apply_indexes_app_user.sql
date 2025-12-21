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
-- Create indexes on app_user table
-- ======================================================
SET ROLE :ide_user;

\i ../ddl/index/10_app_user_indexes.sql;

RESET ROLE;