#!/bin/bash

usage() {
    cat > /dev/stderr <<-EOF
	Usage: $(basename $0) <opts>

	Options:
        -s <SOMETHING>          Do I need this thing?
	EOF
    exit 1
}

while getopts "s:" opt; do
    case $opt in
        s) SOMETHING="$OPTARG";;
        h) usage;;
        \? ) usage;;
        *  ) usage;;
    esac
done
shift $((OPTIND -1))

USERS_DETAILS=$(terraform output users_details)
USERS_DETAILS=$(echo ${USERS_DETAILS} | sed s'/, ]/]/g' )

USERNAMES=$(jq '.[0]' <<<${USERS_DETAILS})
LOGIN_PASSWORDS=$(jq '.[1]' <<<${USERS_DETAILS})
ACCESS_KEYS=$(jq '.[2]' <<<${USERS_DETAILS})
SECRET_ACCESS_KEYS=$(jq '.[3]' <<<${USERS_DETAILS})
CONSOLE_LINK="https://$(terraform output account_id | jq -r '').signin.aws.amazon.com/console"

DECRYPTED_LOGIN_PASSWORDS=''
for LOGIN_PASSWORD in $( jq -rc '.[]' <<< ${LOGIN_PASSWORDS}); do
    PASS=$(echo ${LOGIN_PASSWORD} | base64 --decode | keybase pgp decrypt)
    if [[ -z ${DECRYPTED_LOGIN_PASSWORDS} ]]; then
        DECRYPTED_LOGIN_PASSWORDS=${PASS}
    else
        DECRYPTED_LOGIN_PASSWORDS="${DECRYPTED_LOGIN_PASSWORDS}, ${PASS}"
    fi
done

DECRYPTED_SECRET_ACCESS_KEYS=''
for SECRET_ACCESS_KEY in $( jq -rc '.[]' <<< ${SECRET_ACCESS_KEYS}); do
    SAK=$(echo ${SECRET_ACCESS_KEY} | base64 --decode | keybase pgp decrypt)
    if [[ -z ${DECRYPTED_SECRET_ACCESS_KEYS} ]]; then
        DECRYPTED_SECRET_ACCESS_KEYS=${SAK}
    else
        DECRYPTED_SECRET_ACCESS_KEYS="${DECRYPTED_SECRET_ACCESS_KEYS}, ${SAK}"
    fi
done
echo ${USERNAMES}
echo ${DECRYPTED_LOGIN_PASSWORDS}
echo ${DECRYPTED_SECRET_ACCESS_KEYS}
echo ${CONSOLE_LINK}
echo "-----------------------"

IFS=', '
read -r -a secret_access_keys <<< "$DECRYPTED_SECRET_ACCESS_KEYS"
read -r -a login_passwords <<< "$DECRYPTED_LOGIN_PASSWORDS"
rm -rf created_users
mkdir created_users
for index in "${!secret_access_keys[@]}"; do
    secret_access_key="${secret_access_keys[index]}"
    login_password="${login_passwords[index]}"
    username=$(jq -r ".[${index}]" <<< ${USERNAMES})
    access_key=$(jq -r ".[${index}]" <<< ${ACCESS_KEYS})
    console_link=$(echo ${CONSOLE_LINK})

    echo "Username is ${username}, ${secret_access_key}, ${login_password}, ${console_link}"
    echo "User name,Password,Access key ID,Secret access key,Console login link" > created_users/${username}
    echo "${username},${login_password},${access_key},${secret_access_key},${console_link}" >> created_users/$username
done