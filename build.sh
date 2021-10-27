#!/usr/bin/env bash

set -xe

bump2version --allow-dirty patch
VERSION=`cat VERSION`

echo "Build test images"
VERSION=${VERSION} docker-compose -f docker-compose.base.yml -f docker-compose.ci.yml build

echo "Run backend tests"
VERSION=${VERSION} docker-compose -f docker-compose.base.yml -f docker-compose.ci.yml run --rm backend pytest --junitxml=.test-results/be-report.xml
echo "Run frontend tests"
VERSION=${VERSION} docker-compose -f docker-compose.base.yml -f docker-compose.ci.yml run --rm frontend-test npm run test:ci

echo "Run acceptance tests"
VERSION=${VERSION} docker-compose -f docker-compose.base.yml -f docker-compose.ci.yml run --rm backend sh -e 'python manage.py flush --no-input && python manage.py migrate'
VERSION=${VERSION} docker-compose -f docker-compose.base.yml -f docker-compose.ci.yml run --rm cypress

echo "Pushing images"
VERSION=${VERSION} docker-compose -f docker-compose.base.yml -f docker-compose.ci.yml push backend frontend