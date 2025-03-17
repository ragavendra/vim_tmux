" An example for a vimrc file.
" Former Maintainer:	Bram Moolenaar <Bram@vim.org>

" When started as "evim", evim.vim will already have done these settings, bail
" out.
if v:progname =~? "evim"
	finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
	set nobackup		  " do not keep a backup file, use versions instead
else
	set backup		  " keep a backup file (restore to previous version)
	if has('persistent_undo')
		set undofile	    " keep an undo file (undo changes after closing)
	endif
endif

if &t_Co > 2 || has("gui_running")
	" Switch on highlighting the last used search pattern.
	set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
	au!

	" For all text files set 'textwidth' to 78 characters.
	autocmd FileType text setlocal textwidth=78
augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
	packadd! matchit
endif

" end example

" set encoding=dark

" kernel specific starts - https://kernelnewbies.org/FirstKernelPatch
syntax on
set title

" kernel 8 char tab, standard and 80 char limit per line
" set tabstop=8
" set softtabstop=8
" set shiftwidth=8
" set noexpandtab
" kernel specific ends

" Make Vim always render the sign column:
set signcolumn=yes

" omnicpp complete
" set nocp

" c-x and c-p should give for or if Ultisnips
set omnifunc=syntaxcomplete#Complete

source ~/.vim/bundle/YouCompleteMe/lsp-examples/vimrc.generated

" replace var name in a file or proj
" For local replace
" nnoremap gr gd[{V%::s/<C-R>///gc<left><left><left>

" For global replace
" nnoremap gR gD:%s/<C-R>///gc<left><left><left>

" Make vim indent 2 spaces for ruby and scala files only
filetype plugin indent on
set sw=4
set ts=4

" enable mouse a or n
set mouse=a

" enable mouse in tmux
set ttymouse=xterm2

" set line number or relativenumber
set number

" Use :Man 3 echo to open man page in a window
:runtime! ftplugin/man.vim

" :Todo to search TODO comments or similar
command Todo noautocmd vimgrep /TODO\|FIXME/j ** | cw

" :noremap! <buffer> \b box<CR>

noremap ; o<ESC>
" noremap <C-;> O<ESC>

nnoremap <Leader>\ :noh<CR><esc>

noremap J :tabNext<CR>
noremap K :tabnext<CR>
noremap <Leader>f :YcmCompleter FixIt<CR>
nnoremap tb :TagbarToggle<CR>
nnoremap g^ :tabfirst<CR>
noremap g$ :tablast<CR>
noremap g0 :1tabnext<CR>

" rel nav
" noremap g-3 :-3tabnext<CR>

map <Leader>A  oanother line<Esc>
" let mapleader = ","
let maplocalleader = "."
" g:mapleader = ","
map <buffer> <LocalLeader>A  other line<Esc>

" close fold
map - :foldclose<cr>
map + :foldopen<cr>

" from git

" Close the current buffer
" map <leader>bd :Bclose<cr>:tabclose<cr>gT

" show buffers
map <leader>b :buffers<cr>

" show buffers
map <leader>t :tabs<cr>

" Close all the buffers
map <leader>ba :bufdo bd<cr>

" map <leader>l :bnext<cr>
" map <leader>h :bprevious<cr>

" get meaning
map <leader>d :Dict<cr>

" Useful mappings for managing tabs
" map <leader>tn :tabnew<cr>
" map tn :tabnew<cr>
" map to :tabonly<cr>
" map tc :tabclose<cr>
" map tm :tabmove
" map t<leader> :tabnext<cr>

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <leader>lt :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()


" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <C-r>=escape(expand("%:p:h"), " ")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>
" end from git

" set timeout for key combs
" set timeoutlen 2000

" disabling this as this is overwriting the tags file in base dir
" ctags auto update on file write
" Auto generate tags file on file write of *.c and *.h files
" autocmd BufWritePost *.c,*.h silent! !ctags . &

