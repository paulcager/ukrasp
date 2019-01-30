# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export BASEDIR=/root/rasp/
export PATH+=:$BASEDIR/bin
export PERL5LIB=.
export NCARG_ROOT=/
