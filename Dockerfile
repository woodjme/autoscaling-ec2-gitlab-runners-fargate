FROM ubuntu:bionic
LABEL maintainer="me@jamiewood.io"

ARG GITLAB_RUNNER_VERSION="12.10.1"
ARG DOCKER_MACHINE_VERSION="0.16.2-gitlab.3"

# Install deps
RUN apt-get update && \
	apt-get install -y --no-install-recommends \
	ca-certificates \
	curl \
	git \
	dumb-init && \
	# Decrease docker image size
	rm -rf /var/lib/apt/lists/* && \
	# Install Gitlab Runner
	curl -LJO https://gitlab-runner-downloads.s3.amazonaws.com/v${GITLAB_RUNNER_VERSION}/deb/gitlab-runner_amd64.deb && \
	dpkg -i gitlab-runner_amd64.deb && \
	# Install Docker Machine
	curl -L https://gitlab-docker-machine-downloads.s3.amazonaws.com/v${DOCKER_MACHINE_VERSION}/docker-machine > /usr/local/bin/docker-machine && \
	chmod +x /usr/local/bin/docker-machine

COPY ./entrypoint.sh ./entrypoint.sh

ENV REGISTER_NON_INTERACTIVE=true

ENTRYPOINT ["/usr/bin/dumb-init", "--", "./entrypoint.sh" ]
