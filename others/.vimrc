" solarized theme enable
syntax enable
let g:solarized_termcolors = 256
" set term=xterm-256color
" set background=light
" colorscheme solarized
" colorscheme desert

" tmux will only forward escape sequences to the terminal if surrounded by a DCS sequence
if exists('$TMUX')
        " set insert mode to a cyan vertical line
        let &t_SI .= "\<esc>Ptmux;\<esc>\<esc>[2 q\<esc>\\"
        let &t_SI .= "\<esc>Ptmux;\<esc>\<esc>]12;cyan\x7\<esc>\\"

        " set normal mode to a green block
        let &t_EI .= "\<esc>Ptmux;\<esc>\<esc>[2 q\<esc>\\"
        let &t_EI .= "\<esc>Ptmux;\<esc>\<esc>]12;green\x7\<esc>\\"

        " set replace mode to an orange underscore
        let &t_SR .= "\<esc>Ptmux;\<esc>\<esc>[4 q\<esc>\\"
        let &t_SR .= "\<esc>Ptmux;\<esc>\<esc>]12;orange\x7\<esc>\\"

        " initialize cursor shape/color on startup (silent !echo approach doesn't seem to work for tmux)
        augroup ResetCursorShape
                au!
                "autocmd VimEnter * startinsert | stopinsert
                autocmd VimEnter * normal! :startinsert :stopinsert
                "autocmd VimEnter * :normal :startinsert :stopinsert
        augroup END

        " reset cursor when leaving tmux
        autocmd VimLeave * silent !echo -ne "\033Ptmux;\033\033[2 q\033\\"
        autocmd VimLeave * silent !echo -ne "\033Ptmux;\033\033]12;gray\007\033\\"
endif

if &term =~ '^xterm\\|rxvt'
        " solid underscore
        let &t_SI .= "\<Esc>[4 q"
        " solid block
        let &t_EI .= "\<Esc>[2 q"
        " 1 or 0 -> blinking block
        " 3 -> blinking underscore
        " Recent versions of xterm (282 or above) also support
        " 5 -> blinking vertical bar
        " 6 -> solid vertical bar
endif

" filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

Bundle 'skalnik/vim-vroom'

" In some systems the trees arrow doesn't work properly, uncomment below
" let g:NERDTreeDirArrowExpandable = '>'
" let g:NERDTreeDirArrowCollapsible = 'v'

if &term =~ '^screen'
        " tmux will send xterm-style keys when its xterm-keys option is on
        execute "set <xUp>=\e[1;*A"
        execute "set <xDown>=\e[1;*B"
        execute "set <xRight>=\e[1;*C"
        execute "set <xLeft>=\e[1;*D"
endif

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'christoomey/vim-tmux-navigator'

" Add YCM repository to plugin list
Plugin 'ycm-core/YouCompleteMe'

Plugin 'tpope/vim-dispatch'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'

" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'

" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'

" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

Plugin 'sainnhe/edge'

" Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required

let g:edge_style = 'aura'
let g:edge_enable_italic = 0
let g:edge_disable_italic_comment = 1
if has('termguicolors')
    set termguicolors
endif
set guifont=Hack\ 11
set background=dark
colorscheme edge

" filetype plugin indent on    " required

" let g:ycm_server_keep_logfiles = 1
" let g:ycm_server_log_level = 'debug'

" Mapping to close the completion menu (default <C-y>)
let g:ycm_key_list_stop_completion = ['<C-x>']

" Set filetypes where YCM will be turned on
let g:ycm_filetype_whitelist = { 'cpp':1, 'h':2, 'hpp':3, 'c':4, 'cxx':5 }

" Close preview window after completing the insertion
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1

let g:ycm_confirm_extra_conf = 0                 " Don't confirm python conf
let g:ycm_always_populate_location_list = 1      " Always populae diagnostics list
let g:ycm_enable_diagnostic_signs = 1            " Enable line highligting diagnostics
let g:ycm_open_loclist_on_ycm_diags = 1          " Open location list to view diagnostics

let g:ycm_max_num_candidates = 20                " Max number of completion suggestions
let g:ycm_max_num_identifier_candidates = 10     " Max number of identifier-based suggestions
let g:ycm_auto_trigger = 1                       " Enable completion menu
let g:ycm_show_diagnostic_ui = 1                 " Show diagnostic display features
let g:ycm_error_symbol = '>>'                    " The error symbol in Vim gutter
let g:ycm_enable_diagnostic_signs = 1            " Display icons in Vim's gutter, error, warnings
let g:ycm_enable_diagnostic_highlighting = 1     " Highlight regions of diagnostic text
let g:ycm_echo_current_diagnostic = 1            " Echo line's diagnostic that cursor is on

" Make Vim always render the sign column:
set signcolumn=yes

" Open vim-dispatch window and scroll to bottom
nnoremap    <C-m>m    :Copen<CR> <bar> G" Build debug and release targets
nnoremap    <C-m>bd   :Dispatch! make -C build/Debug<CR>
nnoremap    <C-m>br   :Dispatch! make -C build/Release<CR>

" Map <F6> to the Debug executable with passed filename
function SetBinaryDebug(filename)
    let bpath = getcwd() . "/bin/Debug/" . a:filename
    execute "nnoremap <F6> :Dispatch "
            \ bpath
            \ . " <CR> <bar> :Copen<CR>"
    echo "<F6> will run: " . bpath
endfunction

" Map <F7> to the Release executable with passed filename
function SetBinaryRelease(filename)
    let bpath = getcwd() . "/bin/Release/" . a:filename
    execute "nnoremap <F7> :Dispatch "
                \ bpath
                \ . "<CR> <bar> :Copen<CR>"
    echo "<F7> will run: " . bpath
endfunction

" Make vim indent 2 spaces for ruby and scala files only
filetype plugin indent on
set sw=4
set ts=4
" :autocmd Filetype ruby set softtabstop=2
" :autocmd Filetype ruby set sw=2
" :autocmd Filetype ruby set ts=2

" :autocmd Filetype scala set softtabstop=2
" :autocmd Filetype scala set sw=2
" :autocmd Filetype scala set ts=2

:autocmd Filetype c set softtabstop=8
:autocmd Filetype c set sw=7
:autocmd Filetype c set ts=6

" To ignore plugin indent changes, instead use:
" filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" set number
set nocompatible      " We're running Vim, not Vi!
set magic
set smartindent
set autoindent

" syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
" filetype indent on    " Enable filetype-specific indenting
highlight Pmenu ctermbg=238 gui=bold
filetype plugin on    " Enable filetype-specific plugins
set completefunc=syntaxcomplete#Complete
autocmd VimEnter * NERDTree

autocmd VimEnter * wincmd p
execute pathogen#infect()
map <F9> :w<CR>:!ruby -c %<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd FileType ruby compiler ruby

autocmd VimEnter * if !argc() | NERDTree | endif
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" disable auto commenting
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
