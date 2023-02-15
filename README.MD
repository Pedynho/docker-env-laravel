
# Setup the environment to laravel 9 or 10 + Mysql 8 + Nginx 1.19

- To initialize the environment just follow these steps below
	- After clone this repository
        ```bash
        $ mkdir src
    - Copy the laravel project to the src folder
	- Make sure the environment config into the mysql service in the 'docker-compose.yml' is equal to the .env.example of the laravel project.
        - example:
            ```yml
            environment: 
                MYSQL_DATABASE: db
                MYSQL_ROOT_PASSWORD: 123456
                MYSQL_PASSWORD: 123456
                MYSQL_USER: laravel
                SERVICE_TAGS: dev
                SERVICE_NAME: mysql
    - Remember to change the value of 'DB_HOST' in the '.env.example' into laravel project to 'mysql'
        - example:
            ```env
            DB_CONNECTION=mysql
            DB_HOST=mysql
            DB_PORT=3306
            DB_DATABASE=laravel
            DB_USERNAME=laravel
            DB_PASSWORD=123456
	- Into the folder level of 'docker-compose.yml', run these commands
		```bash
        $ docker-compose build laravel
		$ docker-compose up -d

	- Go to "http://localhost:8100" and have a fun.