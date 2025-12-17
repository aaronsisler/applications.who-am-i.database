-- 1. Support logins / identity lookups
CREATE INDEX IF NOT EXISTS idx_app_user_email
    ON auth.app_user (email_address);

-- 2. Useful for ordering and retrieving recently created users
CREATE INDEX IF NOT EXISTS idx_app_user_created_at
    ON auth.app_user (created_at);

-- 3. Useful for filtering or searching by last name
CREATE INDEX IF NOT EXISTS idx_app_user_last_name
    ON auth.app_user (last_name);