# RedHat OCP EX188 Exercises

A collection of hands-on for **EX188** (DO188) certification.

Try to solve all proposed exercise in `2 hours and 30 minutes`.



## Exercise 1 - Run simple container

Create without run, `httpd` container with the following parameters:

- Container name `webserver`
- Run in `detached` mode
- Expose container port `80` on `8080` host port
- Start `webserver` container

Open browser and verify that at the following address http://localhost:8080
the webserver correctly response, with welcome message.



## Exercise 2 - Copy file from host to container

Run `httpd` container with the following parameters:

- Container name `webserver-with-volume`
- Copy file [index.html](/files/index.html) from host to container directory `/var/www/html/index.html`
- Run in `detached` mode
- Expose container port `80` on `8080` host port

Open your favorite browser and verify that at the following address http://localhost:8080
the webserver correctly response, with custom `index.html` page.



## Exercise 3 - Persisting data with volume

Run `mysql` container with the following parameters:

- Container name `database`
- Run in `detached` mode
- Bind host directory `databasevolume` to container directory `/mysql/data`
- Set environment variables:
  - MYSQL_ROOT_PASSWORD=`admin`
  - MYSQL_USERNAME=`podman`
  - MYSQL_PASSWORD=`ex188`
  - MYSQL_DATABASE=`exercises`
- Expose container port `3306` on `3306` host port



## Exercise 4 - Create custom images with Containerfile

Create two custom image `ex188-server` and `ex188-client` with the following parameters.

### Server

- Base image `node:18`
- Define argument `HTTP_PORT` with default value `8080`
- Define environment variable `HTTP_PORT` that use argument `HTTP_PORT`
- Define work directory `/opt`
- Copy file [server.js](custom-image/server.js) into work directory
- Expose `HTTP_PORT`
- Define as entrypoint the `server.js` script 
- Run container with name `ex188-server`
- Run in `detached` mode
- Expose container port `HTTP_PORT` on `8081` host port
- Attach to `ex188-network`

### Client

- Base image `ubi8`
- Define environment variable `SERVER_PORT`
- Define work directory `/opt`
- Copy file [client.sh](custom-image/client.sh) into work directory
- Define as entrypoint the `client.sh` script
- Run container with name `ex188-client`
- Run in `detached` mode
- Attach to `ex188-network`

Verify logs of container `ex188-client` and check that correctly receive response from `ex188-server`.



## Exercise 5 - Manage image

- Create new tag `1.0.0` for `ex188-server` image
- Export the `ex188-server:1.0.0` image into `ex188-server.tar` file
- Remove `ex188-server:1.0.0` image from host
- Restore image from `ex188-server.tar`
- Verify that image is correctly restored



## Exercise 6 - Multi container application

Run multi container application, with the following parameters.

## Database

- Base image `mariadb:10.6.4-focal`
- Run container with name `wp-db`
- Run in `detached` mode
- Attach to `wp-network`
- Bind host directory `wp-volume` to container directory `/var/lib/mysql`
- Set environment variables:
  - MYSQL_ROOT_PASSWORD=`wpadmin`
  - MYSQL_USERNAME=`wpuser`
  - MYSQL_PASSWORD=`wpuser`
  - MYSQL_DATABASE=`wp`
- Expose container port `3306` on `3306` host port

## Wordpress

- Base image `wordpress:latest`
- Run container with name `wp-server`
- Run in `detached` mode
- Attach to `wp-network`
- Set environment variables:
  - WORDPRESS_DB_HOST=`wp-db`
  - WORDPRESS_DB_USER=`wpuser`
  - WORDPRESS_DB_PASSWORD=`wpuser`
  - WORDPRESS_DB_NAME=`wp`
- Expose container port `80` on `80` host port

Open your favorite browser and go to the page [Wordpress configuration](http://localhost:80) page.



## Exercise 7 - Troubleshooting

- Build container from the [Containerfile](troubleshooting/Containerfile)
- Run container podman run --rm -d --name troubleshooting -p 8085:8085 troubleshooting