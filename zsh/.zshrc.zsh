
# PROMPT='%F{yellow}%n@%m%f %F{cyan}%D{%H:%M}%f %F{green}%~%f %F{blue}❯%f '

# ─────────────────────────────────────────────────────────────────────────────
# starship
eval "$(starship init zsh)"

# uv
if [[ -f "$HOME/.local/bin/env" ]];then
    . "$HOME/.local/bin/env"
fi

# zoxide
eval "$(zoxide init zsh)"

# thefuck
if command -v thefuck >/dev/null 2>&1; then
    eval $(thefuck --alias)
fi

# ─────────────────────────────────────────────────────────────────────────────
# History Settings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY

# ─────────────────────────────────────────────────────────────────────────────
# Environment Variables
export TLDR_LANGUAGE=zh
export LLM_KEY=NONE
export EDITOR=nvim
export VISUAL=nvim
# export SQL_EDITOR=nvim

# ─────────────────────────────────────────────────────────────────────────────
# OS Detection
OS=$(uname | tr '[:upper:]' '[:lower:]')
[ "$OS" = "darwin" ] && OS_MAC="yes"
[ "$OS" = "linux" ] && {
    OS_LIN="yes"

    grep -qiE 'microsoft|wsl' /proc/version 2>/dev/null && OS_WSL="yes"

    if [ -f /etc/os-release ]; then
        . /etc/os-release
        if echo "$ID $ID_LIKE" | grep -qi debian; then
            OS_DEBIAN="yes"
        fi
    fi
}

# ─────────────────────────────────────────────────────────────────────────────
# Zsh Plugins
if [ -n "$OS_MAC" ]; then
    ZSH_AUTOSUGGESTIONS_PATH="$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
    ZSH_HIGHLIGHT_PATH="$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

fi

if [ -n "$OS_DEBIAN" ]; then
    ZSH_AUTOSUGGESTIONS_PATH="/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
    ZSH_HIGHLIGHT_PATH="/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

fi

[[ -f "$ZSH_AUTOSUGGESTIONS_PATH" ]] && source "$ZSH_AUTOSUGGESTIONS_PATH"
[[ -f "$ZSH_HIGHLIGHT_PATH" ]] && source "$ZSH_HIGHLIGHT_PATH"


# ─────────────────────────────────────────────────────────────────────────────
# Alias

# Directories
alias ..='cd ..'
alias cd='z'

alias vi='nvim'
alias vim='nvim'

# ls variants
alias ls='eza --icons=always'
alias la='eza -a --icons=always'
alias ll='eza -al --classify=always'
alias l='eza -al --classify --sort=modified --reverse'
alias lsd='eza -d .*'

# Various
alias h='history | tail'
alias hg='history | grep'
alias mvi='mv -i'
alias rmi='rm -i'
alias {ack,ak}='ack-grep'

if [ -n "$OS_DEBIAN" ]; then
    alias bat="batcat"

    alias aptcs='apt-cache search'
    alias apti='sudo aptitude install'
    alias aptr='sudo aptitude remove'
    alias aptre='sudo aptitude reinstall'
    alias apts='aptitude search'
    alias aptu='sudo aptitude update'
    alias aptuu='sudo aptitude update;sudo aptitude upgrade;'
fi

if [ -n "$OS_MAC" ]; then
    alias brewi='brew install'
    alias brews='brew search'

    alias {dhcpup,dhcp-start}='sudo /bin/launchctl load -w /System/Library/LaunchDaemons/bootps.plist'
    alias {dhcpdn,dhcp-stop}='sudo /bin/launchctl unload -w /System/Library/LaunchDaemons/bootps.plist'
fi

