
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_SPACE
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS

PROMPT="%F{yellow}%n@%m%f %F{cyan}%D{%H:%M}%f %F{green}%~%f %F{blue}❯%f "

eval "$(zoxide init zsh)"

source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
# source "/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
# source "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# alias bat="batcat"
alias cd="z"
alias lg="lazygit"

r() {
    # 创建临时文件
    tmp="$(mktemp)"

    # 启动 ranger，并把最后所在目录写入临时文件
    ranger --choosedir="$tmp" "$@"

    # 确保临时文件存在
    if [ -f "$tmp" ]; then
        # 读出 ranger 退出时的目录
        dir="$(cat "$tmp")"
        rm -f "$tmp"

        # 如果目录有效，并且不是当前目录，就 cd 进去
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

# uv
if [[ -f "$HOME/.local/bin/env" ]];then
    . "$HOME/.local/bin/env"
fi

# Environment Variables
export TLDR_LANGUAGE=zh
export LLM_KEY=NONE
export EDITOR=nvim
export VISUAL=nvim

# Proxy
set_http_proxy() {
    local port="${1:-10808}"
    local host="${2:-127.0.0.1}"
    export http_proxy="http://$host:$port"
    export https_proxy="http://$host:$port"
    export all_proxy="socks5h://$host:$port"
    echo "✅ Proxy set to http://$host:$port (HTTP & HTTPS, ALL)"
}

set_socks_proxy() {
    local port="${1:-1080}"
    local host="${2:-127.0.0.1}"
    export http_proxy="socks5h://$host:$port"
    export https_proxy="socks5h://$host:$port"
    export all_proxy="socks5h://$host:$port"
    echo "✅ Proxy set to socks5h://$host:$port (HTTP & HTTPS, ALL)"
}

unset_proxy() {
    unset http_proxy
    unset https_proxy
    unset all_proxy
    echo "❎ Cleared proxy environment variables:"
    echo "   - http_proxy"
    echo "   - https_proxy"
    echo "   - all_proxy"
}

# Yazi
if command -v yazi >/dev/null 2>&1; then
    function y() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
        yazi "$@" --cwd-file="$tmp"
        if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
            builtin cd -- "$cwd"
        fi
        rm -f -- "$tmp"
    }
fi

