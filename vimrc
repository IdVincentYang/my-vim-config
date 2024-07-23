" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker
" [VIM脚本入门](https://www.ibm.com/developerworks/cn/linux/l-vim-script-1/)
" [Vim Awesome](https://vimawesome.com/)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Environment
set nocompatible

" move .viminfo out of home dir
set viminfo +=n$HOME/.vim/viminfo

" Strip trailing whitespace and newlines on save
function! StripTrailingWhitespace()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    %s/\($\n\s*\)\+\%$//e
    call cursor(l, c)
endfunction
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has('win32')
    source $VIMRUNTIME/mswin.vim
    behave mswin
endif

" General
filetype plugin indent on   " Automatically detect file types.
syntax on                   " Syntax highlighting
set mouse=a                 " Automatically enable mouse usage
set mousehide               " Hide the mouse cursor while typing
scriptencoding utf-8

" Windows has traditionally used cp1252, so it's probably wise to
" fallback into cp1252(Windows Latin-1) instead of eg. iso-8859-15.
" Newer Windows files might contain utf-8 or utf-16 LE so we might
" want to try them first.
set fileencodings=ucs-bom,utf-8,chinese,utf-16,big5,big5-hkscs,cp1252,iso-8859-15
set fileencoding=utf-8

set termencoding=utf-8
set encoding=utf-8

" 显示中文帮助
if version >= 603
    set helplang=cn
endif

if has('clipboard')
    if has('unnamedplus')  " When possible use + register for copy-paste
        set clipboard=unnamed,unnamedplus
    else         " On mac and Windows, use * register for copy-paste
        set clipboard=unnamed
    endif
endif

set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
set virtualedit=onemore             " Allow for cursor beyond last character

set nospell                           " Spell checking off
set hidden                          " Allow buffer switching without saving
set iskeyword-=.                    " '.' is an end of word designator
set iskeyword-=#                    " '#' is an end of word designator
set iskeyword-=-                    " '-' is an end of word designator

set gdefault                        " let :s command default with 'g'

set incsearch                   " Find as you type search
set hlsearch                    " Highlight search terms
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too

set autoread
set autowrite
set formatoptions+=mMj          " let vim can break chinese and join

" set shell=/bin/bash\ --rcfile\ $HOME/.bash_profile   " using bash in vim shell

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

""""""""""""""""""""""""""""""""""""""""
" General: view
set nofoldenable                " close fold as default open fold using cmd: fen
set foldcolumn=1
set foldlevelstart=1
set foldmethod=syntax
set foldminlines=3

""""""""""""""""""""""""""""""""""""""""
" General: backup
set history=1000                    " Store a ton of history (default is 20)
set nobackup                  " Backups are nice ...
set noswapfile
if has('persistent_undo')
    set noundofile                " So is persistent undo ...
    set undolevels=1000         " Maximum number of changes that can be undone
    set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
endif

""""""""""""""""""""""""""""""""""""""""
" General: UI

set shortmess=atI   " 启动的时候不显示那个援助乌干达儿童的提示
set tabpagemax=15               " Only show 15 tabs
set showmode                    " Display the current mode
set cursorline                  " Highlight current line
set cursorcolumn                 " Highlight current column
highlight clear SignColumn      " SignColumn should match background
highlight clear LineNr          " Current line number row will have same background color in relative mode

if has('cmdline_info')
    set ruler                   " Show the ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
    set showcmd                 " Show partial commands in status line and
    " Selected characters/lines in visual mode
endif

if has('statusline')
    set laststatus=2            " 启动显示状态行(1),总是显示状态行(2)

    " Broken down into easily includeable segments
    set statusline=%<%f\                     " Filename
    set statusline+=%w%h%m%r                 " Options
    if !exists('g:override_spf13_bundles')
        "set statusline+=%{fugitive#statusline()} " Git Hotness
    endif
    set statusline+=\ [%{&ff}/%Y]            " Filetype
    set statusline+=\ [%{getcwd()}]          " Current dir
    set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif

set backspace=indent,eol,start  " 使回格键（backspace）正常处理indent, eol, start等
set linespace=0                 " No extra spaces between rows
set relativenumber              " 使用相对行号
set nu                          " Line numbers on
set showmatch                   " 高亮显示匹配的括号
set winminheight=0              " Windows can be 0 line high
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
set nofoldenable                  " Auto fold code
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace

" General: Formatting
set wrap                      " Do not wrap long lines
if has('wrap')
    set linebreak
endif

"   tab setting
set expandtab                   " Tabs are spaces, not tabs
set tabstop=8                   " a <tab> char in file shows columns in editor
set softtabstop=4               " The columns moved when <tab> and <backspace> pressed

"   indent setting
set cindent
set shiftwidth=4                " Use indents of 4 spaces

set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow                  " Puts new split windows to the bottom of the current
"set matchpairs+=<:>             " Match, to be used with %
"set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
"set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
" Remove trailing whitespaces and ^M chars
autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl,sql autocmd BufWritePre <buffer> call StripTrailingWhitespace()
autocmd FileType go autocmd BufWritePre <buffer> Fmt
autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
autocmd FileType haskell,puppet,ruby,yml setlocal expandtab shiftwidth=2 softtabstop=2
autocmd BufNewFile,BufRead *.coffee set filetype=coffee
" 高亮显示普通txt文件（需要txt.vim脚本）
"au BufRead,BufNewFile *  setfiletype txt

""""""""""""""""""""""""""""""""""""""""
" General: GUI

