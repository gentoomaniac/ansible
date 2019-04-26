#!/usr/bin/env bash

set -u
set -x

REMOTE_ANSIBLE_PATH=/home/marco/git/ansible_pull
LOCAL_ANSIBLE_PATH=/tmp/ansible
TMP_ANSIBLE_PATH="$(mktemp -d)"
BRANCH_NAME=master

DEFAULT_FACT_PATH="${LOCAL_ANSIBLE_PATH}/facts"
ANSIBLE_ROLES_PATH="${LOCAL_ANSIBLE_PATH}/roles"

if git clone "${REMOTE_ANSIBLE_PATH}" "${LOCAL_ANSIBLE_PATH}_new"; then
    rm -rf "${LOCAL_ANSIBLE_PATH}"
    mv "${LOCAL_ANSIBLE_PATH}_new" "${LOCAL_ANSIBLE_PATH}"

    ansible-pull -vvv -U "${LOCAL_ANSIBLE_PATH}" -i hosts -C "${BRANCH_NAME}" -d "${TMP_ANSIBLE_PATH}"

    rm -rf "${TMP_ANSIBLE_PATH}"
fi
