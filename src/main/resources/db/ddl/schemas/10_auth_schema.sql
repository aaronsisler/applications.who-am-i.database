-- This suppresses NOTICE messages during schema drop
SET client_min_messages = warning;

DROP SCHEMA IF EXISTS :schema_name CASCADE;

CREATE SCHEMA :schema_name;

-- Restore previous behavior for parent script
RESET client_min_messages;