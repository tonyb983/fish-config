function ask-yes-no
    #                             1  2  3  4  5  6          1                 2                  3               4               5                  6
    set -l _yes_no_part (printf "%s[%sy%s/%sN%s]%s" (set_color white) (set_color green) (set_color white) (set_color red) (set_color white) (set_color normal))
    #                                1                              2 3   4
    set -l _default_prompt (printf "%s\n\tDo you want to continue? %s%s: %s" (set_color blue) "$_yes_no_part" (set_color white) (set_color normal))
    set -l _prompt (
        switch (count $argv)
            case 0
                printf "%s" "$_default_prompt"
            case 1
                #        1     2  3 4   5           1            2            3                4                 5
                printf "%s\n\t%s %s%s: %s" (set_color normal) $argv[1] "$_yes_no_part" (set_color white) (set_color normal)
            case '*'
                printf "%sERROR: Too many arguments provided to ask-yes-no, using default prompt...%s\n" (set_color red) (set_color normal)
                printf "%s" "$_default_prompt"
        end
    )

    while true
        read -l --prompt-str "$_prompt" confirm

        switch $confirm
            case Y y yes YES
                return 0
            case '' N n
                return 1
        end
    end
end