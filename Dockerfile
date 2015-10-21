FROM elasticsearch

MAINTAINER Andreas C. Osowski "andreas.osowski@fokus.fraunhofer.de"

EXPOSE 9900
EXPOSE 1080
EXPOSE 3000

# Add user
RUN useradd -ms /bin/bash pcapp

# Install software 
RUN apt-get update &&\
    apt-get install -y git supervisor &&\
    apt-get install -y maven tomcat7 libxml2 libxslt1.1 libzip2 python3 python3-pil python3-pip python-virtualenv python3-ipdb python3-pep8 pyflakes sqlite build-essential zlibc \
                       curl file git ruby ruby-dev nodejs npm supervisor nginx postgresql ruby-compass
RUN ln -sfT /usr/bin/nodejs /usr/bin/node

# Check out policycompass
USER pcapp
RUN git clone https://github.com/policycompass/policycompass.git policycompass
WORKDIR policycompass

# Install policycompass dependencies 
RUN make update_repros test_install frontend_install postgres_init services_install fcmmanager_install select_nginx_config

# Start policycompass 
RUN supervisord -c etc/supervisord.conf



