# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# Eza aliases
alias ls='eza --icons --group-directories-first'
alias la='eza -a --icons --group-directories-first'
alias ll='eza -la --icons --git --time-style=relative --group-directories-first'
alias lt='eza --tree --icons --level=2'
alias tree='eza --tree --icons'

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

# Run fastfetch on startup
fastfetch

# Run zodixe 
eval "$(zoxide init bash)"

# Run starship (must be before atuin to register preexec hooks first)
[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh
eval "$(starship init bash)"

# Run atuin
source /usr/libexec/atuin/atuin-init.bash
