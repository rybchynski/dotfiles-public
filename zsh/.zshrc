# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export PATH="$PATH:$HOME/.composer/vendor/bin"
export PATH="$PATH:$HOME/.drupal/drupal_code_standards/vendor/bin"
export PATH="$PATH:$HOME/.yarn/bin"
export PATH="$PATH:$HOME/.local/bin"
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

export GOPATH=/home/ryba/golib
export PATH=$PATH:$GOPATH/bin
export GOPATH=$GOPATH:/home/ryba/Documents/code/go

# ZSH_THEME="powerlevel9k/powerlevel9k"
ZSH_THEME="agnoster"
# ZSH_THEME="robbyrussell"
# ZSH_THEME="pygmalion-virtualenv"
# ZSH_THEME="bira"
 # ZSH_THEME="awesomepanda"
# ZSH_THEME="shellder"



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
--color='hl:148,hl+:154,pointer:032,marker:010,bg+:237,gutter:008'
--prompt='∼ ' --pointer='▶' --marker='✓'
--bind '?:toggle-preview'
--bind 'ctrl-a:select-all'
--bind 'ctrl-c:execute-silent(echo {+} | xclip -selection clipboard)'
--bind 'ctrl-e:execute(echo {+} | xargs -o vim)'
--bind 'ctrl-v:execute(code {+})'
--bind 'ctrl-s:execute(subl {+})'
"

# export FZF_DEFAULT_OPTS="--preview 'bat --color=always {}'"

# print my IP address
function myip()
{
    extIp=$(dig +short myip.opendns.com @resolver1.opendns.com)

    printf "Wireless IP: "
    MY_IP=$(/sbin/ifconfig wlp41s0 | awk '/inet/ { print $2 } ' |
      sed -e s/addr://)
    echo ${MY_IP:-"Not connected"}


    printf "Wired IP: "
    MY_IP=$(/sbin/ifconfig enp42s0 | awk '/inet/ { print $2 } ' |
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
  echo -n $(echo "$commit" | sed "s/ .*//")
}

source $HOME/.fzf_aliases

[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh
source $HOME/.fzf/shell/key-bindings.zsh

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


xkbcomp $HOME/.config/xkb/config $DISPLAY && clear

# pnpm
export PNPM_HOME="~/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end
