#!/bin/bash -eux

# run shell provision on the host machine to download external roles for Ansible
# https://github.com/enginyoyen/ansible-best-practises
echo 'Updating ansible external roles'
./ansible/playbooks/extensions/setup/role_update.sh
