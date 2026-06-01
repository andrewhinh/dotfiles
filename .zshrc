[[ -f ~/.profile ]] && source ~/.profile

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="agnoster"
zstyle ':omz:update' mode auto

plugins=(
  git
  python
  thefuck
  zsh-autosuggestions
  zsh-syntax-highlighting
)

[[ -f "$ZSH/oh-my-zsh.sh" ]] && source "$ZSH/oh-my-zsh.sh"

_fzf_prefix="$(brew --prefix fzf 2>/dev/null)"
if [[ -n "$_fzf_prefix" && -f "$_fzf_prefix/shell/key-bindings.zsh" ]]; then
  source "$_fzf_prefix/shell/key-bindings.zsh"
  source "$_fzf_prefix/shell/completion.zsh"
elif [[ -f ~/.fzf.zsh ]]; then
  source ~/.fzf.zsh
fi
unset _fzf_prefix

command -v fnm >/dev/null && eval "$(fnm env --use-on-cd)"
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"

needs() {
  local bin=$1
  shift
  command -v "$bin" >/dev/null 2>&1 || {
    echo "need $bin — $*" >&2
    return 1
  }
}

alias mv="mv -iv"
alias cp="cp -iv"
alias lsd="ls -ltr"
alias json_pretty='pbpaste | python3 -m json.tool | pbcopy'
alias zs="source ~/.zshrc"
alias zshrc="vi ~/.zshrc"
alias gclone="git clone --depth 1 "
alias gpom="git push origin main"
alias gpo="git push origin "
alias gset="git remote set-url"
alias gs="git status"
alias gadmit="git add . && git commit -m"
alias gc="git checkout"
alias gcb="git checkout -b "
alias gupdatefork='git fetch upstream && git checkout main && git rebase upstream/main'
alias gcm="git checkout main 2> /dev/null || git checkout master"
command -v trash >/dev/null && alias rm=trash
alias fucking=sudo
alias gl="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
alias glr='gl -n 7'
alias ytdlp='yt-dlp -f "bestvideo[ext=mp4][height<=720]+bestaudio[ext=m4a]/best[ext=mp4]/best" '
alias gitsum='git log --pretty=format:"* %s" --author "$(git config user.email)"'

_git_default_branch() {
  local b=main
  if git symbolic-ref refs/remotes/origin/HEAD &>/dev/null; then
    b=$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')
  elif git show-ref --verify --quiet refs/heads/main; then
    b=main
  elif git show-ref --verify --quiet refs/heads/master; then
    b=master
  fi
  echo "$b"
}

git-clean-merged() {
  local b branches
  b=$(_git_default_branch)
  branches=$(git branch --merged "$b" | grep -vE "^\*|\s${b}$|\smain$|\smaster$")
  [[ -z "$branches" ]] || print -l ${(f)branches} | xargs git branch -d
}

git-clean-remote-merged() {
  local b branches
  b=$(_git_default_branch)
  b=${b:-main}
  branches=$(git branch -r --merged "origin/$b" | grep -vE "origin/(${b}|main|master|HEAD)" | sed 's#^[[:space:]]*origin/##')
  [[ -z "$branches" ]] || print -l ${(f)branches} | xargs -n 1 git push --delete origin
}

function mkcdir () {
    mkdir -p -- "$1" &&
      cd -P -- "$1"
}

function t() {
  needs tree "brew install tree" || return 1
  local depth=3 dir="."
  if [[ "$1" =~ ^[0-9]+$ ]]; then
    depth=$1
    shift
  fi
  [[ -n "$1" ]] && dir=$1
  tree -I '.git|node_modules|bower_components|.DS_Store' --dirsfirst --filelimit 15 -L "$depth" -aC "$dir"
}

bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey "^[[3~" delete-char
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

prompt_context() {}

command -v atuin >/dev/null && eval "$(atuin init zsh)"
