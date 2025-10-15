/*
* A user of the application
*/
CREATE TABLE IF NOT EXISTS auth.app_user (
  id integer primary key generated always as identity,
  email_address varchar(100) NOT NULL,
  first_name varchar(45) NOT NULL,
  last_name varchar(45) NOT NULL,
  created_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
);