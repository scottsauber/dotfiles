# git aliases
alias gas="git add -A && git status"
alias gs="git status"
alias grh="git reset HEAD~"
alias grhh="git reset HEAD --hard"
alias gc="git commit -m"
alias gco="git checkout"
alias gdelbr="gco master && git branch | grep -v master | xargs git branch -D"
alias gcopm="gco master && gpr"
alias gnewbr="gcopm && git checkout -b"
alias gpr="git pull -r && git log -15 --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)[%an]%Creset' --abbrev-commit"
alias gpo="git push -u origin HEAD"
alias gac="gas && git commit -m"
alias gca="git commit --amend --no-edit"
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gsu="git stash -u"
alias gsp="git stash pop"

function gstnewbr() {
    git stash -u && git copm && git checkout -b "$1" && git stash pop
}

function gcp() {
    gas && git commit -m "$1" && gpr && gpo
}

# general aliases
alias reload="source ~/.bashrc"

# docker aliases
alias dkill="docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q) && docker network prune"
alias dps="docker ps"
alias dpsa="docker ps -a"

#k8s aliases
alias k='kubectl'
