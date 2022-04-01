set fish_greeting
set VIRTUAL_ENV_DISABLE_PROMPT "1"
set -x MANPAGER "sh -c 'col -bx | bat --theme \"Sublime Snazzy\" -l man -p'"
set -x BAT_THEME "Dracula"
set -x EDITOR /usr/bin/micro

set -U __done_min_cmd_duration 10000
set -U __done_notification_urgency_level low

# test -e ~/.profile && source ~/.profile

# Add ~/.local/bin to PATH
if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end

# Add ~/.local/bin to PATH
if test -d ~/bin
    if not contains -- ~/bin $PATH
        set -p PATH ~/bin
    end
end

if test -d ~/.cargo
    if not contains -- ~/.cargo/bin $PATH
        set -p PATH ~/.cargo/bin
    end
end

## Functions
# Functions needed for !! and !$ https://github.com/oh-my-fish/plugin-bang-bang
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

if [ "$fish_key_bindings" = fish_vi_key_bindings ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end

# Fish command history
function history
    builtin history --show-time='%F %T '
end

function backup --argument filename
    cp $filename $filename.bak
end

function invoke_fetch
    macchina # -t (random choice Hydrogen Helium Lithium Beryllium Boron)
end

# Copy DIR1 DIR2
function copy
    set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
	      set from (echo $argv[1] | trim-right /)
	      set to (echo $argv[2])
        command cp -r $from $to
    else
        command cp $argv
    end
end

# Add fenv to path
# set fish_function_path $fish_function_path ~/.config/fish/plugins/plugin-foreign-env/functions
# Source NIX setup script
fenv source ~/.nix-profile/etc/profile.d/nix.sh

# Aliases
# alias bat='bat --theme "Sublime Snazzy" --style header --style rules --style snip --style changes --style header'
alias cat='bat --theme Dracula --style header --style rules --style snip --style changes --style header'
alias gh='gh.exe'
alias ls='lsd --group-dirs first --icon-theme fancy'
alias ll='lsd --almost-all -lL --size short --date relative --group-dirs first --icon-theme fancy --blocks "permission,size,date,name"'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

if status is-interactive
    starship init fish | source
    test "/mnt/c/Users/alexa" = (pwd) && cd ~ && clear && invoke_fetch
    bash ~/.config/fish/scripts/check_last_update.bash
end
