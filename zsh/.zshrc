
. "$HOME/.local/bin/env"

# 1. 初始化 Starship
eval "$(starship init zsh)"

# 2. 命令补全系统
autoload -Uz compinit
# 每天只检查一次缓存
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
    compinit
else
    compinit -C
fi

# 3. 加载插件 (指向我们手动 Clone 的位置)
source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# zsh-completions 稍微特殊，需要添加到 fpath
fpath=(~/.zsh/plugins/zsh-completions/src $fpath)

# 4. Fastfetch (如果已安装)
if command -v fastfetch &>/dev/null; then
    fastfetch --logo small --structure Title:Separator:OS:Host:Kernel:Uptime:Shell:Terminal:CPU:Memory
fi

# 5. 别名 (可选)
alias ls='ls --color=auto'
alias ll='ls -l --color=auto'


# 历史记录文件路径
HISTFILE=~/.zsh_history
# 内存和磁盘中保存的命令数量
HISTSIZE=10000
SAVEHIST=10000
# 立即写入文件，而不是等终端关闭
setopt INC_APPEND_HISTORY
# 多个终端窗口共享历史记录
setopt SHARE_HISTORY
# 忽略重复的命令
setopt HIST_IGNORE_DUPS

export PATH=$HOME/.local/bin:$PATH
export PATH="$HOME/.local/bin:$PATH"
