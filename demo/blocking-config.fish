# リポジトリのルートで起動し、すぐに echo hello と打ってみよう。
# fish --no-config -C 'source demo/blocking-config.fish'
set -g fish_greeting

function fish_prompt
    set -l dir (prompt_pwd)
    # fishがプロンプトを受け取る前に、暫定表示だけを端末へ直接書く。
    printf '%s > ' "$dir" >/dev/tty
    sleep 5
    set -l branch (git branch --show-current 2>/dev/null)
    printf '\r\e[2K' >/dev/tty
    printf '%s' "$dir"
    test -n "$branch"; and printf ' (%s%s%s)' (set_color red) "$branch" (set_color normal)
    printf ' > '
end
