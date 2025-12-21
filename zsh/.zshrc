# ==========================================
# 1. 基础环境与路径配置
# ==========================================
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

export PATH="$HOME/.local/bin:$PATH"

# CUDA 路径 (针对 Triton/GPU 开发)
if [ -d "/usr/local/cuda" ]; then
    export CUDA_HOME=/usr/local/cuda
    export PATH="$CUDA_HOME/bin:$PATH"
    export LD_LIBRARY_PATH="$CUDA_HOME/lib64:$LD_LIBRARY_PATH"
fi

# ==========================================
# 2. 提示符与补全系统
# ==========================================
eval "$(starship init zsh)"

autoload -Uz compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
    compinit
else
    compinit -C
fi

# 修正：确保 fpath 赋值正确
fpath=(~/.zsh/plugins/zsh-completions/src $fpath)

# ==========================================
# 3. 插件加载 (添加了更稳健的判断)
# ==========================================
for plugin in zsh-autosuggestions/zsh-autosuggestions.zsh zsh-syntax-highlighting/zsh-syntax-highlighting.zsh; do
    [ -f "$HOME/.zsh/plugins/$plugin" ] && source "$HOME/.zsh/plugins/$plugin"
done

# ==========================================
# 4. 代理与别名设置
# ==========================================
alias proxy="export http_proxy=http://127.0.0.1:7897 https_proxy=http://127.0.0.1:7897 all_proxy=http://127.0.0.1:7897"
alias unproxy="unset http_proxy https_proxy all_proxy"

if command -v eza >/dev/null 2>&1; then
    alias ls="eza --icons --group-directories-first"
    alias ll="eza -lh --icons --group-directories-first"
    alias la="eza -a --icons"
    alias tree="eza --tree --icons"
else
    alias ls='ls --color=auto'
    alias ll='ls -l --color=auto'
fi

command -v batcat >/dev/null 2>&1 && alias cat="batcat --paging=never"
command -v btm >/dev/null 2>&1 && alias top="btm"
alias vi="nvim"
alias v="nvim"
alias lg="lazygit"
alias dot="cd ~/dotfiles"

# ==========================================
# 5. 历史记录与交互
# ==========================================
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt INTERACTIVE_COMMENTS

# 历史搜索快捷键
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

# ==========================================
# 6. 启动信息
# ==========================================
if [[ -o interactive ]] && command -v fastfetch >/dev/null 2>&1; then
    fastfetch --logo small --structure Title:Separator:OS:Host:Kernel:Uptime:Shell:Terminal:CPU:Memory
fi
