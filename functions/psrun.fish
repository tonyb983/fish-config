function psrun --description "Runs a script file via Powershell"
    # printf "%spsrun called.\n%s" (set_color blue) (set_color normal)
    # printf "Args: %s\n" $argv

    set -l _usage (printf "\n%sUSAGE:\n\t%s\$ %spsrun %s<FILE>%s\n\nWhere %s<FILE>%s is a file containing a powershell script.\n" (set_color white) (set_color green) (set_color white) (set_color yellow) (set_color normal) (set_color yellow) (set_color normal))

    if test (count $argv) -gt 1
        printf "%sERROR: Too many arguments provided.%s\n" (set_color red) (set_color normal)
        printf "%s\n" "$_usage"
        return 1
    end

    if test (count $argv) -lt 1
        printf "%sERROR: No powershell script file provided.%s\n" (set_color red) (set_color normal)
        printf "%s\n" "$_usage"
        return 1
    end

    set -l psfile $argv[1]

    if string-empty $psfile
        printf "%sERROR: No powershell script file provided.%s\n" (set_color red) (set_color normal)
        printf "%s\n" "$_usage"
        return 1
    end

    set -l pwsh_exe (command --search "pwsh.exe")

    if test $status -ne 0
        and command --search wslvar
        set -l pwsh_exe (wslpath (wslvar ProgramFiles)/PowerShell/7-preview/pwsh.exe)
    end

    if string length --quiet "$pwsh_exe"
        and test -x "$pwsh_exe"

        if test -e (realpath "$psfile" >>/dev/null)
            # echo "psrun: running eval '$pwsh_exe' -NoProfile $psfile"
            eval "'$pwsh_exe' -NoProfile $psfile"
        else
            printf "%spsrun: unable to find provided script file%s\n" (set_color red) (set_color normal)
        end
    else
        printf "%spsrun: powershell not found%s\n" (set_color red) (set_color normal)
    end
end