if has("gui_running")

    "浏览档案的目录，GUI 版本始有。预设是上一次浏览的目录。就是 GUI版本功能表上的 [File] -> [Open] 会打开的目录。
    set bsdir=buffer

    if has('statusline')
        "set fillchars+=stl:\|
    endif

    if has('termguicolors')
        set termguicolors
    endif
endif

""""""""""""""""""""""""""""""""""""""""
" General: Git
" Instead of reverting the cursor to the last position in the buffer, we
" set it to the first line when editing a git commit message
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [1, 1, 1, 0])



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key (re)Mapping
let mapleader = ','
nnoremap \ ,
" let maplocalleader = '`'

" F1~F12
function! MyRenameFile()
    " echomsg 'Step1: input new name and check it's a valid name'
    let old_name = expand('%:p')
    let new_name = input('New file name: ', old_name, 'file')
    if new_name == old_name
        redraw | echo 'Same file name: ' . old_name . ', no operaiton.'
        return
    elseif new_name == ''
        " Empty name means nothing to do
        redraw | echo ''
        return
    endif
    " echomsg 'Step2: save file as new_name, if failure, abort'
    try
        execute 'saveas ' . new_name
    catch
        redraw | echomsg "Error: Failed to save file as " . new_name
        return
    endtry
    " echomsg 'Step3: delete old_name file and buffer'
    silent! execute '!mv ' . shellescape(old_name) . ' ' . shellescape(new_name)
    silent! execute 'bdelete ' . bufname(old_name)
    echomsg "File renamed successfully from " . old_name . " to " . new_name
endfunction
nnoremap <F2> :call MyRenameFile()<CR>

" 插入空行
nnoremap <CR> o<Esc>
nnoremap <S-CR> O<Esc>

" fast reloading of .vimrc
nnoremap <silent> <leader>ss :source $MYVIMRC<CR>
nnoremap <silent> <leader>ee :e $MYVIMRC<CR>

" edit a temporary file
nnoremap <leader><leader>t :exec "e " . tempname()<CR>

" scroll page using space
nnoremap <Space> <C-F>
nnoremap <S-Space> <C-B>

" use ALT+[jk] to moving lines up and down
" then Wrapped lines goes down/up to next row, rather than next line in file.
noremap j gj
noremap k gk
nnoremap <M-j> mz:m+<CR>`z
nnoremap <M-k> mz:m-2<CR>`z

" fast buffer switch
nnoremap <C-S-tab> :bp<CR>
nnoremap <C-tab> :bn<CR>

" fast buffer close
command! BcloseOthers call <SID>BufCloseOthers()
function! <SID>BufCloseOthers()
    let l:currentBufNum   = bufnr("%")
    let l:alternateBufNum = bufnr("#")
    for i in range(1,bufnr("$"))
        if buflisted(i)
            if i!=l:currentBufNum
                execute("bdelete ".i)
            endif
        endif
    endfor
endfunction
nnoremap <leader>qo :BcloseOthers<CR>
nnoremap <leader>qq :bp\|bd#<CR>
nnoremap <leader>qa :bufdo bd<CR>
nnoremap <leader>Q :bd<CR>

" easyWindows
" map <C-J> <C-W>j<C-W>_
" map <C-K> <C-W>k<C-W>_
" map <C-L> <C-W>l<C-W>_
" map <C-H> <C-W>h<C-W>_
" "使用CTRL+[hjkl]在窗口间导航
" noremap <C-c> <C-W>c
" noremap <C-j> <C-W>j
" noremap <C-k> <C-W>k
" noremap <C-h> <C-W>h
" noremap <C-l> <C-W>l

" Open current file in browser
"nnoremap <leader>P :call netrw#BrowseX(expand("%:p"), 0)<CR>

" Adjust viewports to the same size
"map <Leader>= <C-w>=

" Most prefer to toggle search highlighting rather than clear the current
" search results. To clear search highlighting rather than toggle it on
" and off, add the following to your .vimrc.before.local file:
"   let g:spf13_clear_search_highlight = 1
if exists('g:spf13_clear_search_highlight')
    nmap <silent> <leader>/ :nohlsearch<CR>
else
    nmap <silent> <leader>/ :set invhlsearch<CR>
endif

" Find merge conflict markers
map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

" Shortcuts
" Change Working Directory to that of the current file
"cmap cwd lcd %:p:h
"cmap cd. lcd %:p:h

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Allow using the repeat operator with a visual selection (!)
" http://stackoverflow.com/a/8064607/127816
vnoremap . :normal .<CR>

" Some helpers to edit mode
" http://vimcasts.org/e/14
nnoremap <leader><space> i<space><esc>
"cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
"map <leader>ew :e %%
"map <leader>es :sp %%
"map <leader>ev :vsp %%
"map <leader>et :tabe %%

" Map <Leader>ff to display all lines with keyword under cursor
" and ask which one to jump to
"nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

" Easier horizontal scrolling
"map zl zL
"map zh zH

" Easier formatting
"nnoremap <silent> <leader>q gwip

" FIXME: Revert this f70be548
" fullscreen mode for GVIM and Terminal, need 'wmctrl' in you PATH
"map <silent> <F11> :call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins: https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation

""""""""""""""""""""""""""""""""""""""""
" internal plug: 'netrw' (https://shapeshed.com/vim-netrw/)