# ─────────────────────────────────────────────────────────────────────────────
# Wsl
if [ -n "$OS_WSL" ]; then

    function cdwinhome() {
        local username

        cd /mnt/c

        username=$(cmd.exe /c echo %USERNAME% | tr -d '\r')

        cd "/mnt/c/Users/$username" || echo "❌ Failed to cd to Windows home"
    }

    function open_excel() {
        if [[ $# -eq 0 ]]; then
            echo "❌ Usage: open_excel <file_path>"
            return 1
        fi

        if [[ ! -f "$1" ]]; then
            echo "❌ File not found: $1"
            return 1
        fi

        local filename
        filename=$(basename "$1")
        if [[ ! "$filename" =~ \.(xls[xm]?|csv)$ ]]; then
            echo "⚠️ Warning: File extension does not look like a supported Excel format (.xls/.xlsx/.xlsm/.csv)"
            # return 1  # Uncomment to enforce strict file type check
        fi

        local winpath
        winpath=$(wslpath -w "$1" 2>/dev/null)
        if [[ -z "$winpath" ]]; then
            echo "❌ Failed to convert to Windows path"
            return 1
        fi

        cmd.exe /c start "" "excel.exe" "$winpath"
    }

fi

# ─────────────────────────────────────────────────────────────────────────────
#
function show_dir_content() {
    local dir=""
    local exclude_ext=""
    local exclude_file=""
    local exclude_dir=""

    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --exclude-ext)
                exclude_ext="$2"
                shift 2
                ;;
            --exclude-file)
                exclude_file="$2"
                shift 2
                ;;
            --exclude-dir)
                exclude_dir="$2"
                shift 2
                ;;
            -*) # Unknown option
                echo "❌ Unknown option: $1"
                return 1
                ;;
            *) # First positional argument: the directory
                dir="$1"
                shift
                ;;
        esac
    done

    # Validate directory
    if [[ -z "$dir" || ! -d "$dir" ]]; then
        echo "❌ Usage: dump_dir <directory> [--exclude-ext EXT] [--exclude-file NAME] [--exclude-dir DIR]"
        return 1
    fi

    echo "📂 Directory structure:"
    if command -v tree >/dev/null 2>&1; then
        tree "$dir"
    else
        find "$dir" | sed 's|[^/]*/|  |g'
    fi

    echo
    echo "📄 File contents:"

    find "$dir" -type f -print0 | while IFS= read -r -d '' file; do
        # Exclude by extension
        if [[ -n "$exclude_ext" && "$file" =~ \.($exclude_ext)$ ]]; then
            continue
        fi

        # Exclude by filename
        if [[ -n "$exclude_file" && "$(basename "$file")" =~ ^($exclude_file)$ ]]; then
            continue
        fi

        # Exclude by directory
        if [[ -n "$exclude_dir" && "$file" =~ /($exclude_dir)/ ]]; then
            continue
        fi

        echo "=== $file ==="
        if [[ -s "$file" ]]; then
            cat "$file"
        else
            echo "(empty)"
        fi
        echo
    done
}

dump_dir() {
    local dir="$1"
    if [[ -z "$dir" || ! -d "$dir" ]]; then
        echo "用法: dump_dir <目录路径>"
        return 1
    fi

    echo "📂 目录结构："
    if command -v tree >/dev/null 2>&1; then
        tree "$dir"
    else
        find "$dir" | sed 's|[^/]*/|  |g'
    fi
    echo
    echo "📄 文件内容："

    find "$dir" -type f -print0 | while IFS= read -r -d '' file; do
        echo "=== $file ==="
        cat "$file"
        echo
    done
}

# ─────────────────────────────────────────────────────────────────────────────
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

# ─────────────────────────────────────────────────────────────────────────────
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

# ─────────────────────────────────────────────────────────────────────────────

# Archives
function extract {
    if [ -z "$1" ]; then
        echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    else
        if [ -f $1 ]; then
            case $1 in
                *.tar.bz2) tar xvjf $1 ;;
                *.tar.gz) tar xvzf $1 ;;
                *.tar.xz) tar xvJf $1 ;;
                *.lzma) unlzma $1 ;;
                *.bz2) bunzip2 $1 ;;
                *.rar) unrar x -ad $1 ;;
                *.gz) gunzip $1 ;;
                *.tar) tar xvf $1 ;;
                *.tbz2) tar xvjf $1 ;;
                *.tgz) tar xvzf $1 ;;
                *.zip) unzip $1 ;;
                *.Z) uncompress $1 ;;
                *.7z) 7z x $1 ;;
                *.xz) unxz $1 ;;
                *.exe) cabextract $1 ;;
                *) echo "extract: '$1' - unknown archive method" ;;
            esac
        else
            echo "$1 - file does not exist"
        fi
    fi
}

