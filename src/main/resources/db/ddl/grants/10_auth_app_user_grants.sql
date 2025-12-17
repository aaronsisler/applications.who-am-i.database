-- App user must be able to see the schema
GRANT USAGE ON SCHEMA auth TO auth_app_user;

-- Runtime CRUD privileges on existing tables
GRANT SELECT, INSERT, UPDATE, DELETE
    ON ALL TABLES IN SCHEMA auth
    TO auth_app_user;

-- Ensure future tables also get permissions (important!)
ALTER DEFAULT PRIVILEGES FOR ROLE auth_ide_user IN SCHEMA auth
    GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO auth_app_user;