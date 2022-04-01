function is-between
    if test (count $argv) -eq 3
        set -l _is_gte (test $argv[1] -eq $argv[2] -o $argv[1] -gt $argv[2] && echo "YES" || echo "NO")
        set -l _is_lte (test $argv[1] -eq $argv[3] -o $argv[1] -lt $argv[3] && echo "YES" || echo "NO")

        if test "$_is_gte" = "YES" -a "$_is_lte" = "YES"
            return 0
        else 
            return 1
        end
    else
        printf "%sERROR: is-between requires 3 arguments, received %s.%s\n" (set_color red) (count $argv) (set_color normal)
        return 1
    end
end