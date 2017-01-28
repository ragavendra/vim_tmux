## vim_tmux
Repo to maintain my vim and tmux settings

### A. For vim
#### 1. Copy .vimrc and .tmux.conf files to ~ dir
`$cd ~ && git clone https://github.com/ragavendra/vim_tmux && cp vim_tmux/{.tmux.conf,.vimrc} .`

#### 2. Install vundle
`git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`

#### 3. Install pathogen
`mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim`

#### 4. Install vim plugins
`vim .vimrc`
`:PluginInstall`

### B. For tmux
#### 1. Install Plugin Manager
`$ git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`

#### 2.  Exit tmux and Reload TMUX environment with: 
`$ tmux source ~/.tmux.conf`


#### 3. Install plugins in the conf file
`$ tmux`
`Prefix [Ctrl + b] plus [Ctrl + I]`