""""""""""""""""""""""""""""""""""""""""
" Auto install plug manager: 'vim-plug'
" search plug from: https://vimawesome.com

if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

function! Cond(cond, ...)
    let opts = get(a:000, 0, {})
    return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

" g:plug*
call plug#begin('~/.vim/plugged')

Plug 'chr4/nginx.vim'
Plug 'chrisbra/unicode.vim'
Plug 'Chiel92/vim-autoformat'
Plug 'easymotion/vim-easymotion'
Plug 'honza/vim-snippets'
Plug 'jayli/vim-easycomplete'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-plug'
Plug 'lifepillar/vim-solarized8'
Plug 'NoahTheDuke/vim-just'
Plug 'scrooloose/nerdcommenter'
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-surround'
"  netrw 增强插件: https://github.com/Tao-Quixote/vim/blob/master/plugin/vinegar.md
Plug 'tpope/vim-vinegar'

Plug 'vim-airline/vim-airline'
Plug 'vim-scripts/Rename'
Plug 'vim-scripts/txt.vim'
" 解决调用终端命令报错: WARNING: terminal is not fully functional
" https://github.com/vim-utils/vim-man
Plug 'vim-utils/vim-man'
call plug#end()

function! PlugMappings()
    let l:line = getline(".")

    let l:name = expand("<cword>")
    nnoremap <buffer> <silent> o :call netrw#BrowseX('https://google.com', 0)<CR>
endfunction

autocmd Filetype vim-plug call PlugMappings()

" Automatically install missing plugins on startup
autocmd VimEnter *
            \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
            \|   PlugInstall --sync | q
            \| endif

""""""""""""""""""""""""""""""""""""""""
" plug: 'https://github.com/lifepillar/vim-solarized8'
if has_key(g:plugs, 'vim-solarized8')
    " set background=dark
    set background=light
    colorscheme solarized8
endif

