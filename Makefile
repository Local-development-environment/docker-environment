include .env
DATE := $(shell date "+%Y-%m-%d_%H'-'%M-%S")

# MySQL84 service  *****************************************************************************************************
runMySQL84:
	@docker network ls|grep db_net > /dev/null || docker network create --driver bridge db_net
	@docker --log-level ERROR compose --env-file ./.env -f mysql84-service/docker-compose.yml up -d

downMySQL84:
	@docker compose --env-file ./.env -f mysql84-service/docker-compose.yml down

dumpMySQL84:
	@#docker exec mysql_db84 sh -c 'exec mysqldump --all-databases -uroot -p${DB_ROOT_PASSWORD}' > ./mysql84-service/backups/all-db-mysql84.sql
	@docker exec mysql_db84 sh -c 'exec mysqldump --all-databases -uroot -p${DB_ROOT_PASSWORD}' > ./mysql84-service/backups/all-db-mysql84.sql

restoreMySQL84:
	@docker exec -i mysql_db84 sh -c 'exec mysql -uroot -p${DB_ROOT_PASSWORD}' < ./mysql84-service/backups/all-db-mysql84.sql
	@#docker exec -i mysql_db84 sh -c 'exec mysql -uroot -p${DB_ROOT_PASSWORD} --one-database test_db' < ./mysql84-service/backups/all-db-mysql84.sql

# MySQL57 service ******************************************************************************************************
runMySQL57:
	@docker network ls|grep db_net > /dev/null || docker network create --driver bridge db_net
	@@docker --log-level ERROR compose --env-file ./.env -f mysql57-service/docker-compose.yml up -d

downMySQL57:
	@docker compose --env-file ./.env -f mysql57-service/docker-compose.yml down

dumpMySQL57:
	@docker exec mysql_db57 sh -c 'exec mysqldump --all-databases -uroot -p${DB_ROOT_PASSWORD}' > ./mysql57-service/backups/all-db-mysql57.sql

restoreMySQL57:
	@docker exec -i mysql_db57 sh -c 'exec mysql -uroot -p${DB_ROOT_PASSWORD}' < ./mysql57-service/backups/all-db-mysql57.sql

# PgSQL14 service ******************************************************************************************************
runPgSQL14:
	@docker network ls|grep db_net > /dev/null || docker network create --driver bridge db_net
	@docker --log-level ERROR compose --env-file ./.env -f psql14-service/docker-compose.yml up -d

downPgSQL14:
	@docker compose --env-file ./.env -f psql14-service/docker-compose.yml down

dumpPgSQL14:
	@docker exec -i pgsql_db14 pg_dumpall -F t -U root > ./psql14-service/backups/all-db-psql14.tar

restorePgSQL14:
	@#cat ./psql14-service/backups/all-db-psql14.sql | docker exec -i pgsql_db14 psql -U root -d test_db
	@#docker exec -i pgsql_db14 psql -U root test_db < ./psql14-service/backups/all-db-psql14.sql
	@docker exec -i pgsql_db14 pg_restore --dbname test_db -f ./psql14-service/backups/all-db-psql14.tar

# PgSQL14 service ******************************************************************************************************
runPgSQL16:
	@docker network ls|grep db_net > /dev/null || docker network create --driver bridge db_net
	@docker --log-level ERROR compose --env-file ./.env -f psql16-service/docker-compose.yml up -d

downPgSQL16:
	@docker compose --env-file ./.env -f psql16-service/docker-compose.yml down

dumpPgSQL16:
	@docker exec -i pgsql_db16 /bin/bash -c "PGPASSWORD=${DB_ROOT_PASSWORD} pg_dumpall -U root" > ./psql16-service/backups/all-db-psql16.sql

# adminer service ******************************************************************************************************
runAdminer:
	@docker network ls|grep db_net > /dev/null || docker network create --driver bridge db_net
	@docker --log-level ERROR compose --env-file ./.env -f adminer-service/docker-compose.yml up -d

downAdminer:
	@docker compose --env-file ./.env -f adminer-service/docker-compose.yml down

# phpMyAdmin service ******************************************************************************************************
runPhpMyAdmin:
	@docker network ls|grep db_net > /dev/null || docker network create --driver bridge db_net
	@docker --log-level ERROR compose --env-file ./.env -f phpmyadmin-service/docker-compose.yml up -d

downPhpMyAdmin:
	@docker compose --env-file ./.env -f phpmyadmin-service/docker-compose.yml down

# pgadmin service ******************************************************************************************************
runPgAdmin:
	@docker network ls|grep db_net > /dev/null || docker network create --driver bridge db_net
	@docker --log-level ERROR compose --env-file ./.env -f pgadmin-service/docker-compose.yml up -d

downPgAdmin:
	@docker compose --env-file ./.env -f pgadmin-service/docker-compose.yml down


runAllDBServices:
	@docker network ls|grep db_net > /dev/null || docker network create --driver bridge db_net
	@docker --log-level ERROR compose --env-file ./.env -f mysql84-service/docker-compose.yml up -d
	@docker --log-level ERROR compose --env-file ./.env -f mysql57-service/docker-compose.yml up -d
	@docker --log-level ERROR compose --env-file ./.env -f psql14-service/docker-compose.yml up -d
	@docker --log-level ERROR compose --env-file ./.env -f psql16-service/docker-compose.yml up -d
	@docker --log-level ERROR compose --env-file ./.env -f adminer-service/docker-compose.yml up -d
	@docker --log-level ERROR compose --env-file ./.env -f phpmyadmin-service/docker-compose.yml up -d
	@docker --log-level ERROR compose --env-file ./.env -f pgadmin-service/docker-compose.yml up -d
