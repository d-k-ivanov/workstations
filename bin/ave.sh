#!/usr/bin/env bash

# Environment
ANSIBLE_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")" && cd .. && pwd)"

# Script
while read -u 5 line; do
    ${ANSIBLE_HOME}/bin/av encrypt ${line}
done 5<${ANSIBLE_HOME}/.enc