" include path as of this machine for ctags generation
" set path=.
set path+=/usr/include/**
set path+=/run/media/scion/PART2/repos/linux/include/**
" set tags+=/run/media/scion/PART2/repos/linux/tags


set path+=/usr/include/**
" java specific for YCM
" let g:syntastic_java_checkers = []
" let g:EclimFileTypeValidate = 0

" solarized theme enable
syntax enable
let g:solarized_termcolors = 256
" set term=xterm-256color
" set background=light
" set background=dark
" colorscheme solarized
" colorscheme desert
" colorscheme morning

" tmux will only forward escape sequences to the terminal if surrounded by a DCS sequence
if exists('$TMUX')
	" set insert mode to a cyan vertical line

	" set replace mode to an orange underscore

	" set end insert or normal mode to a green block

	" initialize cursor shape/color on startup (silent !echo approach doesn't seem to work for tmux)
	augroup ResetCursorShape
		au!
		"autocmd VimEnter * startinsert | stopinsert
		autocmd VimEnter * normal! :startinsert :stopinsert
		"autocmd VimEnter * :normal :startinsert :stopinsert
	augroup END

	" reset cursor when leaving tmux
	" autocmd VimLeave * silent !echo -ne "\033Ptmux;\033\033[2 q\033\\"
	" autocmd VimLeave * silent !echo -ne "\033Ptmux;\033\033]12;gray\007\033\\"
endif

if &term =~ '^xterm\\|rxvt'
	let &t_SI .= "\<Esc>[2 q"
	let &t_EI .= "\<Esc>[2 q"
endif

" filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

" Bundle 'skalnik/vim-vroom'

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
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'ycm-core/YouCompleteMe'
" autocmd FileType javascript nmap <buffer> <C-]> :YcmCompleter GoTo<CR>
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-fugitive'
Plugin 'L9'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'sainnhe/edge'
Plugin 'preservim/tagbar'

" Track the engine.
Plugin 'SirVer/ultisnips'

" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'

Plugin 'szw/vim-dict'

" Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required

" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger="<CR>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"


let g:edge_style = 'aura'
let g:edge_enable_italic = 0
let g:edge_disable_italic_comment = 1
if has('termguicolors')
	set termguicolors
endif
" set guifont=Hack\ 11
" set background=dark
" colorscheme edge

" Ycm specific
" let g:ycm_server_keep_logfiles = 1
" let g:ycm_server_log_level = 'debug'

" Mapping to close the completion menu (default <C-y>)
let g:ycm_key_list_stop_completion = ['<C-x>']

" Set filetypes where YCM will be turned on
" let g:ycm_filetype_whitelist = { 'cpp':1, 'h':2, 'hpp':3, 'c':4, 'cxx':5 }

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

" clang specific
let g:ycm_clangd_uses_ycmd_caching=0 
let g:ycm_clangd_binary_path='/usr/bin/clangd'

" ts specific
" let g:ycm_tsserver_binary_path='~/.vim/bundle/YouCompleteMe/third_party/ycmd/third_party/tsserver'

let g:ycm_filepath_blacklist = {'*': 1}
let g:ycm_semantic_triggers = {
    \   'css': [ 're!^', 're!^\s+', ': ' ],
    \   'scss': [ 're!^', 're!^\s+', ': ' ],
    \ }

" vue specific
let g:ycm_language_server = [ {
    \ 'name': 'vue',
    \ 'filetypes': [ 'vue' ],
    \ 'cmdline': [ 'vls'  ]
    \ } ]

" set nocompatible      " We're running Vim, not Vi!
set magic
set smartindent
set autoindent

" syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
" filetype indent on    " Enable filetype-specific indenting
highlight Pmenu ctermbg=238 gui=bold
filetype plugin on    " Enable filetype-specific plugins
set completefunc=syntaxcomplete#Complete
" autocmd VimEnter * NERDTree

autocmd VimEnter * wincmd p
execute pathogen#infect()
" map <F9> :w<CR>:!ruby -c %<CR>
autocmd StdinReadPre * let s:std_in=1
" autocmd FileType ruby compiler ruby

autocmd VimEnter * if !argc() | NERDTree | endif
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-n> :NERDTreeToggle<CR><C-w>r
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" disable auto commenting
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
