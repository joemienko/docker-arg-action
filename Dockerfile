FROM ubuntu:bionic

ARG APTIBLE_USER=APTIBLE_USER

ARG APTIBLE_PASSWORD=APTIBLE_PASSWORD

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
