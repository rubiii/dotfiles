" STARTUP ---

    set nocompatible                             " enable superpowers
    filetype off                                 " turn filetype settings off to load plugins

    " load vundle
    set rtp+=~/.vim/Bundle/vundle/
    call vundle#rc()

    " load vundle config
    runtime config/bundle.config


" LEADER ---

    let mapleader = ","


" CHROME ---

    set nobackup                                 " just don't backup
    set nowritebackup                            " no write backups
    set noswapfile                               " and no swap files

    set nofoldenable                             " just don't fold!
    set hidden                                   " allow unsafed buffers to be hidden
    set history=200                              " keep a nice history
    set autoread                                 " automatically reload changed files

    "set cursorline                              " show cursor line
    set mouse=a                                  " enable mouse support
    set laststatus=2                             " always display a status line
    set number                                   " show line numbers
    set ruler                                    " display coordinates in status bar
    set showcmd                                  " display unfinished commands
    set showmatch                                " show matching bracket (briefly jump)
    set showmode                                 " display the current mode in the status bar
    set title                                    " show file in titlebar

    " ignore this stuff
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/*/tmp/*,*.so,*.swp,*.zip

    set wildmenu                                 " completion with menu
    set wildmode=longest,list                    " bash-like tab completion

    set shortmess=filmnrxoOtTI                   " configure short messages

    set statusline=
    set statusline +=%f\                         " filename
    set statusline +=[%{strlen(&ft)?&ft:'none'}] " filetype
    set statusline +=%m\                         " modified
    set statusline +=%=                          " right align
    set statusline +=\ [%{&fileencoding}]\       " file encoding
    set statusline +=(%l,%c%V)\ %<%P             " offset


" LOOKS ---

    set guifont=Monaco:h10                       " font
    set noantialias                              " noantialias
    set t_Co=256                                 " colors

    set background=dark
    colorscheme solarized                        " theme

    map + 200<C-W>+                              " expand current split
    map = <C-W>=                                 " equalize split sizes

" EDITING ---

    filetype plugin indent on                    " enable filetype settings
    syntax on                                    " enable syntax highlighting

    set formatoptions=crqn21                     " format settings

    set autoindent                               " autoindent my code
    set smartindent                              " and be smart about it
    set backspace=indent,eol,start               " backspace for dummys
    set whichwrap+=<,>,h,l,[,]                   " automatically wrap left and right

    " keep 3 lines on screen while scolling
    set scrolloff=3
    set sidescrolloff=3

    " two spaces, always
    set expandtab
    set softtabstop=2
    set tabstop=2
    set shiftwidth=2

    " dont break lines
    set textwidth=0
    set nolinebreak
    set wrap

    " Q to repeat the last macro
    map Q @@

    " insert newlines above/below the current line
    map <S-Enter> O<Esc>j
    map <CR> o<Esc>k

    " easy window movement
    map <Leader>h <C-w>h
    map <Leader>k <C-w>k
    map <Leader>l <C-w>l
    map <Leader>j <C-w>j

    highlight NonText guifg=#4a4a59
    highlight SpecialKey guifg=#4a4a59

    " map autocomplete
    if has("gui_running")
      inoremap <C-Space> <C-n>
    else
      inoremap <Nul> <C-n>
    endif

    " normal cursors for native vim
    if !has("gui_running") && has("cursorshape")
      let &t_SI = "\<Esc>]50;CursorShape=1\x7"
      let &t_EI = "\<Esc>]50;CursorShape=0\x7"
    endif


" WHITESPACE ---

    fun! <SID>StripTrailingWhitespaces()
      let l = line(".")
      let c = col(".")
      %s/\s\+$//e
      call cursor(l, c)
    endfun

    autocmd FileType ruby,python autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()


" SEARCH ---

    set hlsearch                                 " highlight search terms
    set incsearch                                " search incrementally

    set ignorecase                               " ignore case in searches
    set smartcase                                " case sensitive if capitals are included

    " ctrl-c clears highlights
    nmap <silent> <C-C> :noh<CR>


" FILETYPES ---

    " ruby
    au BufRead,BufNewFile {Capfile,Guardfile,Gemfile,Rakefile,Thorfile,Vagrantfile,Procfile,buildfile,config.ru} set ft=ruby

    " python
    au FileType make   set noexpandtab
    au FileType python set softtabstop=4 tabstop=4 shiftwidth=4

    " snippets
    au BufRead,BufNewFile *.snippet,*.snippets set noexpandtab softtabstop=0

    " xml
    au BufRead,BufNewFile *.wsdl set ft=xml


" GUI ---

    if has("gui_running")
      set transp=0

      " no toolbar, no scrollbars
      set guioptions-=T
      set guioptions-=r
      set guioptions-=L

      " fullscreen
      set fuoptions=maxhorz,maxvert
    endif


" CTAGS ---

    let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'
    let Tlist_Show_One_File = 1
    let Tlist_Use_Right_Window = 1
    let Tlist_WinWidth = 60

    let Tlist_GainFocus_On_ToggleOpen = 1
    let Tlist_Use_SingleClick = 1

    set laststatus=2
    let g:ctags_statusline=1 
    let generate_tags=1

    " map to ,m
    nmap <Leader>m :TlistToggle<CR>

    " map jump to method
    nmap <Leader>g <C-]>

    " update on write for *.rb
    autocmd BufWritePost *.rb :TlistUpdate


" NERDTREE ---

      " style
      let NERDTreeWinSize = 43
      let NERDTreeHighlightCursorline = 0
      let NERDTreeShowBookmarks = 1

      let NERDTreeChDirMode = 2                        " change cwd if root changes
      let NERDTreeIgnore = ['\.rbc$', '\~$']           " ignore .rbc files

      " map to ,n
      nmap <Leader>n :NERDTreeToggle<CR>


" SYNTASTIC ---

    " use signs to indicate lines with errors
    if has("signs")
       let g:syntastic_enable_signs = 1
    endif

    " always show warnings
    let g:syntastic_quiet_warnings = 0

    " files not to check
    let g:syntastic_disabled_filetypes = ['html', 'coffee', 'sass', 'haml']


" CTRL-P

    let g:ctrlp_map = '<Leader>t'
    let g:ctrlp_extensions = ['buffertag']

    let g:ctrlp_working_path_mode = 2

    nmap <Leader>z :CtrlPBufTag<CR>


" LOCAL ---

    if filereadable(expand("~/.vimrc.local"))
      source ~/.vimrc.local
    endif
