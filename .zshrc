# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/scottsauber/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# git aliases
alias gdefault="git symbolic-ref refs/remotes/origin/HEAD | cut -d'/' -f4"
alias gas="git add -A && git status"
alias gs="git status"
alias grh="git reset HEAD~"
alias grhh="git reset HEAD --hard"
alias gc="git commit -m"
alias gco="git checkout"
alias gnewbr="gcopm && git checkout -b"
alias gpr="git pull -r && git --no-pager log -15 --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)[%an]%Creset' --abbrev-commit"
alias gpo="git push -u origin HEAD"
alias gac="gas && git commit -m"
alias gca="git commit --amend --no-edit"
alias gac="gas && gc"
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gsu="git stash -u"
alias gsp="git stash pop"

# delete all branches other than default branch (main or another name)
function gdelbr() {
    main_branch=`gdefault`
    gco $main_branch && git branch | grep -v $main_branch | xargs git branch -D
}

# checkout and pull with rebase on default branch (main or another name)
function gcopm() {
    main_branch=`git symbolic-ref refs/remotes/origin/HEAD | cut -d'/' -f4`
    gco $main_branch && gpr
}

# stash, checkout and pull default branch, create a new branch and then pop stash.  useful for when you were running on default branch, made changes, and forgot to create a branch first
function gstnewbr() {
    git stash -u && git copm && git checkout -b "$1" && git stash pop
}

# add, status, commit, pull and rebase, and push.  useful for trunk based dev, albeit you should probs be running verify before pushing
function gcpp() {
    gas && gc "$1" && gpr && gpo
}

# add, status, commit, push.  useful for PR's
function gcp() {
    gas && gc "$1" && gpo
}


# add, status, commit, push, and create a pr
function gcpr() {
    gcp "$1" && pr
}

# create new PR and open it
function pr() {
  github_url=`git remote -v | awk '/fetch/{print $2}' | sed -Ee 's#(git@|git://)#https://#' -e 's@cloud:@cloud/@' -e 's@com:@com/@'  -e 's%\.git$%%' | awk '/github/'`;
  branch_name=`git symbolic-ref HEAD | cut -d"/" -f 3,4`;
  main_branch=`gdefault`
  open_or_start='open'
  uname=$(uname)
  if [[ "$uname" == CYGWIN* || "$uname" == MINGW* ]] ; then
	open_or_start='start'
  fi
  pr_url=$github_url"/compare/$main_branch..."$branch_name
  $open_or_start $pr_url
}


# general aliases
alias reload="source ~/.zshrc"
alias zshrc="code ~/.zshrc"

# docker aliases
alias dkill="docker rm -f $(docker ps -a -q) && docker network prune"
alias dps="docker ps"
alias dpsa="docker ps -a"
alias dcd="docker-compose down"
alias dcu="docker-compose up"
alias dcreset="dcd && dcu"

#k8s aliases
alias k='kubectl'
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
