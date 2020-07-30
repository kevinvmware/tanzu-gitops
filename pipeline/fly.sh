#! /usr/bin/env bash

set -euo pipefail

source vars.sh

fly set-pipeline -t lab \
-p tanzulab \
-c pipeline.yml \
-v role_id="${ROLE_ID}" \
-v secret_id="${SECRET_ID}"
