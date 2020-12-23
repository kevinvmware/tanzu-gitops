#! /usr/bin/env bash

set -euo pipefail


helm upgrade --install concourse concourse \
--repo https://concourse-charts.storage.googleapis.com \
--create-namespace \
--namespace concourse \
--version 11.4.0 \
--values helm.yml \
--set concourse.web.externalUrl="https://$YTT_CONCOURSE_concourse_hostname" \
--wait

kubectl create secret generic tanzu-gitops \
--namespace concourse-main \
--from-literal=tkgi_url="${TKGI_URL}" \
--from-literal=tkgi_user="${TKGI_USER}" \
--from-literal=tkgi_password="${TKGI_PASSWORD}" \
--from-file=ca_cert="$(mkcert -CAROOT)/rootCA.pem" \
--from-literal=wavefront_api_token="${WAVEFRONT_API_TOKEN}" \
--from-literal=wavefront_url="${WAVEFRONT_URL}" \
--from-literal=pivnet_api_token="${PIVNET_API_TOKEN}" \
--from-literal=pivnet_username="${PIVNET_LOGIN}" \
--from-literal=pivnet_password="${PIVNET_PASSWORD}"


kapp deploy \
-a concourse \
-f <(ytt --data-values-env=YTT_CONCOURSE \
-f gateway.yml \
-f virtualservice.yml \
-f values.yml)