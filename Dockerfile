FROM ubuntu:bionic
LABEL maintainer="me@jamiewood.io"

ARG version="12.7.1"
# Update
RUN apt-get update -y && apt-get upgrade -y

# Install deps
RUN apt-get install -y curl git

# Install Gitlab Runner
RUN curl -LJO https://gitlab-runner-downloads.s3.amazonaws.com/v${version}/deb/gitlab-runner_amd64.deb
RUN dpkg -i gitlab-runner_amd64.deb

# Install Docker Machine
RUN curl -L https://github.com/docker/machine/releases/download/v0.16.2/docker-machine-`uname -s`-`uname -m` >/tmp/docker-machine && \
chmod +x /tmp/docker-machine && \
cp /tmp/docker-machine /usr/local/bin/docker-machine

COPY ./entrypoint.sh ./entrypoint.sh

ENV REGISTER_NON_INTERACTIVE=true
ENTRYPOINT [ "./entrypoint.sh" ]
