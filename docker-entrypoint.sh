#!/bin/bash

ansible-playbook -vvv -i "localhost," /opt/ansible/keystone-config/main.yml -c local
RES=$?

if [ $RES != 0 ]; then
    echo "ERROR: Ansible run failed, exiting..."
    exit 1
else
    # Ansible completed OK, should be good to restart keystone-all
    # FIXME: How best to do this? Ansible needs keystone up to configure
    # it, but docker will exit unless it's started here...need a better way.
    killall keystone-all
    keystone-all
fi
