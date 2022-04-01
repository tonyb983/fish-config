function gacp --description "Git add, commit, and push to remote" --argument msg
    if test -d (pwd)"/.git"
        echo "Is git repo"
        if test "$msg" = ''
            printf "%sNo commit message provided!%s\n" (set_color red) (set_color clear)
            return 1
        end
        set -l gstatus (git status)
        if string match '*nothing to commit*' $gstatus
            printf "%sNothing to commit.%s\n" (set_color yellow) (set_color clear)
            return 0
        end
        set -l gbranch (git branch | grep '*' | cut -c 3-)
        set -l gremote (git remote)

        if string-empty $gbranch
            printf "%sUnable to get branch name!%s\n" (set_color red) (set_color clear)
            return 1
        end
        if string-empty $gremote
            printf "%sUnable to get remote name!%s\n" (set_color red) (set_color clear)
            return 1
        end

        echo "Running 'git add .'"
        git add .
        if "$status" = '0'
            echo "success!"
        else
            printf "%sError during git add!%s\n" (set_color red) (set_color clear)
        end

        echo "Running 'git commit -m \"$msg\"'"
        git commit -m "$msg"
        if "$status" = '0'
            echo "success!"
        else
            printf "%sError during git commit!%s\n" (set_color red) (set_color clear)
        end

        echo "Running 'git push -u $gremote $gbranch'"
        git push -u $gremote $gbranch
        if "$status" = '0'
            echo "success!"
        else
            printf "%sError during git push!%s\n" (set_color red) (set_color clear)
        end

    else
        printf "%sThis directory does not seem to be a git repository (no .git directory found in %s).%s\n" (set_color red) (pwd) (set_color clear)
        return 1
    end
end