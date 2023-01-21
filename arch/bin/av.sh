#!/bin/bash
#
# Wrapper to Ansible-Vault
# Platform: Unix
#
# Author:   Dmitriy Ivanov
#

# Environment
ANSIBLE_HOME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"
VAULT_PASS_FILE=${ANSIBLE_HOME}/secrets/ansible_password
VAULT_PASS_FILE_NEW=/tmp/ansible_password.new
VAULT_PASS_FILE_TMP=/tmp/ansible_password.tmp

if [ ! -f ${VAULT_PASS_FILE} ]; then
    echo ">>> Error: Ansible password is missing!"
    echo "Please run ${ANSIBLE_HOME}/create_pass.sh to configure your ansible password"
    read -n 1 -p "Do you want to do it right now? (y/[Any key to cancel]): " WANT_INIT
    [ "${WANT_INIT}" = "y" ] || exit 1
    echo
    ${ANSIBLE_HOME}/bin/create_pass.sh
    echo
fi

# Temporary password files with autodeletion
trap "{ rm -f ${VAULT_PASS_FILE_TMP}; rm -f ${VAULT_PASS_FILE_NEW}; }" EXIT
cat ${VAULT_PASS_FILE} > ${VAULT_PASS_FILE_TMP}
chmod 600 ${VAULT_PASS_FILE_TMP}

# Script
f_usage() {
    echo "Usage: $0 <COMMAND> <FILE>"
    echo "
    COMMAND:
        create  - to create vault file
        decrypt - to decrypt vaull file
        edit    - to edit vault file
        encrypt - to encrypt vault file
        rekey   - to change vault key
        view    - to view vault file
    FILE:
        path to vault file
    "
}

if [[ -z "$1" ]] && [[ ! -f "$2" ]]; then
    f_usage
    exit 1
fi

case $1 in
    create|decrypt|edit|encrypt|view )
        ansible-vault ${1} --vault-password-file=${VAULT_PASS_FILE_TMP} ${2}
        ;;

    rekey )
        read -s -p "Enter new Ansible vault password: " NEW_VAULT_PASS
        echo
        echo ${NEW_VAULT_PASS} > ${VAULT_PASS_FILE_NEW}
        chmod 600 ${VAULT_PASS_FILE_NEW}
        while read -u 5 line; do
            ansible-vault - --vault-password-file=${VAULT_PASS_FILE_TMP} --new-vault-password-file=${VAULT_PASS_FILE_NEW} ${1} ${line} || exit
        done 5<${2}
        mv -f ${VAULT_PASS_FILE_NEW} ${VAULT_PASS_FILE}
        ;;

    * )
        f_usage
        ;;

esac

exit 0

