function fish_prompt --description 'Write out the prompt'
    set -l color_cwd
    set -l suffix
    switch "$USER"
        case root toor
            if set -q fish_color_cwd_root
                set color_cwd $fish_color_cwd_root
            else
                set color_cwd $fish_color_cwd
            end
            set suffix '#'
        case '*'
            set color_cwd $fish_color_cwd
            set suffix '>'
    end
    # wakatime
    wakatime --write \
             --plugin "fish-local/0.1" \
             --entity-type app \
             --project "Terminal" \
             --entity (echo $history[1] | cut -d ' ' -f 1) \
             2>&1 > /dev/null &
    disown

    echo -n -s "$USER" @ (prompt_hostname) ' ' (set_color $color_cwd) (prompt_pwd) (set_color normal) "$suffix "
end