alias extr='extract '
function extract_and_remove {
    extract $1
    rm -f $1
}

alias extrr='extract_and_remove '

function abspath() {
    if [ -d "$1" ]; then
        echo "$(
			cd $1
			pwd
        )"
    elif [ -f "$1" ]; then
        if [[ $1 == */* ]]; then
            echo "$(
         cd ${1%/*}
        pwd
            )/${1##*/}"
        else
            echo "$(pwd)/$1"
        fi
    fi
}

# Output
alias lcase="tr '[:upper:]' '[:lower:]'"
alias ucase="tr '[:lower:]' '[:upper:]'"

# System
[ -n "$OS_MAC" ] && alias nproc="sysctl hw.ncpu | awk '{print \$2}'"
CORES=$(nproc)
JOBS=$(expr $CORES + 1)
alias make="make -j$JOBS"

if [ -n "$OS_MAC" ]; then
    function free() {
        FREE_BLOCKS=$(vm_stat | grep free | awk '{ print $3 }' | sed 's/\.//')
        INACTIVE_BLOCKS=$(vm_stat | grep inactive | awk '{ print $3 }' | sed 's/\.//')
        SPECULATIVE_BLOCKS=$(vm_stat | grep speculative | awk '{ print $3 }' | sed 's/\.//')
        FREE=$((($FREE_BLOCKS + SPECULATIVE_BLOCKS) * 4096 / 1048576))
        INACTIVE=$(($INACTIVE_BLOCKS * 4096 / 1048576))
        TOTAL=$((($FREE + $INACTIVE)))
        echo "Free:       $FREE MB"
        echo "Inactive:   $INACTIVE MB"
        echo "Total free: $TOTAL MB"
    }
    alias free="free"
fi

# Files
alias lcf="rename 'y/A-Z/a-z/' "
alias ucf="rename 'y/a-z/A-Z/' "

# Tmux
alias {ton,tn}='tmux set -g mode-mouse on'
alias {tof,tf}='tmux set -g mode-mouse off'


# Mac ports

# Grep
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'

# DNS
alias {hostname2ip,h2ip}='dig +short'

# Mac DHCP service

# Clipboard
[ -n "$OS_MAC" ] && alias getcb='pbpaste'
[ -n "$OS_WIN" ] && alias getcb='cat /dev/clipboard'
[ -n "$OS_LIN" ] && alias getcb='xclip -o'

# Wget
alias wgetncc='wget --no-check-certificate'
alias wgetc='wget `getcb`'

function wget_archive_and_extract {
    URL=$1
    FILENAME=${URL##*/}
    wget $URL -O $FILENAME
    extract $FILENAME
    rmi $FILENAME
}
alias wgetae='wget_archive_and_extract '
alias wgetaec='wgetae getcb'

# Utils
alias sitecopy='wget -k -K -E -r -l 10 -p -N -F -nH '
alias ytmp3='youtube-dl --extract-audio --audio-format mp3 '

# tools
alias lzg=lazygit
alias lzd=lazydocker

if [ -n "$OS_WSL" ]; then

    export TEMP_DNS_ACTIVE=""

    function temp_dns_map() {
        if [[ $# -ne 2 ]]; then
            echo "❌ 用法: temp_dns_map <ip> <hostname>"
            return 1
        fi

        local ip="$1"
        local name="$2"
        local line="$ip $name"

        export TEMP_DNS_ACTIVE="$line"

        if grep -q "$line" /etc/hosts; then
            echo "ℹ️ 映射已存在: $line"
        else
            echo "$line" | sudo tee -a /etc/hosts >/dev/null
            echo "✅ 已添加临时 DNS 映射: $line"
        fi
    }

    function clear_temp_dns_map() {
        if [[ -n "$TEMP_DNS_ACTIVE" && "$(grep "$TEMP_DNS_ACTIVE" /etc/hosts)" != "" ]]; then
            sudo sed -i "\|$TEMP_DNS_ACTIVE|d" /etc/hosts
            echo "🧹 临时 DNS 映射已清除: $TEMP_DNS_ACTIVE"
            export TEMP_DNS_ACTIVE=""
        fi
    }

    clear_temp_dns_map

    trap clear_temp_dns_map EXIT
fi
