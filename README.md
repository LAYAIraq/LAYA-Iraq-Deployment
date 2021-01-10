# laya-vechta-deployment

This repository is aimed to make deployment of LAYA instances as easy as possible. It uses Docker to set up a group that serves Frontend and Backend individually.

## Prerequisites

In order to be able to work, your systems needs:

-- a working Docker installation
-- Docker swarm be enabled

## Deployment of LAYA

To deploy LAYA on your system, simply run:

```sudo ./deploy.sh```

The script will build the Docker containers and put them in a swarm on your system.