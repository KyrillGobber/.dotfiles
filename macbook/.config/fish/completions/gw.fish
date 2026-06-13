function __gw_tasks
    if not test -e ./gradlew
        return
    end
    ./gradlew tasks --all --quiet 2>/dev/null | \
        string match '* - *' | \
        string replace -r '^\s*(\S+) .*' '$1'
end

complete -c gw -f -a "(__gw_tasks)"
