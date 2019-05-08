# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' completions 1
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents pwd
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=** r:|=** l:|=*'
zstyle ':completion:*' max-errors 1
zstyle ':completion:*' menu select=long
zstyle ':completion:*' original true
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '/home/david/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# History Configuration
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
setopt appendhistory 
setopt sharehistory
setopt incappendhistory

# Assorted Settings
setopt autocd
unsetopt beep nomatch
bindkey -v

# Correction Prompt
setopt correct
autoload -U colors && colors
export SPROMPT="Correct $fg[red]%R$reset_color to $fg[green]%r$reset_color? (Yes, No, Abort, Edit) "

# Fix BS delete and home
bindkey "^?" backward-delete-char
bindkey "^[[7~" beginning-of-line
bindkey "^[[8~" end-of-line
bindkey "^[[3~" delete-char
bindkey "^[[Z" menu-complete
# Better History Search
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

if command -v nvim > /dev/null 2>&1; then
	alias vi=nvim
	alias vim=nvim
	alias vimdiff='nvim -d'
elif command -v vim > /dev/null 2>&1; then
	alias vi=vim
fi

alias ls='ls --color'
alias r=$FILE
alias sc=sc-im

# Edit Configs
alias evim='$EDITOR $VIMRC'
alias efile='$EDITOR $FILERC'
alias ei3='$EDITOR $I3CONF'
alias ezsh='$EDITOR $ZSHRC'
alias ecomp='$EDITOR $COMPRC'
alias eX='$EDITOR $XINITRC $XRESOURCES'

# Sneaky Vim Habit
alias :wq='exit'
alias :q='exit'

# Git Dots Repo Alias
alias config='/usr/bin/git --git-dir=$HOME/.dots/ --work-tree=$HOME'
