#!/bin/bash

# Register
gitlab-runner register --executor docker+machine \
--docker-privileged \
--docker-tlsverify \
--docker-disable-cache \
--machine-machine-driver "amazonec2" \
--machine-machine-name "gitlab-%s" \
--request-concurrency 12 \
$ADDITIONAL_REGISTER_PARAMS

# Start Runner
gitlab-runner run
