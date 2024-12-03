#!/bin/bash
# Encrypt or decrypt protected files.

# exit on error
set -e

SKIP_SHA256_CHECK=false
YES=false
CLEANUP=false
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && cd .. && pwd)"
SECRETS_ROOT="${PROJECT_ROOT}/secrets"

f_usage() {
    local Y="\033[0;33m" # yellow
    local ZZ="\033[0m"   # Reset
    printf "${Y}Usage: $(basename $0) [-e|--encrypt [-c|--cleanup]] [-d|--decrypt [-y|--yes]] [-s|--status]${ZZ}\n\n"
    printf "${Y}  Options:
    -e, --encrypt   Encrypt files in repository.
    -c, --cleanup   Remove decrypted files after encrypting them.
    -d, --decrypt   Decrypt files in repository.
    -y, --yes       Do not prompt to overwrite existing files during decryption.
    -s, --status    Show files with changed sha256 hashes.
    -f, --force     Always encrypt files regardless of sha256 hash. Useful for adding new encryption keys.${ZZ}\n"
}

# read the options
TEMP=$(getopt -o edcysf -l encrypt,decrypt,cleanup,yes,status,force -- "$@")
eval set -- "$TEMP"

# extract options and their arguments into variables.
while true; do
    case "$1" in
    -e | --encrypt)
        COMMAND=encrypt
        shift
        ;;
    -d | --decrypt)
        COMMAND=decrypt
        shift
        ;;
    -c | --cleanup)
        CLEANUP=true
        shift
        ;;
    -y | --yes)
        YES=true
        shift
        ;;
    -s | --status)
        COMMAND=status
        shift
        ;;
    -f | --force)
        SKIP_SHA256_CHECK=true
        shift
        ;;
    --)
        shift
        break
        ;;
    *)
        echo "Unknown parameter \"$1\""
        f_usage
        exit 1
        ;;
    esac
done

# Collect GPG Recipients:
# All public keys should be stored in the following format: full_email_address.pub
declare -a recipients=()
for key in $(ls .gpg_recipients); do
    recipients+="-r $(basename ${key%.*}) "
done

if [ "${COMMAND}" != "status" ]; then
    echo "Recipients: ${recipients}"
fi

case "${COMMAND}" in
encrypt)
    # The list of files to be encrypted
    declare -a secret_files=($(find ${SECRETS_ROOT} -mindepth 1 -type f \( ! -regex '.*/\..*' -a ! -regex '.*\.gpg' \) -name "*" -print))
    for file in "${secret_files[@]}"; do
        dir=$(dirname "${file}")
        secret_file=$(basename "${file}")
        secret_file_full_path="${dir}/${secret_file}"
        secret_file_full_sum_path="${dir}/.${secret_file}.sha256"
        if [ "${SKIP_SHA256_CHECK}" = "false" -a "$(sha256sum ${secret_file_full_path})" = "$(cat ${secret_file_full_sum_path})" ]; then
            printf "\033[0;32mSkipping unchanged file: ${file}\033[0m\n"
        else
            dos2unix "${file}"
            printf "\033[0;32mEncrypting ${file}\033[0m\n"
            gpg -e --yes --trust-model always ${recipients} "${file}"
        fi
        if $CLEANUP; then
            rm "${file}"
        fi
    done
    ;;

decrypt)
    # The list of files to be decrypted
    declare -a encrypted_files=($(find ${SECRETS_ROOT} -mindepth 1 -type f -regex '.*\.gpg' -print))
    for file in "${encrypted_files[@]}"; do
        dir=$(dirname "${file}")
        secret_file=$(basename "${file%.*}")
        shopt -s extglob
        secret_file_full_path="${dir}/${secret_file}"
        secret_file_full_sum_path="${dir}/.${secret_file}.sha256"
        printf "\033[0;32mDecrypting ${secret_file_full_path}\033[0m\n"
        if $YES; then
            gpg --yes --output "${secret_file_full_path}" --decrypt "${file}" || true
        else
            gpg --output "${secret_file_full_path}" --decrypt "${file}" || true
        fi
        sha256sum "${secret_file_full_path}" >"${secret_file_full_sum_path}" || true
    done
    ;;

status)
    # The list of files to compare sha256 hashes (should match encrypt section above.
    declare -a secret_files=($(find "${SECRETS_ROOT}" -mindepth 1 -type f \( ! -regex '.*/\..*' -a ! -regex '.*\.gpg' \) -name "*" -print))
    FOUND_CHANGED_FILE=0
    for file in "${secret_files[@]}"; do
        dir=$(dirname "${file}")
        secret_file=$(basename "${file}")
        secret_file_full_path="${dir}/${secret_file}"
        secret_file_full_sum_path="${dir}/.${secret_file}.sha256"
        if [ "$(sha256sum ${secret_file_full_path})" != "$(cat ${secret_file_full_sum_path})" ]; then
            printf "\033[0;32mChanged: ${file}\033[0m\n"
            FOUND_CHANGED_FILE=1
        fi
    done
    if [ $FOUND_CHANGED_FILE = 0 ]; then
        printf "\033[0;32mNo changed files detected.\033[0m\n"
    fi
    ;;

*)
    echo "\"$COMMAND\" was not a recognized command."
    f_usage
    exit 2
    ;;
esac

echo
exit 0
