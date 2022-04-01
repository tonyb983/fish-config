function pwsh-eval --description "Runs a command or script text via Powershell"
    # printf "%spwsh-run called.\n%s" (set_color blue) (set_color normal)
    # printf "Args: %s\n" $argv

    if test (count $argv) -gt 1
        printf "%sERROR: Too many arguments provided.%s\n\n" (set_color red) (set_color normal)
        printf "USAGE:\n"
        printf "\t\$ %spwsh-run %s<SCRIPT-TEXT>%s\n" (set_color green) (set_color yellow) (set_color normal)
        printf "\n"
        printf "Where %s<SCRIPT-TEXT>%s is a string containing text that will be executed as a powershell script.\n" (set_color yellow) (set_color normal)
        return 1
    end

    if test (count $argv) -lt 1
        printf "%sERROR: No powershell script text provided.%s\n\n" (set_color red) (set_color normal)
        printf "USAGE:\n"
        printf "\t\$ %spwsh-run %s<SCRIPT-TEXT>%s\n" (set_color green) (set_color yellow) (set_color normal)
        printf "\n"
        printf "Where %s<SCRIPT-TEXT>%s is a string containing text that will be executed as a powershell script.\n" (set_color yellow) (set_color normal)
        return 1
    end

    set -l psscript $argv[1]

    if string-empty $psscript
        printf "%sERROR: No powershell script text provided.%s\n\n" (set_color red) (set_color normal)
        printf "USAGE:\n"
        printf "\t\$ %spwsh-run %s<SCRIPT-TEXT>%s\n" (set_color green) (set_color yellow) (set_color normal)
        printf "\n"
        printf "Where %s<SCRIPT-TEXT>%s is a string containing text that will be executed as a powershell script.\n" (set_color yellow) (set_color normal)
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
        echo "pwsh-run: running eval '$pwsh_exe' -NoProfile $ps1file"
        eval "'$pwsh_exe' -NoProfile $ps1file"
    else
        printf "%spwsh-run: powershell not found%s\n" (set_color red) (set_color normal)
    end
end