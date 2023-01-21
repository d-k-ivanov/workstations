#!/bin/bash
#
# Ansible Password Creator
# Platform: Unix
#
# Author:   Dmitriy Ivanov
#

echo "=== Welcome to Ansible Password Creator ==="
echo

read -n 1 -p "    Do you want to proceed? (y/[Any key to cancel]): " WANT_PROCEED
[ "$WANT_PROCEED" = "y" ] || exit 1
echo

# Environment
ANSIBLE_HOME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"
VAULT_PASS_FILE="${ANSIBLE_HOME}/secrets/ansible_password"
VAULT_PASS_FILE_GPG="${ANSIBLE_HOME}/secrets/ansible_password.gpg"
VAULT_PASS_FILE_TMP="/tmp/ansible_password.tmp"

if [ -f ${VAULT_PASS_FILE} ]; then
    echo ">>> Warning: ${VAULT_PASS_FILE} already exist!"
    read -n 1 -p "Do you want to replace it? (y/[Any key to cancel]): " WANT_REPLACE
    [ "${WANT_REPLACE}" = "y" ] || exit 2
    echo
fi

if [ -f ${VAULT_PASS_FILE_GPG} ]; then
    echo ">>> Error: ${VAULT_PASS_FILE_GPG} already exist!"
    echo ">>> Error: Please decrypt it via \"${BASH_SOURCE[0]}/gpg.sh\". Exiting..."
    exit 3
fi

read -p "Enter ansible vault password: " VAULT_PASS
echo

# Script
touch $VAULT_PASS_FILE
echo "$VAULT_PASS" > $VAULT_PASS_FILE

echo
exit 0

