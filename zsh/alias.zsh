# ============================================================
#  ALIASES AND FUNCTIONS
# ------------------------------------------------------------
#  Arguably, some functions defined here are quite big.
#  If you want to make this file smaller, these functions can
# be converted into scripts and removed from here.
# ============================================================
alias vi="vim"
##-------------------
## Personnal Aliases
##-------------------
alias ag="ag --page=less"
alias du="du -sh"
alias xcode='open *.xcworkspace'
alias server="python -m SimpleHTTPServer"
if [ -x /usr/local/bin/ipython ]; then
  alias ip="ipython"
fi
if [ -x /usr/local/bin/gls ]; then
  alias ls="gls --color=auto --group-directories-first"
fi
