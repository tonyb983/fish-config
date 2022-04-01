function pseval --description "Runs a command or script text via Powershell"
    # printf "%spseval called.\n%s" (set_color blue) (set_color normal)
    # printf "Args: %s\n" $argv

    set -l _usage (printf "\n%sUSAGE:\n\t%s\$ %spseval %s<SCRIPT-TEXT>%s\n\nWhere %s<SCRIPT-TEXT>%s is a string containing text that will be executed as a powershell script.\n" (set_color white) (set_color green) (set_color white) (set_color yellow) (set_color normal) (set_color yellow) (set_color normal))

    if test (count $argv) -gt 1
        println "%sERROR: Too many arguments provided.%s" (set_color red) (set_color normal)
        println "%s" "$_usage"
        return 1
    end

    if test (count $argv) -lt 1
        println "%sERROR: Too few arguments provided.%s" (set_color red) (set_color normal)
        println "%s" "$_usage"
        return 1
    end

    set -l psscript $argv[1]

    if string-empty $psscript
        println "%sERROR: No powershell script text provided.%s" (set_color red) (set_color normal)
        println "%s" "$_usage"
        return 1
    end

    set -l pwsh_exe (command --search "pwsh.exe")

    if test $status -ne 0
        and command --search wslvar
        set -l pwsh_exe (wslpath (wslvar ProgramFiles)/PowerShell/7-preview/pwsh.exe)
    end

    if string length --quiet "$pwsh_exe"
        and test -x "$pwsh_exe"

        set -l ps1file (printf "/tmp/temp-script-%s.ps1" (date --iso-8601=seconds))
        printf "%s" "$psscript" > "$ps1file"
        # echo "pseval: running eval '$pwsh_exe' -NoProfile $ps1file"
        eval "'$pwsh_exe' -NoProfile $ps1file & "
    else
        printf "%spseval: powershell not found%s\n" (set_color red) (set_color normal)
    end
end