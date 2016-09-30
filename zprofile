ulimit -c 0
umask 077

if [ -z "$LANG" ]; then
	extradata=.UTF-8
else
	extradata=$(echo "$LANG" | sed -e 's/^[A-Za-z_]*//')
fi

export LANG=fi_FI$extradata
export LC_NUMERIC=en_US$extradata
export LC_MESSAGES=en_US$extradata
export LC_TIME=en_US$extradata

unset extradata

if [ "`uname`" = FreeBSD ]; then
	# use ls colours that are actually distinguishable
	export LSCOLORS=Exgxcxdxbxegedabagacad
fi

#PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/games:/usr/local/sbin:/usr/local/bin:/usr/X11R7/bin:/usr/X11R6/bin:/usr/pkg/sbin:/usr/pkg/bin:$HOME/bin; export PATH
type ruby >/dev/null && PATH="$PATH:`ruby -e 'puts Gem.user_dir'`/bin"
export PATH

[ -x /usr/games/fortune ] && \
	/usr/games/fortune

for a in /usr/local/GNUstep/System/Makefiles/GNUstep.sh \
	/usr/lib/GNUstep/System/Makefiles/GNUstep.sh; do
    [ -x "$a" ] && . "$a"
done
