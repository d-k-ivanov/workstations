#!/usr/bin/env bash

echo "=== Welcome to Ansible runner ==="
echo

# Environment
PROJECT_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")" && cd .. && pwd)"
ANSIBLE_HOME="${PROJECT_HOME}/ubuntu"
VAULT_PASS_FILE="${PROJECT_HOME}/secrets/ansible_password"
VAULT_PASS_FILE_TMP="/tmp/ansible_password.tmp"

if [ ! -f ${VAULT_PASS_FILE} ]; then
    echo ">>> Error: Ansible password is missing!"
    echo "Please run ${PROJECT_HOME}/ubuntu/bin/create_pass.sh to configure your ansible password"
    read -n 1 -p "Do you want to do it right now? (y/[Any key to cancel]): " WANT_INIT
    [ "${WANT_INIT}" = "y" ] || exit 1
    echo
    ${PROJECT_HOME}/bin/create_pass.sh
    echo
fi

# Temporary files with autodeletion
trap "{ rm -f ${VAULT_PASS_FILE_TMP}; }" EXIT
cat ${VAULT_PASS_FILE} >${VAULT_PASS_FILE_TMP}
chmod 600 ${VAULT_PASS_FILE_TMP}

# Script
f_usage() {
    echo "Usage: $0 <COMMAND> <NODE_TYPE>"
    echo "
    COMMAND:
        a   - to run ansible ad-hoc commands
        ap  - to run ansibpe-playbooks
        inv - to show ansible inventory

    NODE_TYPE
        wsl      - Windows Subsystem for Linux
        dell7510 - Dell Precision 7510
        neo17    - XMG Neo 17

    "
}

if [ $# -lt 1 ]; then
    f_usage
    exit 1
fi

CMD=$1
shift

if [ "${CMD}" = "ap" ]; then
    NODE_TYPE=$1
    shift
    if [[ "${NODE_TYPE}" != @(wsl|dell7510|neo17) ]]; then
        echo ">>> Error: Unknown node type: ${NODE_TYPE}"
        f_usage
        exit 1
    fi
fi

case $CMD in
a)
    eval ansible \
        -i ${ANSIBLE_HOME}/inventory \
        --vault-password-file=${VAULT_PASS_FILE_TMP} \
        $@
    ;;

ap)
    eval ansible-playbook \
        -i ${ANSIBLE_HOME}/inventory \
        --vault-password-file=${VAULT_PASS_FILE_TMP} \
        ${ANSIBLE_HOME}/${NODE_TYPE}.yml \
        $@
    ;;
inv)
    eval ansible-inventory \
        -i ${ANSIBLE_HOME}/inventory \
        --vault-password-file=${VAULT_PASS_FILE_TMP} \
        --graph -y $@
    ;;
*)
    f_usage
    ;;
esac

echo
exit 0
