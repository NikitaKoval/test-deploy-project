#!/usr/bin/env bash

set -xe

echo "Build test images"
docker-compose -f docker-compose.base.yml -f docker-compose.ci.yml build

echo "Run backend tests"
docker-compose -f docker-compose.base.yml -f docker-compose.ci.yml run --rm backend pytest --junitxml=.test-results/be-report.xml
echo "Run frontend tests"
docker-compose -f docker-compose.base.yml -f docker-compose.ci.yml run --rm frontend npm run test:ci

bump2version --allow-dirty patch

VERSION=`cat VERSION`

echo "Build images"
VERSION=${VERSION} docker-compose -f docker-compose.base.yml -f docker-compose.prod.yml build
echo "Pushing images"
VERSION=${VERSION} docker-compose -f docker-compose.base.yml -f docker-compose.prod.yml push
git config user.name "Jenkins"
git config user.email jenkins@localhost
git push origin refs/remotes/origin/master
git push origin --tags