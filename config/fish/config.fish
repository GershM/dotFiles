set -e fish_user_paths
set -U fish_user_paths /opt/homebrew/bin /opt/homebrew/opt/llvm/bin $HOME/.bin  $HOME/.local/bin /usr/local/bin/ $HOME/Applications /var/lib/flatpak/exports/bin/ $fish_user_paths  /opt/homebrew/opt/mysql-client/bin $GOPATH/bin

set -g -x OPENAI_API_KEY ""
set -x SHELL "/opt/homebrew/bin/fish"
set -x NODE_OPTIONS "--openssl-legacy-provider"
set -x FZF_DEFAULT_OPTS '--height 40% --layout=reverse --border'

set -Ux PYENV_ROOT $HOME/.pyenv
fish_add_path $PYENV_ROOT/bin

function fish_user_key_bindings
  # fish_default_key_bindings
  fish_vi_key_bindings
end

function fish_mode_prompt
  switch $fish_bind_mode
    case default
      set_color --bold red
      echo 'N'
    case insert
      set_color --bold green
      echo 'I'
    case replace_one
      set_color --bold green
      echo 'R'
    case visual
      set_color --bold brmagenta
      echo 'V'
    case '*'
      set_color --bold red
      echo '?'
  end
  set_color normal
end

### EXPORT ###
set fish_greeting                                 # Supresses fish's intro message
set TERM "xterm-256color"                         # Sets the terminal type
set EDITOR "nvim"
set VISUAL "nvim"

### AUTOCOMPLETE AND HIGHLIGHT COLORS ###
set fish_color_normal brcyan
set fish_color_autosuggestion '#7d7d7d'
set fish_color_command brcyan
set fish_color_error '#ff6c6b'
set fish_color_param brcyan

### SPARK ###
set -g spark_version 1.0.0

complete -xc spark -n __fish_use_subcommand -a --help -d "Show usage help"
complete -xc spark -n __fish_use_subcommand -a --version -d "$spark_version"
complete -xc spark -n __fish_use_subcommand -a --min -d "Minimum range value"
complete -xc spark -n __fish_use_subcommand -a --max -d "Maximum range value"


### ALIASES ###
# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# vim and emacs
alias vim='nvim'
alias gvim='nvim --listen ~/.cache/nvim/godot.pipe .'

# elkCli
# alias elkcli="python3.10 /Users/gershmirson/myProjects/elkcli/elkcli"

alias brew="env PATH=(string replace (pyenv root)/shims '' \"\$PATH\") brew"

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias ls="eza"

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

alias projects='find ~/projects -name ".git" -type d  -exec dirname {} \; | fzf | read -l dir; and cd $dir'
alias myProjects='find ~/myProjects -name ".git" -type d  -exec dirname {} \; | fzf | read -l dir; and cd $dir'

alias omc='cat ~/.omclogin | fzf | read -d " " -l group  name ip user; and omclogin $group $name'
alias historyExec='history | fzf| read -l h; and fish -c $h'

starship init fish | source

source $HOME/.docker/init-fish.sh || true # Added by Docker Desktop

source /Users/gershmirson/.docker/init-fish.sh || true # Added by Docker Desktop
