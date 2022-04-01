function humanize-secs
    if ! test (count $argv) -eq 1
        printf "%sERROR: %shumanize-secs%s expected %s1%s argument but received %s%s%s.%s\n" (set_color red) (set_color yellow) (set_color red) (set_color white) (set_color red) (set_color white) (count $argv) (set_color red) (set_color normal)
        return 1
    end
    set -l _input $argv[1]

    set -l _tmins (math -s0 $_input / 60)
    set -l _thrs (math -s0 $_tmins / 60)
    set -l _days (math -s0 $_thrs / 24)
    
    set -l _dsecs (math -s0 $_input % 60)
    set -l _dmins (math -s0 $_tmins % 60)
    set -l _dhrs (math -s0 $_thrs % 24)
    
    printf "%s days, %s hours, %s minutes, and %s seconds" $_days $_dhrs $_dmins $_dsecs
end