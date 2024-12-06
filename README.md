# SQL databases docker containers (_for only local environment_).

## Introduction

Each time when I start a new project I need to have a lot of tools to work with. I always need a SQL database, so it 
wouldn't be bad to have some different DBMS (database management system) already existing.

### psql create database in the container
Run psql into a container
```shell
$ docker exec -it CONTAINER psql -U USER DB_NAME
```
then run SQL query
```sql
select 'create database <db_name>' where not exists (select from pg_database where datname = '<db_name>')\gexec
```
### psql create user
```sql

```
### backup postgres DB
```shell
$ docker exec -i pgsql_db16 pg_dump -U root core > ./psql16-service/backups/FILE_NAME.sql
```

### restore postgres DB
```shell
docker exec -i pgsql_db16 psql -U root DB_NAME < ./psql16-service/backups/FILE_NAME.sql
```