function println
    switch (count $argv)
        case 0
            printf "\n"
        case 1
            printf "%s\n" $argv[1]
        case '*'
            set -l _fmtstr (printf "%s\n" $argv[1])
            printf $_fmtstr $argv[2..-1]
    end
end