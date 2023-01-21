#!/bin/bash
#
# Wrapper to run Ansible in playbook mode
# Platform: Unix
#
# Author:   Dmitriy Ivanov
#

echo "=== Welcome to Ansible runner ==="
echo

# Environment
ANSIBLE_HOME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
VAULT_PASS_FILE="${ANSIBLE_HOME}/secrets/ansible_password"
VAULT_PASS_FILE_TMP="/tmp/ansible_password.tmp"

if [ ! -f ${VAULT_PASS_FILE} ]; then
    echo ">>> Error: Ansible password is missing!"
    echo "Please run ${ANSIBLE_HOME}/create_pass.sh to configure your ansible password"
    read -n 1 -p "Do you want to do it right now? (y/[Any key to cancel]): " WANT_INIT
    [ "${WANT_INIT}" = "y" ] || exit 1
    echo
    ${ANSIBLE_HOME}/bin/create_pass.sh
    echo
fi

# Temporary files with autodeletion
trap "{ rm -f ${VAULT_PASS_FILE_TMP}; }" EXIT
cat ${VAULT_PASS_FILE} > ${VAULT_PASS_FILE_TMP}
chmod 600 ${VAULT_PASS_FILE_TMP}

# Script
f_usage() {
    echo "Usage: $0 <COMMAND>"
    echo "
    COMMAND:
        a  - to run ansible ad-hoc commands
        ap - to rub ansibpe-playbooks
    "
}

case $1 in
    a )
        shift
        eval ansible                                        \
            -i ${ANSIBLE_HOME}/inventory                    \
            --vault-password-file=${VAULT_PASS_FILE_TMP}    \
            $@
        ;;

    ap )
        shift
        ansible-playbook                                    \
            -i ${ANSIBLE_HOME}/inventory                    \
            --vault-password-file=${VAULT_PASS_FILE_TMP}    \
            ${ANSIBLE_HOME}/dell-7510.yml                   \
            $@
        ;;
  * )
        f_usage
        ;;
esac

echo
exit 0
