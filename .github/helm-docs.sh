#!/bin/bash -xe

CHART_DIRS="$(git diff --find-renames --name-only "$(git rev-parse --abbrev-ref HEAD)" remotes/origin/main -- 'charts' | grep '[cC]hart.yaml' | sed -e 's#/[Cc]hart.yaml##g')"
if [[ -z "$CHART_DIRS" ]]; then
    echo "No Chart.yaml changes detected, aborting helm-docs"
    exit 1
fi

HELM_DOCS_VERSION="1.11.3"

curl --silent --show-error --fail --location --output /tmp/helm-docs.tar.gz https://github.com/norwoodj/helm-docs/releases/download/v"${HELM_DOCS_VERSION}"/helm-docs_"${HELM_DOCS_VERSION}"_Linux_x86_64.tar.gz
tar -xf /tmp/helm-docs.tar.gz helm-docs

for CHART_DIR in ${CHART_DIRS}; do
  ./helm-docs -c ${CHART_DIR}
  git diff --exit-code
done
