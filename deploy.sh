#!/usr/bin/env bash
set -xe

ln -sf ${PROD_ENV} .env.prod
eval `ssh-agent -s`
ssh-add -k ${PROD_SSH}
ssh-keyscan -H demo.nikitakoval.com >> ~/.ssh/known_hosts
export DOCKER_HOST='ssh://deploy@demo.nikitakoval.com'
VERSION=${VERSION} docker-compose -f docker-compose.base.yml -f docker-compose.prod.yml pull -q

scp docker-compose.base.yml docker-compose.prod.yml .env.prod deploy@demo.nikitakoval.com:~

ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null deploy@demo.nikitakoval.com /bin/bash <<EOF
set -xe
VERSION=${VERSION} HOST=demo.nikitakoval.com docker-compose -f docker-compose.base.yml -f docker-compose.prod.yml up -d
VERSION=${VERSION} HOST=demo.nikitakoval.com docker-compose -f docker-compose.base.yml -f docker-compose.prod.yml exec -T backend python manage.py migrate
rm -f .env.prod docker-compose.*
EOF
