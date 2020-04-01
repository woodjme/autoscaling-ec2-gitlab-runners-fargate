#!/bin/bash

# Set error handling
set -euo pipefail

# Always unregister runner on exit
function gitlab-unregister {
    gitlab-runner unregister --all-runners
}

trap 'gitlab-unregister' EXIT SIGHUP SIGINT SIGTERM

# Define runner tags
if [ -n "${RUNNER_TAG_LIST:-}" ]
then
    RUNNER_TAG_LIST_OPT=("--tag-list" "$RUNNER_TAG_LIST")
else
    RUNNER_TAG_LIST_OPT=("--run-untagged=true")
fi

# Define adicional parameters
if [ -n "${ADDITIONAL_REGISTER_PARAMS:-}" ]
then
    IFS=' ' read -r -a ADDITIONAL_REGISTER_PARAMS_OPT <<< "$ADDITIONAL_REGISTER_PARAMS"
else
    IFS=' ' read -r -a ADDITIONAL_REGISTER_PARAMS_OPT <<< ""
fi

# Register
gitlab-runner register --executor docker+machine \
--docker-privileged \
--docker-tlsverify \
--docker-disable-cache \
--machine-machine-driver "amazonec2" \
--machine-machine-name "gitlab-%s" \
--request-concurrency "$RUNNER_REQUEST_CONCURRENCY" \
--machine-machine-options amazonec2-use-private-address \
--machine-machine-options amazonec2-security-group="$AWS_SECURITY_GROUP" \
"${RUNNER_TAG_LIST_OPT[@]}" \
"${ADDITIONAL_REGISTER_PARAMS_OPT[@]}"

# Native env var seems to be broken for security group

# Start Runner
gitlab-runner run
