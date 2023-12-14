# laya-vechta-deployment

This repository is aimed to make the deployment of LAYA instances as easy as possible. It uses Docker to set up a group that serves Frontend and Backend individually.

## Prerequisites

In order to be able to work, your systems needs:

- a working Docker installation
- docker-compose
- a server with a working sub domain
- an SSL certificate for that sub domain
- a working e-mail address 

## Architecture of the Docker-compose

This repository provides a docker-compose.yml which sets up LAYA on your machine. The composition consists of three parts:
- laya-frontend
- laya-backend
- a reverse proxy

Frontend is for user interaction, while the backend handles all data. To ensure encrypted communication, all outgoing traffic will be routed through a reverse proxy. Only the reverse proxy exposes port on your machine.

## Setting up the docker-compose

Currently, the only way of obtaining the images for backend and frontend is:

1. Building the images locally using access tokens 
Y
ou need access keys for the repositories before you can build the Docker images. Contact [laya-iraq@outlook.com](mailto:laya-iraq@outlook.com) to get access keys.

In order to set up the SSL certificate, you need valid certificate data in a directory named `cert`. (See [SSL Certificate](#ssl-certificate))

### Environment

The docker-compose file uses a number of environment variables. Most of these need to be present when running `docker-compose up` in order to successfully set up LAYA. The following list indicates which variables have to be set in the '.env' file for docker-compose to run:

- `DB_NAME`: database name.
- `FILES_PATH`: path to files associated with courses. Used also for mounting `laya-backend-files` volume. Defaults to `./server/files`.
- `FILES_SIZE`: maximum byte size for file uploads. Defaults to `500000000`
- `MAIL_AUTH_PASS`: password for e-mail account. 
- `MAIL_AUTH_USER`: username for e-mail account.
- `MAIL_FROM`: e-mail address that sends e-mails to users.
- `MAIL_HOST`: host server which handles the e-mails.
- `MAIL_PORT`: port that is used by mail host.
- `PROXY_DOMAIN`: domain to which your server is listening. Must match SSL certficate.

You can optionally set the following variables in the '.env' file:

- `ACC_BACKEND`: access key to clone back end repository during `build` stage.
- `ACC_FRONTEND`: access key to clone front end repository during `build` stage.
- `SUPERADMIN_MAIL`: e-mail address of the superadmin. They will be sent an e-mail to verify the address.
- `API_PORT`: port on which `laya-backend` listens. Defaults to `3001`.
- `API_ROOT`: suffix for API request calls. Needs leading slash `/`. Defaults to `/api`.
- `DB_PATH`: path to database directory within the back end container. Used also for mounting `laya-db` volume.
- `ENVIRONMENT`: should be either `production` or `development`. In `development` mode, `laya-backend` gives debug output.

### SSL Certificate
You need a valid SSL certicate for the domain on which you set up LAYA. The `reverse-proxy` container is rerouting all traffic to port 443. An invalid SSL certificate will lead to users seeing a warning when accessing your domain.

You need the certificate itself and the private key, named `cert.pem` and `key.pem`, respectively. Both files should be located in a directory called `cert` which resides in the same location as `docker-compose.yml`.

### E-Mail Credentials
The `MAIL_*` environment are used to send notifications to users (such as password reset requests and verification). The host and port can be obtained from your provider.

### Volumes 
The service uses four different volumes. You can mount them to your deserved location by editing the `volumes` section in `docker-compose.yml`.
The used volumes are:
- `laya-backend-files`: contains all files uploaded by users 
- `laya-db`: contains the sqlite database used by the back end
- `laya-frontend-files`: contains front end files being served by `laya-frontend`
- `laya-proxy-logs`: contains access and error logs of `reverse-proxy`

## Building the service and start
After complying to all prerequites and setting all neccessary environment variables, you can start LAYA by running `docker-compose up -d` in the working directory. If you want to rebuild the Docker Containers, add the '--no-cache' parameter to the command.

## Backups and maintaining

As of now, you need to take care of updating the service yourself. There are currently no back up measures included in the service. Make sure you run cron jobs or similar services to keep track of the database and course files.
