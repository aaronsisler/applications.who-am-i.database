/*
* A user of the application
*/
CREATE TABLE IF NOT EXISTS auth.app_user (
  id bigint primary key generated always as identity,
  user_id uuid NOT NULL DEFAULT uuid_generate_v4(),
  email_address varchar(100) NOT NULL,
  first_name varchar(45) NOT NULL,
  last_name varchar(45) NOT NULL,

  -- Audit fields
  created_at timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_by varchar(100),
  updated_by varchar(100),

  CONSTRAINT uq_app_user_user_id UNIQUE (user_id),
  CONSTRAINT uq_app_user_email UNIQUE (email_address),
  CONSTRAINT chk_email_not_empty CHECK (email_address <> ''),
  CONSTRAINT chk_first_name_not_empty CHECK (first_name <> ''),
  CONSTRAINT chk_last_name_not_empty CHECK (last_name <> '')
);
