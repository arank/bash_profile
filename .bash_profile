# Git branch in prompt.

parse_git_branch() {

    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'

}

export PS1="\u@\h \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "

# functions
# Will return the current branch name
function current_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo ${ref#refs/heads/}
}

function current_repository() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo $(git remote -v | cut -d':' -f 2)
}

alias st="sbt clean;sbt compile;sbt test"
alias sb="sbt compile"
alias idea="rm -rf .idea;rm -rf .idea_modules/;sbt gen-idea;open -a /Applications/IntelliJ\ IDEA\ 13.app/ ."

alias edit="nano ~/.bash_profile;source ~/.bash_profile"
alias gc="git checkout"
alias gs="git status"
alias gg="git grep"
alias gd="git diff"
alias gr="git rebase -i master"
alias todo="gg TODO"

## Show hidden files ##
alias l.='ls -d .*'
alias la='ls -a'

## get rid of command not found ##
alias cd..='cd ..'
 
## a quick way to get out of current directory ##
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'

alias update='BRANCH=$(current_branch);git checkout master;git pull;git checkout $BRANCH'
alias submit='update;git rebase -i master;git push origin $BRANCH --force' 
alias save='git push origin $(current_branch)'
