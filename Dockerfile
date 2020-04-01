FROM ubuntu:bionic
LABEL maintainer="me@jamiewood.io"

ARG GITLAB_RUNNER_VERSION="12.8.0"
ARG DOCKER_MACHINE_VERSION="0.16.2-gitlab.3"

# Install deps
RUN apt-get update && apt-get install -y \
	curl \
	git \
	dumb-init \
	&& rm -rf /var/lib/apt/lists/*

# Install Gitlab Runner
RUN curl -LJO https://gitlab-runner-downloads.s3.amazonaws.com/v${GITLAB_RUNNER_VERSION}/deb/gitlab-runner_amd64.deb
RUN dpkg -i gitlab-runner_amd64.deb

# Install Docker Machine
RUN curl -L https://gitlab-docker-machine-downloads.s3.amazonaws.com/v${DOCKER_MACHINE_VERSION}/docker-machine >/tmp/docker-machine && \
	chmod +x /tmp/docker-machine && \
	cp /tmp/docker-machine /usr/local/bin/docker-machine

COPY ./entrypoint.sh ./entrypoint.sh

ENV REGISTER_NON_INTERACTIVE=true

ENTRYPOINT ["/usr/bin/dumb-init", "--", "./entrypoint.sh" ]
