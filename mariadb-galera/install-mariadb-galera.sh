#! /usr/bin/env bash

set -euo pipefail

helm install mariadb-galera tac-repo/mariadb-galera \
--version 4.4.0 \
--namespace spring-petclinic \
--create-namespace \
--values helm.yml \
--wait