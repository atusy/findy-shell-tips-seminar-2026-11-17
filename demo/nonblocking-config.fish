# リポジトリのルートで起動し、すぐに echo hello と打ってみよう。
# fish --no-config -C 'source demo/nonblocking-config.fish'
set -g fish_greeting

function demo_clear_branch --on-event fish_exit
    if set -q demo_branch_dir[1]
        command rm -rf -- "$demo_branch_dir"
        set -e demo_branch_dir
    end
end

function demo_fetch_branch --on-event fish_prompt
    # コマンド実行後は新しい保存先を使い、前のプロンプトの結果と混ざらないようにする。
    demo_clear_branch
    set -g demo_branch_dir (mktemp -d); or return
    fish --no-config -c '
        sleep 5
        git branch --show-current >"$argv[1]/pending" 2>/dev/null
        and mv "$argv[1]/pending" "$argv[1]/branch"
        and kill -s USR1 $argv[2]
    ' -- "$demo_branch_dir" $fish_pid </dev/null >/dev/null 2>&1 &
    disown $last_pid
end

function demo_refresh_prompt --on-signal USR1
    commandline -f repaint
end

function fish_prompt
    printf '%s' (prompt_pwd)
    if test -f "$demo_branch_dir/branch"; and read -l branch <"$demo_branch_dir/branch"
        test -n "$branch"; and printf ' (%s%s%s)' (set_color red) "$branch" (set_color normal)
    end
    printf ' > '
end
