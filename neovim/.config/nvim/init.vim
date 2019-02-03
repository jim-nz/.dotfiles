" Plugins {{{

" Auto-install plug for new deploys
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

Plug 'panickbr/neovim-ranger' " Use ranger for file browsing
Plug 'zivyangll/git-blame.vim' " Show git blame info
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' } " LSP client
Plug 'AndrewRadev/ember_tools.vim' " Tools for EmberJS
Plug 'chriskempson/base16-vim' " Coding colour schemes
Plug 'sheerun/vim-polyglot' " One stop syntax highlighting
Plug 'ericpruitt/tmux.vim' " Tmux config syntax highlighting
Plug 'Shougo/echodoc.vim' " Function signature in command line
Plug 'editorconfig/editorconfig-vim' " Pick up any editor config files
Plug 'junegunn/vim-peekaboo' " Preview yanks when pasting
Plug 'itchyny/lightline.vim' " Status bar and themes
Plug 'airblade/vim-gitgutter' " Git markers in the gutter
Plug 'tpope/vim-unimpaired' " Useful macros using [ and ]
Plug 'tpope/vim-repeat' " Use . repeat for tpope plugins
Plug 'tpope/vim-commentary' " Quick commenting
Plug 'tpope/vim-surround' " Change surroundings
Plug 'Lokaltog/vim-easymotion' " Move through vim
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' } " Undo tree
Plug 'jiangmiao/auto-pairs' " Auto close brackets
Plug 'junegunn/fzf', { 'dir': '~/.local/lib/fzf', 'do': './install --all' } | Plug 'junegunn/fzf.vim' " Fuzzy find
Plug 'w0rp/ale' " Multi-language linting
Plug 'ap/vim-css-color', { 'for': ['css', 'less', 'sass', 'scss'] } " CSS colour of hex values
Plug 'HerringtonDarkholme/yats.vim' " JS and TS syntax highlighting
Plug 'heavenshell/vim-jsdoc' " JS and TS doc
Plug 'tpope/vim-obsession' | Plug 'dhruvasagar/vim-prosession' " Session restore

call plug#end()

"}}}
"  General {{{

set confirm " Save changed files prompt
set ffs=unix,dos,mac " Use Unix as the standard file type
set hidden " Allow background buffers without writing
set ignorecase smartcase nohlsearch " Search - ignore case, unless capital typed, don't highlight
"set iskeyword-=_ " Treat extra characters as word break for movements
set lazyredraw " Don't redraw while executing macros (good performance config)
set magic " For regular expressions turn magic on
set nobackup noswapfile " No backup or swap files
set noerrorbells novisualbell tm=500 " No sound or flash on errors
set number " Display line numbers
set showmatch " Show matching brackets when text indicator is over them
set noshowmode " Mode already displayed in plugins
set so=999 " Scrolloff - keep cursor centred
set splitbelow splitright " Window split direction
set undofile " Persistent undo
set synmaxcol=500
set completeopt+=noinsert " Wait for manual insertion of completion candidate
set pumheight=20 " Limit omnicomplete to 20 visible items
set shortmess+=c " Hide 'match x of y' messages in deoplete
set sessionoptions+=tabpages,globals " Save tab names in sessions

" Indentation
set tabstop=4 " Width of existing tabs to display on file open
set shiftwidth=4 " Width of new indentation
set expandtab " New indentation with spaces, not tabs
set shiftround " Within text, indent is calculated from col 1, not from cursor position
set softtabstop=-1 " Within text, backspace removes same number of spaces as shiftwidth
set list listchars=tab:┊\ ,nbsp:.,precedes:«,extends:» " Set various symbols
set linebreak showbreak=↪\  " Symbol for line breaks

"  Filetype specific
autocmd FileType vim setlocal foldmethod=marker
autocmd FileType html,markdown,xhtml,ss.html setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType css,scss,sass,less setlocal omnifunc=csscomplete#CompleteCSS foldmethod=indent
autocmd FileType javascript,typescript setlocal omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType javascript setlocal omnifunc=tern#Complete
autocmd FileType yaml,python setlocal expandtab shiftwidth=2 tabstop=2

" Colours and fonts
set termguicolors " 24 bit colour
syntax enable " Enable syntax highlighting
set background=dark
set colorcolumn=80,120 " Highlight columns for target max length
colorscheme base16-tomorrow-night
highlight ColorColumn guibg=#222222 " colorcolumn

" }}}
" Built-in extensions {{{

" Netrw
let g:netrw_banner=0 " Netrw banner info off
let g:netrw_liststyle=3 " Netrw default to tree
let g:netrw_keepdir = 1 " Netrw don't cd to current browsed dir

