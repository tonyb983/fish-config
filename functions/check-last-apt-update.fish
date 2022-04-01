function check-last-apt-update
    set -l _last_update (seconds-since-last-apt)
    if is-between $_last_update 0 86400
        printf "%sIt has been %s since last update.%s\n" (set_color green) (humanize-secs $_last_update) (set_color normal)
    else if is-between 86400 604800
        printf "%sIt has been %s since last update.%s\n" (set_color yellow) (humanize-secs $_last_update) (set_color normal)
    else
        printf "%sIt has been %s since last update.%s\n" (set_color red) (humanize-secs $_last_update) (set_color normal)
        if ask-yes-no "Would you like to run apt-get update && apt-get upgrade now?"
            sudo apt-get update && sudo apt-get upgrade -y && sudo apt autoremove
        end
    end
end
