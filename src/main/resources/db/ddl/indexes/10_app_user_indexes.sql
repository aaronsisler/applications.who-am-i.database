-- 1. Useful for ordering and retrieving recently created users
CREATE INDEX IF NOT EXISTS idx_app_user_created_at
    ON auth.app_user (created_at);

-- 2. Useful for filtering or searching by last name
CREATE INDEX IF NOT EXISTS idx_app_user_last_name
    ON auth.app_user (last_name);