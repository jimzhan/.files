# ============================================================
#  ALIASES AND FUNCTIONS
# ------------------------------------------------------------
#  Arguably, some functions defined here are quite big.
#  If you want to make this file smaller, these functions can
# be converted into scripts and removed from here.
# ============================================================
alias vi="vim"
#alias vim='vim --servername vim'

##-------------------
## Personnal Aliases
##-------------------
alias e="emacs"
alias rm="trash"
alias ag="ag --page=less"
alias du="du -sh"
alias got="go get -v"
alias xcode='open *.xcworkspace'
alias server="python -m SimpleHTTPServer"
alias lstcp="lsof -i -n -P | grep TCP"
alias lsudp="lsof -i -n -P | grep UDP"
if [ -x /usr/local/bin/ipython ]; then
  alias ip="ipython"
fi
if [ -x /usr/local/bin/gls ]; then
  alias ls="gls --color=auto --group-directories-first"
fi

##-------------------
## Golang Aliases
##-------------------
alias gb="go build && go install"

