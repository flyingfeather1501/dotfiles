function fish_default_mode_prompt --description 'Display the default mode for the prompt'
    # Do nothing if not in vi mode
    if test "$fish_key_bindings" = "fish_vi_key_bindings"
    or test "$fish_key_bindings" = "fish_hybrid_key_bindings"
        switch $fish_bind_mode
            case default
                set_color --bold --background red white
                echo '[N]'
            case insert
                set_color --bold --background green white
                echo '[I]'
            case replace_one
                set_color --bold --background green white
                echo '[R]'
            case visual
                set_color --bold --background magenta white
                echo '[V]'
        end
        set_color normal
        echo -n ' '
    end
    # inject wakatime tracking here
    type wakatime >/dev/null 2>/dev/null
    and begin
        wakatime --write \
                 --plugin "fish-local/0.1" \
                 --entity-type app \
                 --project "Terminal" \
                 --entity (echo $history[1] | cut -d ' ' -f 1) \
                 2>&1 > /dev/null &
        disown
    end
end
