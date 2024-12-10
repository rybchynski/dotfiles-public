# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export PATH="$PATH:$HOME/.composer/vendor/bin"
export PATH="$PATH:$HOME/.drupal/drupal_code_standards/vendor/bin"
export PATH="$PATH:$HOME/.yarn/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.nvm/versions/node/v20.12.2/lib/node_modules"
export CDPATH="$PATH:$HOME/Documents/code/"
export TERM="xterm-256color"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# Add my scripts folder to the PATH
export PATH="$PATH:$(du "$HOME/.scripts" | cut -f2 | tr '\n' ':' | sed 's/:*$//')"

# Golang specific
export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin
export GOPATH=$HOME/golib
export PATH=$PATH:$GOPATH/bin
export GOPATH=$GOPATH:$HOME/Documents/code/go

# ZSH_THEME="powerlevel9k/powerlevel9k"
# ZSH_THEME="agnoster"
ZSH_THEME="robbyrussell"
# ZSH_THEME="pygmalion-virtualenv"
# ZSH_THEME="bira"
 # ZSH_THEME="awesomepanda"
# ZSH_THEME="shellder"


DISABLE_MAGIC_FUNCTIONS=true

plugins=(
  colored-man-pages
  zsh-autosuggestions
  zsh-syntax-highlighting
  virtualenv
)

source $ZSH/oh-my-zsh.sh
source $HOME/.zsh_aliases

# the way to extract files
extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2) tar xvjf $1   ;;
      *.tar.gz)  tar xvzf $1   ;;
      *.tar.xz)  tar xvfJ $1   ;;
      *.bz2)     bunzip2 $1    ;;
      *.rar)     unrar x $1    ;;
      *.gz)      gunzip $1     ;;
      *.tar)     tar xvf $1    ;;
      *.tbz2)    tar xvjf $1   ;;
      *.tgz)     tar xvzf $1   ;;
      *.zip)     unzip $1      ;;
      *.Z)       uncompress $1 ;;
      *.7z)      7z x $1       ;;
      *)         echo "'$1' cannot be extracted via >extract<" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

export EDITOR='nvim'

###-tns-completion-start-###
if [ -f $HOME/.tnsrc ]; then 
    source $HOME/.tnsrc 
fi
###-tns-completion-end-###

# Hide user-hostname for agnoster theme
prompt_context() {
  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    # prompt_segment black default "%(!.%{%F{yellow}%}.)$USER"
    # prompt_segment black default "%(!.%{%F{yellow}%}.)💀"
    prompt_segment black default "%(!.%{%F{yellow}%}.)YR"
  fi
}

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

_fzf_compgen_path() {
  fd --hidden --exclude .tig . "$1"
}

_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .tig . "$1"
}

source ~/.fzf-git.sh/fzf-git.sh


# print my IP address
function myip()
{
    extIp=$(dig +short myip.opendns.com @resolver1.opendns.com)

    printf "Wireless IP: "
    MY_IP=$(/sbin/ifconfig wlp0s20f3 | awk '/inet/ { print $2 } ' |
      sed -e s/addr://)
    echo ${MY_IP:-"Not connected"}


    printf "Wired IP: "
    MY_IP=$(/sbin/ifconfig lo | awk '/inet/ { print $2 } ' |
      sed -e s/addr://)
    echo ${MY_IP:-"Not connected"}

    echo ""
    echo "WAN IP: $extIp"
}

# open docker container's bash 
d:bash () {
  if [ $# != 1 ]; then
    docker exec -it `d:last` bash
  else
    docker exec -it $1 bash
  fi
}

# WORK WITH GIT.
# git blame -- custom function.
gblame () {
  git log \
    --reverse \
    --color=always \
    --format="%C(cyan)%h %C(blue)%ar%C(auto)%d %C(yellow)%s%+b %C(black)%ae" "$@" |
    fzf -i -e +s \
      --reverse \
      --tiebreak=index \
      --no-multi \
      --ansi \
      --preview="echo {} |
                  grep -o '[a-f0-9]\{7\} |
                  head -1 |
                  xargs -I % sh -c 'git show --color=always % |
                  diff-so-fancy'" \
      --header "enter: view, C-c: copy hash" \
      --bind "enter:execute:$_viewGitLogLine | less -R" \
      --bind "ctrl-c:execute:#_gitLogLineToHash |
               xclip -r -selection clipboard" 
}

# fshow - git commit browser
fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

# fcoc - checkout git commit
fcoc() {
  local commits commit
  commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf --tac +s +m -e) &&
  git checkout $(echo "$commit" | sed "s/ .*//")
}

# fcs - get git commit sha
# example usage: git rebase -i `fcs`
fcs() {
  local commits commit
  commits=$(git log --color=always --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf --tac +s +m -e --ansi --reverse) &&
  echo -n $(echo "$commit" | sed "s/ .*//") | pbcopy
}

# yazi
function yy() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    cd -- "$cwd"
  fi 
  rm -f -- "$tmp"
}

function zshow() {
  echo '--------------------------------------------'
  echo 'yy      -- run yazi file manager'
  echo 'myip    -- display my IP information'
  echo 'd:bash  -- exec to the docker bash container'
  echo 'gblame  -- git blame in terminal'
  echo 'fshow   -- git commit browser'
  echo 'fcoc    -- checkout to git commit'
  echo 'fcs     -- select and copy git commit hash'
  echo '--------------------------------------------'
  
}

source $HOME/.fzf_aliases

[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh
source $HOME/.fzf/shell/key-bindings.zsh

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


xkbcomp $HOME/.config/xkb/config $DISPLAY && clear

# add rofi scripts to the PATH:
export PATH=$HOME/.config/rofi/scripts:$PATH

# pnpm
export PNPM_HOME="~/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

# export VOLTA_HOME="$HOME/.volta"
# export PATH="$VOLTA_HOME/bin:$PATH"
eval "$(oh-my-posh init zsh --config '~/.oh-my-posh/aliens.omp.json')"
eval "$(zoxide init zsh)"


# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
