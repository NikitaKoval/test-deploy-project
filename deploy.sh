#!/usr/bin/env bash
set -xe

DEPLOY_HOST=$1
SSH_USER=$2
ENV_PATH=$3
SSH_KEY_PATH=$4
VERSION=$5

ln -sf ${ENV_PATH} .env.prod
eval `ssh-agent -s`
ssh-add -k ${SSH_KEY_PATH}
ssh-keyscan -H ${DEPLOY_HOST} >> ~/.ssh/known_hosts
export DOCKER_HOST="ssh://${SSH_USER}@${DEPLOY_HOST}"

VERSION=${VERSION} docker-compose -f docker-compose.base.yml -f docker-compose.prod.yml pull -q
scp docker-compose.base.yml docker-compose.prod.yml .env.prod ${SSH_USER}@${DEPLOY_HOST}:~

ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ${SSH_USER}@${DEPLOY_HOST} /bin/bash <<EOF
set -xe
start_containers() {
VERSION=${VERSION} HOST={DEPLOY_HOST} docker-compose -f docker-compose.base.yml -f docker-compose.prod.yml up -d
VERSION=${VERSION} HOST={DEPLOY_HOST} docker-compose -f docker-compose.base.yml -f docker-compose.prod.yml exec -T backend python manage.py migrate
rm -f .env.prod docker-compose.*
}
start_containers
EOF
