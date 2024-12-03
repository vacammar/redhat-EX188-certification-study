# RedHat OCP EX188 Exercises

A collection of hands-on for **EX188** (DO188) certification.

Try to solve all proposed exercise in `2 hours and 30 minutes`.



## Exercise 1 - Run simple container

Create without run, `httpd` container with the following parameters:

- Image `docker.io/library/httpd:2.4.59`
- Container name `webserver`
- Run in `detached` mode
- Expose container port `80` on `8080` host port
- Start `webserver` container

Open browser and verify that at the following address http://localhost:8080
the webserver correctly response, with welcome message.

**INFO:** NOT stop or remove container, this will be reused for next exercise.



## Exercise 2 - Copy file from host to container

Run `httpd` container with the following parameters, or reuse container of [Exercise 1](README.md):

- Image `docker.io/library/httpd:2.4.59`
- Container name `webserver`
- Run in `detached` mode
- Expose container port `80` on `8080` host port

After that container `webserver` is up and running:

- Copy file [index.html](/files/index.html) from host to container directory `/usr/local/apache2/htdocs`

Open your favorite browser and verify that at the following address http://localhost:8080
the webserver correctly response, with custom `index.html` page.



## Exercise 3 - Persisting data with volume

Run `mysql` container with the following parameters:

- Image `docker.io/library/mysql:9.0`
- Container name `database`
- Run in `detached` mode
- Bind host directory `databasevolume` to container directory `/var/lib/mysql`
- Set environment variables:
  - MYSQL_ROOT_PASSWORD=`admin`
  - MYSQL_USER=`podman`
  - MYSQL_PASSWORD=`ex188`
  - MYSQL_DATABASE=`exercises`
- Expose container port `3306` on `3305` host port

Verify that mysql container working done:
- attach interactive bash session to container
- connect to database `mysql -u podman -p`


## Exercise 4 - Create custom images with Containerfile

Create two custom image `ex188-server` and `ex188-client` with the following parameters.

### Server

- Base image `node:18`
- Define argument `HTTP_PORT` with default value `8080`
- Define environment variable `SERVER_PORT` that use argument `HTTP_PORT`
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
- Define environment variable `SERVER_PORT` with default value `8080`
- Define work directory `/opt`
- Copy file [client.sh](custom-image/client.sh) into work directory
  - Make sure that file have rights for executions `--chmod=777`
- Define as entrypoint the `client.sh` script
- Run container with name `ex188-client`
- Run in `detached` mode
- Set environment variable `SERVER_PORT=8080` 
- Attach to `ex188-network`

Verify logs of container `ex188-client` and check that correctly receive response from `ex188-server`.



## Exercise 5 - Manage image

For this exercise, we need of [Docker Hub](https://hub.docker.com/), [Quay.io](https://www.quay.io) or other providers, in order to push image into repository.

- Create new tag `1.0.0` for `ex188-server` image, created on [Exercise 4](README.md)
- Backup the `ex188-server:1.0.0` image into `ex188-server.tar` file
- Remove `ex188-server:1.0.0` image from host
- Restore image from `ex188-server.tar`
- Verify that image is correctly restored
- Push `ex188-server:1.0.0` image into `test` repository
- Verify through you favorite browser, if the image `ex188-server:1.0.0` is present into remote `test` repository.



## Exercise 6 - Multi container application

Run multi container application, with the following parameters.

## Database

- Image `mariadb:10.6.4`
- Run container with name `wp-db`
- Run in `detached` mode
- Attach to `wp-network`
- Bind host directory `wp-volume` to container directory `/var/lib/mysql`
- Set environment variables:
  - MYSQL_ROOT_PASSWORD=`wpadmin`
  - MYSQL_USER=`wpuser`
  - MYSQL_PASSWORD=`wppassword`
  - MYSQL_DATABASE=`wp`
- Expose container port `3306` on `3306` host port

## Wordpress

- Image `wordpress:latest`
- Run container with name `wp-server`
- Run in `detached` mode
- Attach to `wp-network`
- Set environment variables:
  - WORDPRESS_DB_HOST=`wp-db`
  - WORDPRESS_DB_USER=`wpuser`
  - WORDPRESS_DB_PASSWORD=`wppassword`
  - WORDPRESS_DB_NAME=`wp`
- Expose container port `8000` on `80` host port

Open your favorite browser and go to the page [Wordpress configuration](http://localhost:8000) page.

In case of any issues, start container in debug mode, all that you do is to start container with the following environment variable:

- WORDPRESS_DEBUG=`1`



## Exercise 7 - Multi container application with compose

Edit file [compose.yml](compose/compose.yml) and use the images of the [Exercise 4](README.md):

### Server

- Container name `ex188-server`
- Expose port`8081`
- Network `ex188-network-ex7`

### Client

- Container name `ex188-client`
- Network `ex188-network-ex7`

Then run applications with the below command:

```shell
podman compose -f compose.yml
```

Hints:
- Configure network
- Define environments variable 
- Expose ports

## Clean you computer

Execute [clean.sh](clean/clean.sh) script to remove all container, images, networks and volumes.