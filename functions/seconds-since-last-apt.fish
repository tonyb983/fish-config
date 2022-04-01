function seconds-since-last-apt
    set -l _aptdate (stat -c %Y '/var/cache/apt' 2>/dev/null)
    set -l _now (date +%s)
    set -l _diff (math $_now - $_aptdate)
    echo $_diff
end