""""""""""""""""""""""""""""""""""""""""
" Plug: 'https://github.com/vim-airline/vim-airline'
if has_key(g:plugs, 'vim-airline')
    if has("gui_running")
        let g:airline_powerline_fonts = 1
    endif
    " show absolute file path in status line
    "let g:airline_section_c = '%<%F%m %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#'

    " 关闭状态显示缩进行计数
    let g:airline#extensions#whitespace#enabled = 0
    " 没效果 let g:airline#extensions#whitespace#symbol = '!'

    let g:airline#extensions#tabline#enabled = 1

    if g:airline#extensions#tabline#enabled
        let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
        "let g:airline#extensions#tabline#fnametruncate = 16
        "let g:airline#extensions#tabline#fnamecollapse = 2

        let g:airline#extensions#tabline#buffer_idx_mode = 1
        let g:airline#extensions#tabline#buffer_nr_show = 1

        let g:airline#extensions#tabline#show_tabs = 0
        if g:airline#extensions#tabline#show_tabs
            let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
            let g:airline#extensions#tabline#show_tab_nr = 1
        endif
    endif
endif

""""""""""""""""""""""""""""""""""""""""
" Plug: 'https://github.com/vim-scripts/txt.vim'
if has_key(g:plugs, 'txt.vim')
    " 在 '~/.vim/' 目录下添加检测脚本,把没有后缀的文件都默认使用 txt 插件高亮
    let s:dir = expand('~/.vim/ftdetect/')
    let s:fp = s:dir . 'txt.vim'
    if !filereadable(s:fp)
        call mkdir(s:dir, 'p')
        call writefile(['au BufRead,BufNewFile *  setfiletype txt'], s:fp)
    endif
endif

""""""""""""""""""""""""""""""""""""""""
" Plug: 'fzf.vim': https://segmentfault.com/a/1190000016186540
" 集成说明: https://segmentfault.com/a/1190000016186540
if has_key(g:plugs, 'fzf.vim')

    " let g:fzf_vim = {}
    " Preview window is hidden by default. You can toggle it with ctrl-/.
    " It will show on the right with 50% width, but if the width is smaller
    " than 70 columns, it will show above the candidate list
    " let g:fzf_vim.preview_window = ['right,50%,<30(up,40%)', 'ctrl-/']

    let g:fzf_action = { 'ctrl-e': 'edit' }

    let g:fzf_command_prefix = 'Fzf'  " 设置 command line 中 fzf 命令前缀
    " Normal mode mappings
    nmap <leader><tab> <plug>(fzf-maps-n)
    " imap <Leader><tab> <plug><fzf-maps-i)     " Insert mode mappings
    " xmap <leader><tab> <plug>(fzf-maps-x)     " Visual mode mappings
    " omap <leader><tab> <plug>(fzf-maps-o)     " Operator-pending mappings

    " C-p 查看文件列表, C-e 查看当前 buf，两次 C-e 快速切换上次打开的 buf

    " Insert mode completion(default settings)
    " imap <c-x><c-k> <plug>(fzf-complete-word) " word from dict
    " imap <c-x><c-f> <plug>(fzf-complete-path) " curr dir path completion
    " imap <c-x><c-l> <plug>(fzf-complete-line) " whole line completion
    nmap <C-p> :FzfFiles<CR>
    nmap <C-e> :FzfBuffers<CR>

    " list current dir easier
    command! -bang -complete=dir -nargs=? LS
                \ call fzf#run(fzf#wrap('ls', {'source': 'ls', 'dir': <q-args>}), <bang>0)
    " search files include hidden files in current dir
    command!-bang -nargs=* Rgh call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case --hidden ".fzf#shellescape(<q-args>), fzf#vim#with_preview(), <bang>0)'
    " search files include hidden and ignore files in current dir
    command!-bang -nargs=* Rgg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case --hidden --no-ignore ".fzf#shellescape(<q-args>), fzf#vim#with_preview(), <bang>0)'
endif

""""""""""""""""""""""""""""""""""""""""
" Plug: 'https://github.com/vim-utils/vim-man'
if has_key(g:plugs, 'vim-man')
    if has("gui_running")
        nnoremap K :<C-U>exe "Man" v:count "<C-R><C-W>"<CR>
    endif
endif

""""""""""""""""""""""""""""""""""""""""
" Plug: 'https://github.com/scrooloose/nerdcommenter'
if has_key(g:plugs, 'nerdcommenter')
    " Add spaces after comment delimiters by default
    let g:NERDSpaceDelims = 1
    " Use compact syntax for prettified multi-line comments
    "let g:NERDCompactSexyComs = 1
    " Align line-wise comment delimiters flush left instead of following code indentation
    let g:NERDDefaultAlign = 'left'
    " Set a language to use its alternate delimiters by default
    let g:NERDAltDelims_java = 1
    " Add your own custom formats or override the defaults
    let g:NERDCustomDelimiters = { 'text': { 'left': '#','right': '' } }
    " Allow commenting and inverting empty lines (useful when commenting a region)
    let g:NERDCommentEmptyLines = 1
    " Enable trimming of trailing whitespace when uncommenting
    let g:NERDTrimTrailingWhitespace = 1
    " Enable NERDCommenterToggle to check all selected lines is commented or not
    let g:NERDToggleCheckAllLines = 1
endif

""""""""""""""""""""""""""""""""""""""""
" Plug 'https://github.com/chrisbra/unicode.vim'
if has_key(g:plugs, 'unicode.vim')
    " let g:Unicode_no_default_mappings = v:true
    " 替换默认的查询当前光标下字符编码的命令
    nmap ga :UnicodeName<CR>
