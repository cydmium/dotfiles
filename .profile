#!/bin/sh
if command -v nvim > /dev/null 2>&1; then
	export EDITOR="nvim"
	export VIMRC=~/.config/nvim/init.vim
	export VIMCONF=~/.config/nvim
elif command -v vim > /dev/null 2>&1; then
	export EDITOR="vim"
	export VIMRC=~/.vimrc
	export VIMCONF=~/.vim
else
	export EDITOR="vi"
	export VIMRC=~/.vimrc
	export VIMCONF=~/.vim
fi

export BROWSER="firefox"
export BROWSER_TERM="w3m"
export WWW_HOME="google.com"

export PATH="$HOME/.local/bin:$(du "$HOME/.local/bin" | cut -f2 | tr '\n' ':' | sed 's/:*$//'):$PATH"
export RANGER_LOAD_DEFAULT_RC=FALSE
export FILERC=$HOME/.config/ranger/rc.conf
export I3CONF=$HOME/.config/i3/config
export COMPRC=$HOME/.config/compton.conf
export ZSHRC=$HOME/.zshrc
export XINITRC=$HOME/.xinitrc
export XRESOURCES=$HOME/.Xresources
export FILE="ranger"
export TERMINAL="urxvt"
export READER="zathura"
export BIB="$HOME/latex/bibliography.bib"
