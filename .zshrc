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
zstyle ':completion:*' menu select
zstyle ':completion:*' original true
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '/home/david/.zshrc'
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
setopt promptsubst

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

alias ls='ls --color --group-directories-first'
alias r=$FILE

# Edit Configs
alias evim='$EDITOR $VIMRC'
alias efile='$EDITOR $FILERC'
alias ei3='$EDITOR $I3CONF'
alias ezsh='$EDITOR $ZSHRC'
alias ecomp='$EDITOR $COMPRC'
alias eX='$EDITOR $XRESOURCES'

# Sneaky Vim Habit
alias :wq='exit'
alias :q='exit'

# Git Dots Repo Alias
alias config='/usr/bin/git --git-dir=$HOME/.dots/ --work-tree=$HOME'

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (zdharma/zinit)…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk
# Plugin Installation {{{
# Git plugin
zinit ice wait"0" lucid
zinit snippet OMZ::plugins/git/git.plugin.zsh
# cd to frecent directories with z
zinit ice wait"0" atload"touch ~/.z" lucid
zinit load rupa/z
# Improved vi-like functionality
zinit ice wait"0" lucid
zinit snippet OMZ::plugins/vi-mode/vi-mode.plugin.zsh
# Colored Man Pages
zinit ice wait"0" lucid
zinit load ael-code/zsh-colored-man-pages
# Notify about missing aliases
zinit ice wait"0" lucid
zinit load MichaelAquilina/zsh-you-should-use
# Autosuggestions
zinit ice wait"0" atload"_zsh_autosuggest_start" lucid
zinit load zsh-users/zsh-autosuggestions
# Powerline Prompt
# Powerline {{{
DEFAULT_USER=drichardson42
POWERLEVEL9K_VCS_STASH_ICON="\ue701"
POWERLEVEL9K_VCS_STAGED_ICON="\uf187"
POWERLEVEL9K_VCS_BOOKMARK_ICON="\uf461"
POWERLEVEL9K_VCS_UNTRACKED_ICON="\uf059"
POWERLEVEL9K_VCS_UNSTAGED_ICON="\uf06a"
POWERLEVEL9K_VCS_GIT_GITHUB_ICON="\uf408"
POWERLEVEL9K_TODO_ICON="\uf4a0"
POWERLEVEL9K_ETC_ICON="\uf6d7"
POWERLEVEL9K_CARRIAGE_RETURN_ICON="\uf810"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND='153'
POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND='236'
POWERLEVEL9K_VI_MODE_INSERT_FOREGROUND='153'
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='153'
POWERLEVEL9K_DIR_HOME_BACKGROUND='153'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='153'
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='236'
POWERLEVEL9K_DIR_HOME_FOREGROUND='236'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='236'
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status vi_mode virtualenv vcs)
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX=" "
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
# }}}
zinit light bhilburn/powerlevel9k
#zinit light romkatv/powerlevel10k
# Syntax Highlighting
zinit ice wait"0" atinit"zpcompinit; zpcdreplay" atload"FAST_HIGHLIGHT_STYLES[path]='bold'; FAST_HIGHLIGHT_STYLES[globbing]='fg=yellow'; FAST_HIGHLIGHT_STYLES[precommand]='fg=yellow,bold'" lucid
zinit light zdharma/fast-syntax-highlighting
# }}}

# Plugin Settings {{{
# Autosuggest
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=1
bindkey '^j' autosuggest-accept
bindkey '^k' autosuggest-execute
bindkey '^l' autosuggest-fetch
# }}}

source ~/.config/fzf/completion.zsh
source ~/.config/fzf/key-bindings.zsh
export FZF_DEFAULT_OPTS='--height 40% --border'
# fe - opens file in $EDITOR instead of returning it to command line
fe() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# fbr - checkout git branch
fbr() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PATH:$PYENV_ROOT/bin"
export WORKON_HOME=~/.ve
export PROJECT_HOME=~/projects
eval "$(pyenv init -)"
pyenv virtualenvwrapper_lazy

# NPM
export PATH="$PATH:$HOME/.npm-global/bin"
