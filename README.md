# keystone-docker-ansible

This is just an experimental deployment of OpenStack Keystone using Docker and Ansible. Only Keystone is deployed with a MariaDB container as well.

## Workflow

First, when the Docker image is built, it will install a few packages and Ansible from pip.

Then Ansible will install Keystone packages.

In the docker-entrypoint.sh script, Ansible will be run when the container comes up to configure Keystone's configuration file as well as add users and services.

I'm not sure if this is a good workflow, but again it's an experiment.

## Makefile

There's a make file and you can run something like:

```bash
$ make all
```

and it will destroy any running containers and create new ones as well as build a new image if it's required.

There are also a few other helpful make commands. I am no make expert, so I have a lot to learn in that area.


## MariaDB

This will also pull down a MariaDB image, if needed, and create a Docker container running MariaDB. The Keystone container will link to that instance for its database.

## Usage

Once the containers are up, you should be able to run:

```bash
$ make all
# wait for a couple minutes for the containers to startup and ansible to run
$ make exec
docker exec -i -t "keystone-ansible" /bin/bash
root@keystone-ansible:/# cd
root@keystone-ansible:~# . admin-openrc 
root@keystone-ansible:~# os user list
+----------------------------------+-------+
| ID                               | Name  |
+----------------------------------+-------+
| aa77ae5748d7420a8467aa94d10db2a8 | admin |
+----------------------------------+-------+
```

and have a Keystone instance to mess around with.
