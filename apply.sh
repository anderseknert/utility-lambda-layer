#!/usr/bin/env bash

JQ_VERSION=1.6
KUBECTL_VERSION=1.16.9

mkdir -p layer/opt

curl -sL https://github.com/stedolan/jq/releases/download/jq-"${JQ_VERSION}"/jq-linux64 -o layer/opt/jq
chmod +x layer/opt/jq
if [[ $(echo '{"test": "works"}' | layer/opt/jq .test) != "works" ]]; then
  echo "jq binary not working as expected - aborting"
  exit 1
fi

curl -sL https://storage.googleapis.com/kubernetes-release/release/v"${KUBECTL_VERSION}"/bin/linux/amd64/kubectl -o layer/opt/kubectl
chmod +x layer/opt/kubectl
if [[ $(layer/opt/kubectl version --client) != *"${KUBECTL_VERSION}"* ]]; then
  echo "kubectl binary not working as expected - aborting"
  exit 1
fi