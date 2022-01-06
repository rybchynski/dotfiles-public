# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export PATH="$(brew --prefix)/bin:$PATH"
export PATH="$PATH:$HOME/.composer/vendor/bin"
export PATH="$PATH:$HOME/.drupal/drupal_code_standards/vendor/bin"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:$HOME/.yarn/bin"
export PATH="$PATH:$HOME/Documents/code/bash/bin"
export PATH="/usr/local/Cellar/openvpn/2.5.0/sbin:$PATH"
export GOPATH=$HOME/Documents/code/go
export GOROOT=/usr/local/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
export CDPATH="$PATH:$HOME/Documents/code/"
export TERM="xterm-256color"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# nvm
export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Add my scripts folder to the PATH
export PATH="$PATH:$(du "$HOME/.scripts" | cut -f2 | tr '\n' ':' | sed 's/:*$//')"


# ZSH_THEME="powerlevel9k/powerlevel9k"
ZSH_THEME="agnoster"
# ZSH_THEME="robbyrussell"
# ZSH_THEME="pygmalion-virtualenv"
# ZSH_THEME="bira"
# ZSH_THEME="awesomepanda"

# jreese, frisk, amuse, agnoster, af-magic, avit, robbyrussell, juanghurtado, norm, bullet-train
# bira, gnzh, powerlevel9k/powerlevel9k

DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  colored-man-pages
  zsh-autosuggestions
  zsh-syntax-highlighting
  virtualenv
  z
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

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

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

# fzf configuration.
# --prompt='∼ ' --pointer='▶' --marker='✓'
# --color='hl:148,hl+:154,pointer:032,marker:010,bg+:237,gutter:008'
export FZF_DEFAULT_OPTS="
--layout=reverse
--info=inline
--height=50%
--multi
--border
--preview-window=:hidden
--preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'
--color='hl:148,hl+:154,pointer:032,marker:010,bg+:237,gutter:008'
--prompt='∼ ' --pointer='▶' --marker='✓'
--bind '?:toggle-preview'
--bind 'ctrl-a:select-all'
--bind 'ctrl-y:execute-silent(echo {+} | pbcopy)'
--bind 'ctrl-e:execute(echo {+} | xargs -o vim)'
--bind 'ctrl-v:execute(code {+})'
--bind 'ctrl-s:execute(subl {+})'
"

# go to the current directory opened in Finder
function cdf() {
    target=`osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)'`
    if [ "$target" != "" ]; then
        cd "$target"; pwd
    else
        echo 'No Finder window found' >&2
    fi
}

# print my IP address
function myip()
{
    extIp=$(dig +short myip.opendns.com @resolver1.opendns.com)

    printf "Wireless IP: "
    MY_IP=$(/sbin/ifconfig wlp4s0 | awk '/inet/ { print $2 } ' |
      sed -e s/addr://)
    echo ${MY_IP:-"Not connected"}


    printf "Wired IP: "
    MY_IP=$(/sbin/ifconfig enp0s25 | awk '/inet/ { print $2 } ' |
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

# With no argument runs a bash terminal in a new ubuntu container(could be specified any image) with current directory content mapped to '/app' inside container. If an image is passed to the first argument this one will run. If multiples arguments append to the image.
d:run () {
  if [ $# == 0 ]; then
    docker run -it -v `pwd`:/app -w /app --rm buildpack-deps:trusty bash
  elif [ $# == 1 ]; then
    docker run -it -v `pwd`:/app -w /app --rm $1 
  else
    docker run -it -v `pwd`:/app -w /app --rm $1 ${@:2}
  fi
}

source $HOME/.fzf_aliases

[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh

