#!/bin/bash
#
# Wrapper to decrypt all vault encrypted files
# Platform: Unix
#
# Author:   Dmitriy Ivanov
#

# Environment
ANSIBLE_HOME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"

# Script
while read -u 5 line; do
    ${ANSIBLE_HOME}/bin/av decrypt ${line}
done 5<${ANSIBLE_HOME}/.enc

