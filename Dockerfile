FROM ubuntu:14.04
MAINTAINER curtis@serverascode.com

# Some basic packages
RUN apt-get update && \
    apt-get install -y \
    python-apt \
    python-pycurl \
    python-pip \
    python-dev \
    psmisc
# Need a more recent ansible...14.04 comes with 1.5.4
# shade is required for the os_* modules
RUN pip install ansible shade

# Now ansible!

# First, the packages
ADD keystone-packages /opt/ansible/keystone-packages
RUN ansible-playbook -i "localhost," /opt/ansible/keystone-packages/main.yml -c local

# Then the config which is run from the entry point script
ADD keystone-config /opt/ansible/keystone-config

ADD docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chown root:root /usr/local/bin/docker-entrypoint.sh && \
    chmod 0755 /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
