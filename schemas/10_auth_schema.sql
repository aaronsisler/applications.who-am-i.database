-- This suppresses NOTICE messages during schema drop
SET client_min_messages = warning;

DROP SCHEMA IF EXISTS auth CASCADE;

CREATE SCHEMA auth;

-- Restore previous behavior for parent script
RESET client_min_messages;