FROM phusion/baseimage:14.04

MAINTAINER Andreas C. Osowski "andreas.osowski@fokus.fraunhofer.de"

# Install software 
RUN apt-get install -y git python-virtualenv python-pip supervisor

# Install Java
RUN apt-get update -y                             && \
    apt-get install python-software-properties -y && \
    add-apt-repository ppa:webupd8team/java -y    && \
    apt-get update -y                             && \
    apt-get install oracle-java8-installer -y     && \
    oracle-java8-set-default

# Check out policycompass
ENV POLICYCOMPASS_DIR /opt/policycompass
RUN mkdir ${POLICYCOMPASS_DIR}
WORKDIR ${POLICYCOMPASS_DIR}

RUN git clone https://github.com/policycompass/policycompass.git policycompass
WORKDIR ${POLICYCOMPASS_DIR}/policycompass

# Install policycompass dependencies 
RUN make

# Start policycompass 
RUN supervisord -c etc/supervisord.conf



