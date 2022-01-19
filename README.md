# laya-vechta-deployment

This repository is aimed to make deployment of LAYA instances as easy as possible. It uses Docker to set up a group that serves Frontend and Backend individually.

## Prerequisites

In order to be able to work, your systems needs:

- a working Docker installation
- docker-compose
- a server with a working sub domain
- an SSL certificate for that sub domain

## Architecture of the Docker-compose

This repository provides a docker-compose.yml which sets up LAYA on your machine. The composition consists of three parts:
- laya-frontend
- laya-backend
- a reverse proxy

Front end is for user interaction, while the back end handles all data. To ensure encrypted communication, all outgoing traffic will be routed through a reverse proxy. Only the reverse proxy exposes port on your machine.

## Setting up the docker-compose

There are two ways of obtaining the images for back and front end:

1. Using the project's registry on https://gitlab.informatik.hu-berlin.de
2. Building the images locally using access tokens 

Currently, only the second way is active so you need access keys for the repositories before you can build the Docker images.

