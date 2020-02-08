#!/bin/bash

# Register
gitlab-runner register --executor docker+machine \
--docker-privileged \
--docker-tlsverify \
--docker-disable-cache \
--machine-machine-driver "amazonec2" \
--machine-machine-name "gitlab-%s" \
--request-concurrency 12

# Start Runner
gitlab-runner run
