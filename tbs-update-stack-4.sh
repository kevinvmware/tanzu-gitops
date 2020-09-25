#! /usr/bin/env bash

set -euo pipefail

kp clusterstack update base \
--build-image=registry.pivotal.io/tbs-dependencies/build-base:202008121654 \
--run-image=registry.pivotal.io/tbs-dependencies/run-base:202008121654