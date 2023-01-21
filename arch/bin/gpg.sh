#!/bin/bash
# Encrypt or decrypt protected files.
# Platform: Unix
# Author:   Dmitriy Ivanov

f_usage() {
    local Y="\033[0;33m"    # Yellow
    local ZZ="\033[0m"      # Reset
    printf "${Y}Usage: $(basename $0) <option>${ZZ}\n\n"
    printf "${Y}  Options:
    [e]ncrypt
    [d]ecrypt${ZZ}\n"
}

ANSIBLE_HOME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"

declare -a secured_files=(
    "${ANSIBLE_HOME}/secrets/ansible_password"
)

declare -a recipients=()
for key in `ls ${ANSIBLE_HOME}/gpg`; do
    recipients+="-r $(basename -- ${key%.*}) "
done

echo "Trusted persons: ${recipients}"

[[ -f $(which gpg2) ]] && gpg_exe='gpg2'
[[ -z ${gpg_exe}    ]] && gpg_exe='gpg'

case $1 in
	e|encrypt )
		shift
        for file in "${secured_files[@]}"; do
            printf "\033[0;32mEncrypting $file\033[0m\n"
            ${gpg_exe} -e --yes --trust-model always "${recipients}" "${file}"
        done
		;;
	d|decrypt )
		shift
        for file in "${secured_files[@]}"; do
            printf "\033[0;32mDecrypting $file\033[0m\n"
            ${gpg_exe} --output ${file} --decrypt ${file}.gpg
        done
		;;
  * )
		f_usage
		;;
esac

echo
exit 0
