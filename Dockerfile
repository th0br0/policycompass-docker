FROM elasticsearch

MAINTAINER Andreas C. Osowski "andreas.osowski@fokus.fraunhofer.de"

# Install software 
RUN apt-get update
RUN apt-get install -y git python-virtualenv python-pip supervisor

RUN apt-get install -y maven tomcat7 libxml2 libxslt1.1 libzip2 python3 python3-pil python3-pip python-virtualenv python3-ipdb python3-pep8 pyflakes sqlite build-essential zlibc \
    curl file git ruby ruby-dev nodejs npm openjdk-7-jdk phantomjs supervisor nginx \
    postgresql ruby-compass

# Check out policycompass
ENV POLICYCOMPASS_DIR /opt/policycompass
RUN mkdir ${POLICYCOMPASS_DIR}
WORKDIR ${POLICYCOMPASS_DIR}

RUN git clone https://github.com/policycompass/policycompass.git policycompass
WORKDIR ${POLICYCOMPASS_DIR}/policycompass

# Install policycompass dependencies 
RUN make /usr/bin/node
RUN make update_repros test_install frontend_install postgres_init services_install fcmmanager_install select_nginx_config

# Start policycompass 
RUN supervisord -c etc/supervisord.conf