" Wildmenu
set wildmode=list:longest " WiLd menu with shell-style completion
" Ignore files
set wildignore+=*/node_modules/*,*bower_components/* " MacOSX/Linux
set wildignore+=*\\node_modules\\*,*\\bower_components\\* " Windows
set wildignore+=*.zip,*.exe,*.ini,*.db,*.ics,*.db,*.ics
set wildignore+=*.eot,*.ttf,*.woff,*.ico
set wildignore+=*.jpg,*.jpeg,*.JPG,*.png,*.gif,*.tiff,*.eps,*.psd
set wildignore+=*.pdf,*.doc,*.docx,*.DOCX,*.ppt,*.xls

" Macros
runtime macros/matchit.vim "Enable extended % matching

" }}}
" Plugin settings {{{

" ALE
let g:ale_fixers = {
            \   'javascript': ['eslint'],
            \   'php': ['phpcbf'],
            \}
let g:ale_sign_error = '⚠'
let g:ale_sign_warning = '⚠'
let g:ale_sign_info = '🛈'
let g:ale_completion_enabled = 1
let g:ale_javascript_flow_executable = 'flow-language-server --stdio'

" Auto pairs
let g:AutoPairsMultilineClose = 0

" EchoDoc
let g:echodoc#enable_at_startup = 1

" Editorconfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" GitGutter
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = 'δ'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_modified_removed = '±'
let g:gitgutter_override_sign_column_highlight = 0
highlight GitGutterAdd guifg = #b5bd68
highlight GitGutterChange guifg = #81a2be
highlight GitGutterDelete guifg = #cc6666
highlight GitGutterChangeDelete guifg = #b294bb

" Indent guides
let g:indent_guides_enable_on_vim_startup = 1

" JSDoc
let g:jsdoc_enable_es6 = 1
let g:jsdoc_input_description = 1

" Peekaboo
let g:peekaboo_window = 'vert bo 50new'

" FZF
let g:fzf_layout = { 'down': '~33%' }
let g:fzf_buffers_jump = 1 " Jump to open buffer if matched
let g:fzf_action = {
            \ 'alt-t': 'tab split',
            \ 'alt-x': 'split',
            \ 'alt-v': 'vsplit' }

" Lightline
let g:lightline = {
            \ 'colorscheme': 'Tomorrow_Night',
            \ 'active': {
            \   'left': [
            \      [ 'filedetail' ],
            \      [ 'percent' ],
            \   ],
            \   'right': [
            \      [ 'fugitive' ],
            \      [ 'mode', 'paste' ],
            \      [ 'obsession' ]
            \   ]
            \ },
            \ 'inactive': {
            \   'left': [
            \      [ 'filedetail' ]
            \   ],
            \   'right': [
            \      [ 'fugitive' ]
            \   ]
            \ },
            \ 'component': {
            \   'obsession': '%{ObsessionStatus()} ',
            \ },
            \ 'component_function': {
            \   'fugitive': 'LightlineFugitive',
            \   'filedetail': 'LightlineFilename',
            \ },
            \ 'separator': { 'left': '', 'right': '' },
            \ 'subseparator': { 'left': '', 'right': '' },
            \ }
function! LightlineFugitive()
    if exists('*fugitive#head')
        let branch = fugitive#head()
        return branch !=# '' ? ''.branch : ''
    endif
    return ''
endfunction
function! LightlineFilename()
    let readonly = &readonly ? '' : ''
    let filename = expand('%:f') !=# '' ? expand('%:f') : '[No Name]'
    let modified = &modified ? '(+)' : ''
    return readonly . filename . modified
endfunction

" ProSession
let sessiondir = expand("$HOME/.local/share/nvim/session")
if !isdirectory(sessiondir)
    call mkdir(sessiondir, 'p')
endif
let g:prosession_dir = sessiondir
let g:prosession_tmux_title = 1
let g:prosession_tmux_title_format = "nvim - @@@"
let g:prosession_per_branch = 1

" Undotree
let g:undotree_SetFocusWhenToggle = 1

" }}}
" Mappings - overrides {{{


" Write operations
nnoremap <CR> :w<CR>

" Easy on the pinky
nnoremap ; :

" Pane open
nnoremap <M--> <C-w>s<CR>
nnoremap <M-\> <C-w>v<CR>
" Pane move
nnoremap <M-h> <C-w>h
nnoremap <M-H> <C-w>H
nnoremap <M-j> <C-w>j
nnoremap <M-J> <C-w>J
nnoremap <M-k> <C-w>k
nnoremap <M-K> <C-w>K
nnoremap <M-l> <C-w>l
nnoremap <M-L> <C-w>L
" Pane close
nnoremap <M-w> <C-w>c

" Tab open
nnoremap <M-t>t :tabnew<CR>
nnoremap <M-c>t :tabc<CR>

" File explorer pane
nnoremap <C-\> :Ex %:p:h<CR>

" Home row friendly navigation
nnoremap H ^
nnoremap L $

" Keep selection afer indent
vnoremap < <gv
vnoremap > >gv

" Select last pasted
nnoremap gp `[v`]

" Open file from git repo
nnoremap <C-p> :GitFiles<CR>

" Ban ex mode
nnoremap Q <Nop>

" Fix Y
nnoremap Y y$

" Change dir to git repo which contains current file (then pwd)
nnoremap cd :Gcd<CR>:pwd<CR>

" Easymotion
nmap f <Plug>(easymotion-s)

" More convenient escape sequence
inoremap ,j <Esc>
cnoremap ,j <Esc>
vnoremap ,j <Esc>
tnoremap ,j <C-\><C-n>
nnoremap ,j <Nop>

" Omnicomplete with Tab or CR
inoremap <expr> <Tab> pumvisible() ? "\<c-y>" : "\<Tab>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

" }}}
" Mappings - meta {{{

" Toggle git blame panel
nnoremap <M-b> :Gblame<CR>
" Toggle undo tree
nnoremap <M-u> :UndotreeToggle<CR>

" }}}
" Mappings - leader {{{

" Map Leader
map <Space> <Leader>
" Change tab type
nnoremap <Leader><Tab> :setlocal <C-R>=&expandtab ? 'noexpandtab' : 'expandtab'<CR><CR>
" Marks
nnoremap <Leader>' :Marks<CR>
" Commands
nnoremap <Leader>; :Commands<CR>
" Files from current file's path
nnoremap <Leader>. :Files <C-R>=expand('%:h')<CR><CR>
" Blurred lines
nnoremap <Leader>/ :Lines<CR>
" Find next non-unicode character
nnoremap <Leader>@ /[^[:alnum:][:punct:][:space:]]<CR>:echo "Searching for non-unicode characters"<CR>
" Move to current tab format, remove trailing space and re-indent file
nnoremap <Leader>= :retab<CR>mzggvG@tgv=`z
" Fix linting issues
nnoremap <Leader>a :ALEFix<CR>
" Switch to buffer
nnoremap <Leader>b :Buffers<CR>
" Find (respect .gitignore, include hidden files, ignore .git dir)
nnoremap <Leader>f :GitGrep! 
" Open from cwd
nnoremap <Leader>p :Files<CR>
" Reload config
nnoremap <Leader>R :so $MYVIMRC<CR>
" Git blame info
nnoremap <Leader>s :<C-u>call gitblame#echo()<CR>
" Search non-UTF8 characters
nnoremap <Leader>u /[^\x00-\x7F]<CR>
" Fast open confi,
nnoremap <Leader>v :e ~/.dotfiles/neovim/.config/nvim/init.vim<CR>
" Sudo write
nnoremap <Leader>W :w !sudo tee % > /dev/null<CR>

" }}}
" Mappings - macros {{{

" Append a line break
let @b = 'A<br />'
" CSS one per line
let @c = ':s/;\s/;\r/ge'
" HTML nbsp
let @d = ':s/﻿/\&#160;/g'
" Make e-mail link from visual selection
let @e = 'a</a>gv"zyi<a href="mailto:z">'
" MRO img src
let @f = '^ivar f:as ='
" Remove blank lines
let @l = ':g/^\s*$/d'
" Translate carriage returns
let @r = ':s/\r\+$//e'
" Remove trailing space
let @t = ':s/\s\+$//e'
" Unicode replacements: quotes, hyphens, ellipses and spaces
let @u = ':s/“\|”/"/ge:s/‘\|’\|`/\&rsquo;/ge:s/–/-/ge:s/…/.../ge:s/﻿/\&#xfeff;/ge'
" Turn Hex into proper unicode character
let @v = ':%s/ / /ge:%s//‘/ge:%s//’/ge:%s//“/ge:%s//”/ge:%s//–/ge:%s//—/ge:%s//…/ge'

" }}}
"  Functions and commands {{{

" Add FZF command for git grep
" - fzf#vim#grep(command, with_column, [options], [fullscreen])
command! -bang -nargs=* GitGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number --ignore-case '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)
"}}}
