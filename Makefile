include .env
# MySQL84 service
runMySQL84:
	@docker network ls|grep db_net > /dev/null || docker network create --driver bridge db_net
	@docker --log-level ERROR compose --env-file ./.env -f mysql84-service/docker-compose.yml up -d

dumpMySQL84:
	@docker exec mysql_db84 sh -c 'exec mysqldump --all-databases -uroot -p${MYSQL_ROOT_PASSWORD}' > ./mysql84-service/backups/all-databases.sql

restoreMySQL84:
	@docker exec -i mysql_db84 sh -c 'exec mysql -uroot -p${MYSQL_ROOT_PASSWORD}' < ./mysql84-service/backups/all-databases.sql
	@#docker exec -i mysql_db84 sh -c 'exec mysql -uroot -p${MYSQL_ROOT_PASSWORD} --one-database test_db' < ./mysql84-service/backups/all-databases.sql

# MySQL57 service
runMySQL57:
	@docker network ls|grep db_net > /dev/null || docker network create --driver bridge db_net
	@@docker --log-level ERROR compose --env-file ./.env -f mysql57-service/docker-compose.yml up -d

dumpMySQL57:
	@docker exec mysql_db57 sh -c 'exec mysqldump --all-databases -uroot -p${MYSQL_ROOT_PASSWORD}' > ./mysql57-service/backups/all-databases.sql

restoreMySQL57:
	@docker exec -i mysql_db57 sh -c 'exec mysql -uroot -p${MYSQL_ROOT_PASSWORD}' < ./mysql57-service/backups/all-databases.sql

# PgSQL14 service
runPgSQL14:
	@docker network ls|grep db_net > /dev/null || docker network create --driver bridge db_net
	@cd ./psql14-service && docker --log-level ERROR compose up -d

runPgSQL16:
	@docker network ls|grep db_net > /dev/null || docker network create --driver bridge db_net
	@cd ./psql16-service && docker --log-level ERROR compose up -d

runAdminer:
	@docker network ls|grep db_net > /dev/null || docker network create --driver bridge db_net
	@cd ./adminer-service && docker --log-level ERROR compose up -d

runPhpMyAdmin:
	@docker network ls|grep db_net > /dev/null || docker network create --driver bridge db_net
	@cd ./phpmyadmin-service && docker --log-level ERROR compose up -d

runAllDBServices:
	@docker network ls|grep db_net > /dev/null || docker network create --driver bridge db_net
	@cd ./mysql84-service && docker --log-level ERROR compose up -d
	@cd ./mysql57-service && docker --log-level ERROR compose up -d
	@cd ./psql14-service && docker --log-level ERROR compose up -d
	@cd ./psql16-service && docker --log-level ERROR compose up -d
	@cd ./adminer-service && docker --log-level ERROR compose up -d
	@cd ./phpmyadmin-service && docker --log-level ERROR compose up -d
