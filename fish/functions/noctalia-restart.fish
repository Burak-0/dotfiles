function noctalia-restart
    qs -c noctalia-shell list --all --json | jq .[].pid | xargs -r kill; qs -c noctalia-shell -d
end
