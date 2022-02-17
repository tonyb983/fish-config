function trimString()
{
    local -r string="${1}"

    sed -e 's/^ *//g' -e 's/ *$//g' <<< "${string}"
}

function isEmptyString()
{
    local -r string="${1}"

    if [[ "$(trimString "${string}")" = '' ]]
    then
        echo 'true'
    else
        echo 'false'
    fi
}

function info()
{
    local -r message="${1}"

    echo -e "\033[1;36m${message}\033[0m" 2>&1
}

function getLastAptGetUpdate()
{
    local aptDate="$(stat -c %Y '/var/cache/apt' 2>/dev/null)"
    local nowDate="$(date +'%s')"

    if [[ "${aptDate}" = '' ]]
    then
        echo '0'
    else
        echo "$((nowDate - aptDate))"
    fi
}

function notifyLastUpdate()
{
    local lastAptGetUpdate="$(getLastAptGetUpdate)"
    if [[ "${lastAptGetUpdate}" = "0" ]]
    then
        info 'Unable to read last apt-get update time!'
        return 1
    else
        local lastUpdate="$(date -u -d @"${lastAptGetUpdate}" +'%-Hh %-Mm %-Ss')"
        info "\nLast apt-get update was run '${lastUpdate}' ago"
    fi
}

function runAptGetUpdate()
{
    local updateInterval="${1}"

    local lastAptGetUpdate="$(getLastAptGetUpdate)"
    if [[ "${lastAptGetUpdate}" = "0" ]]
    then
        info 'Unable to read last apt-get update time!'
        return 1
    fi

    if [[ "$(isEmptyString "${updateInterval}")" = 'true' ]]
    then
        # Default To 24 hours
        updateInterval="$((24 * 60 * 60))"
    fi

    if [[ "${lastAptGetUpdate}" -gt "${updateInterval}" ]]
    then
        info "apt-get update && apt-get upgrade"
        apt-get update -m && apt-get upgrade -y
    else
        local lastUpdate="$(date -u -d @"${lastAptGetUpdate}" +'%-Hh %-Mm %-Ss')"

        info "\nSkip update & upgrade because its last run was '${lastUpdate}' ago"
    fi
}

notifyLastUpdate