endif

""""""""""""""""""""""""""""""""""""""""
" Plug 'https://github.com/Chiel92/vim-autoformat'
if has_key(g:plugs, 'vim-autoformat')

    autocmd FileType c,cpp autocmd BufWrite * :Autoformat

    " let g:autoformat_verbosemode = 1
    " let g:autoformat_autoindent = 0
    " let g:autoformat_retab = 0
    " disable remove trailing spaces due to this has been done by above
    let g:autoformat_remove_trailing_spaces = 0

endif

""""""""""""""""""""""""""""""""""""""""
" Plug 'https://github.com/easymotion/vim-easymotion
if has_key(g:plugs, 'vim-easymotion')
    " The default configuration defines the following mappings in normal,
    " visual and operator-pending mode if |g:EasyMotion_do_mapping| is on:
    "
    " Note: The default leader has been changed to <Leader><Leader> to avoid
    "       conflicts with other plugins you may have installed
    "
    "     Default Mapping      | Details
    "     ---------------------|----------------------------------------------
    "     <Leader>f{char}      | Find {char} to the right. See |f|.
    "     <Leader>F{char}      | Find {char} to the left. See |F|.
    "     <Leader>t{char}      | Till before the {char} to the right. See |t|.
    "     <Leader>T{char}      | Till after the {char} to the left. See |T|.
    "     <Leader>w            | Beginning of word forward. See |w|.
    "     <Leader>W            | Beginning of WORD forward. See |W|.
    "     <Leader>b            | Beginning of word backward. See |b|.
    "     <Leader>B            | Beginning of WORD backward. See |B|.
    "     <Leader>e            | End of word forward. See |e|.
    "     <Leader>E            | End of WORD forward. See |E|.
    "     <Leader>ge           | End of word backward. See |ge|.
    "     <Leader>gE           | End of WORD backward. See |gE|.
    "     <Leader>j            | Line downward. See |j|.
    "     <Leader>k            | Line upward. See |k|.
    "     <Leader>n            | Jump to latest "/" or "?" forward. See |n|.
    "     <Leader>N            | Jump to latest "/" or "?" backward. See |N|.
    "     <Leader>s            | Find(Search) {char} forward and backward.
    "                          | See |f| and |F|.
    nmap <Leader><Leader>J <Plug>(easymotion-eol-j)
    nmap <Leader><Leader>K <Plug>(easymotion-eol-k)
    nmap <Leader><Leader>S <Plug>(easymotion-overwin-f2)

endif

""""""""""""""""""""""""""""""""""""""""
" Plug 'https://github.com/jayli/vim-easycomplete'
if has_key(g:plugs, 'vim-easycomplete')
    " Highlight the symbol when holding the cursor
    let g:easycomplete_cursor_word_hl = 0
    " Using nerdfont is highly recommended
    let g:easycomplete_nerd_font = 1

    noremap gr :EasyCompleteReference<CR>
    noremap gd :EasyCompleteGotoDefinition<CR>
    noremap rn :EasyCompleteRename<CR>
    noremap gb :BackToOriginalBuffer<CR>
endif

""""""""""""""""""""""""""""""""""""""""
" Plug 'https://github.com/SirVer/ultisnips'
if has_key(g:plugs, 'ultisnips')
    " https://github.com/SirVer/ultisnips/blob/master/doc/UltiSnips.txt#L163
    " If you want :UltiSnipsEdit to split your window.
    " let g:UltiSnipsEditSplit="vertical"
    let g:UltiSnipsSnippetStorageDirectoryForUltiSnipsEdit=$XDG_CONFIG_HOME.'/UltiSnips'
    let g:UltiSnipsSnippetDirectories=['UltiSnips', $XDG_CONFIG_HOME.'/UltiSnips']
endif
" echom ".vimrc loaded"
