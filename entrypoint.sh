#!/bin/bash

# Register
gitlab-runner register --executor docker+machine \
--docker-privileged \
--docker-tlsverify \
--docker-disable-cache \
--machine-machine-driver "amazonec2" \
--machine-machine-name "gitlab-%s" \
--request-concurrency 12 \
--machine-machine-options amazonec2-use-private-address \
--machine-machine-options amazonec2-security-group=$AWS_SECURITY_GROUP \
$ADDITIONAL_REGISTER_PARAMS

# Native env var seems to be broken for security group

# Start Runner
gitlab-runner run
