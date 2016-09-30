# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install

if echotc Co >/dev/null 2>&1; then
	PS1="%F{blue}%B%T%b%f [%n@%m %c]%(?..%B%F{red}%?%b%f)%# "
else
	PS1="%B%T%b [%n@%m %c]%(?..%B%?%b)%# "
fi
RPROMPT="%D"

case $TERM in
	xterm*|rxvt*|dtterm|screen*)
		precmd() { print -Pn "\e]2;%m: %c\a" }
		preexec() { print -Pn "\e]2;(%m) ${1%% *}\a" }
		;;
esac

case "`uname`" in
	FreeBSD)
		alias ls='ls -G'
		;;
	Linux)
		alias ls='ls --color=auto'
		;;
	*)
		alias ls='ls -F'
		;;
esac

