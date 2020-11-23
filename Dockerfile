FROM ubuntu:bionic

ARG APTIBLE_USER=0
ENV APTIBLE_USER=$APTIBLE_USER

ARG APTIBLE_PASSWORD=0 
ENV APTIBLE_PASSWORD=${APTIBLE_PASSWORD}

ARG RDS_AS_MASTER_URL=0 
ENV RDS_AS_MASTER_URL=${RDS_AS_MASTER_URL}

ARG DCYF_CSSAT_REPLICA_URL=0 
ENV DCYF_CSSAT_REPLICA_URL=${DCYF_CSSAT_REPLICA_URL}

ARG CREATE_ROLE_CODE=0 
ENV CREATE_ROLE_CODE=${CREATE_ROLE_CODE}

ARG CREATE_SCHEMA_CODE=0 
ENV CREATE_SCHEMA_CODE=${CREATE_SCHEMA_CODE}

RUN apt-get update \
  && apt-get install expect -y \
  && apt-get install curl -y \
  && apt-get install u2f-host -y

RUN curl -o aptible.deb \
    https://omnibus-aptible-toolbelt.s3.amazonaws.com/aptible/omnibus-aptible-toolbelt/master/223/pkg/aptible-toolbelt_0.16.9%2B20201104180305~ubuntu.16.04-1_amd64.deb \
    && dpkg -i aptible.deb \
    && apt-get install -f

COPY aptible_login.sh /
COPY aptible_ssh.sh /

# Login to aptible CLI
RUN expect aptible_login.sh $APTIBLE_USER $APTIBLE_PASSWORD

ENTRYPOINT ["/entrypoint.sh"]
