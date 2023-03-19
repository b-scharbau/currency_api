# README

## Ensure keys are available
```
/config/master.key

/config/credentials/production.key
/config/credentials/development.key
/config/credentials/test.key
```

## Set up database
`psql -h 127.0.0.1 -U postgres`

```
CREATE USER currency_dev WITH PASSWORD 'currency_dev';
CREATE USER currency_test WITH PASSWORD 'currency_test';

CREATE DATABASE currency_dev;
CREATE DATABASE currency_test;

GRANT ALL PRIVILEGES ON DATABASE currency_dev TO currency_dev;
GRANT ALL PRIVILEGES ON DATABASE currency_test TO currency_test;

# Required for PostgreSQL > 15
\c currency_dev
GRANT ALL ON SCHEMA public TO currency_dev;
\c currency_test
GRANT ALL ON SCHEMA public TO currency_test;
```

`rails db:schema:load`

## Run tests

`bundle exec rspec`
