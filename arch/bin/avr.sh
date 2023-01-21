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
${ANSIBLE_HOME}/bin/av rekey "${ANSIBLE_HOME}/.enc"
