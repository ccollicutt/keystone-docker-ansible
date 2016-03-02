
CNTR="keystone-ansible"
MYSQL_ROOT_PASSWORD="mysql_passw0rd"
# NOTE: Changing the name of the mysql container will change all the env
# vars that are provided to the keystone container, crap
MYSQL_CNTR="mysql"
MYSQL_CNTR_IMAGE="mariadb"

all: clean build run_mysql_container run_keystone_container

build: 
	docker build -t $(CNTR) .

# Ignore with "-" at start if rm fails, might fail b/c
# the container doesnt exist so don't need to clean it
clean:
	-docker rm -f $(CNTR) 
	-docker rm -f $(MYSQL_CNTR)

run_mysql_container:
	docker run -d \
	-e MYSQL_ROOT_PASSWORD=$(MYSQL_ROOT_PASSWORD) \
	-h $(MYSQL_CNTR) \
	--name $(MYSQL_CNTR) \
	$(MYSQL_CNTR_IMAGE)

# FIXME: where do these passwords come from?
run_keystone_container:
	docker run -d \
	--name $(CNTR) \
	--hostname $(CNTR) \
	--link $(MYSQL_CNTR):$(MYSQL_CNTR) \
	$(CNTR)


exec:
	docker exec -i -t $(CNTR) /bin/bash

logs:
	docker logs $(CNTR)

  
