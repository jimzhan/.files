"  ------------------------------------------------------------
" *  @file       plugins.vim
" *  @date       2014
" *  @author     Jim Zhan <jim.zhan@me.com>
" *
" Copyright © 2014 Jim Zhan.
" ------------------------------------------------------------
" Licensed under the Apache License, Version 2.0 (the "License");
" you may not use this file except in compliance with the License.
" You may obtain a copy of the License at
"
"     http://www.apache.org/licenses/LICENSE-2.0
"
" Unless required by applicable law or agreed to in writing, software
" distributed under the License is distributed on an "AS IS" BASIS,
" WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
" See the License for the specific language governing permissions and
" limitations under the License.
" ------------------------------------------------------------
"  Fundamental Envionment
" ---------------------------------------------------------------------------
NeoBundle 'moll/vim-bbye'
NeoBundle 'yonchu/accelerated-smooth-scroll'
NeoBundle 'Shougo/vimproc', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'unix' : 'make -f make_unix.mak',
\    },
\ }



" ---------------------------------------------------------------------------
"  Themes: Color Themes
" ---------------------------------------------------------------------------
NeoBundle 'tomasr/molokai'
NeoBundle 'chriskempson/Vim-Tomorrow-Theme'
NeoBundle 'chriskempson/base16-vim' "{{
  let g:rehash256=1
  let g:molokai_original = 1
  let base16colorspace=256
"}}
NeoBundle 'altercation/vim-colors-solarized'


" ---------------------------------------------------------------------------
"  GIT Manager: Fugitive + GitGutter
" ---------------------------------------------------------------------------
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'airblade/vim-gitgutter' "{{
  nnoremap <silent> <leader>gs :Gstatus<CR>
  nnoremap <silent> <leader>gd :Gdiff<CR>
  nnoremap <silent> <leader>gc :Gcommit<CR>
  nnoremap <silent> <leader>gb :Gblame<CR>
  nnoremap <silent> <leader>gl :Glog<CR>
  nnoremap <silent> <leader>gp :Git push<CR>
  nnoremap <silent> <leader>gw :Gwrite<CR>
  nnoremap <silent> <leader>gr :Gremove<CR>
  autocmd BufReadPost Fugitive://* set bufhidden=delete
"}}
NeoBundle 'mattn/gist-vim', {'depends': 'mattn/webapi-vim'}


" ---------------------------------------------------------------------------
"  File Manager: NERDTree + Ctrlp + ag
" ---------------------------------------------------------------------------
"nnoremap <C-o> :VimFiler -buffer-name=explorer -split -simple -winwidth=35 -toggle -no-quit<CR>
" ---------------------------------------------------------------------------
NeoBundle 'scrooloose/nerdtree', {'depends': 'jistr/vim-nerdtree-tabs'} " {{
  map <C-o>   <plug>NERDTreeTabsToggle<CR>
  let NERDTreeShowBookmarks   = 1
  let g:NERDTreeChDirMode     = 2
  let NERDTreeIgnore=['\.DS_Store', '\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
"}}
" ---------------------------------------------------------------------------
NeoBundle "Shougo/unite.vim", {'depends': 'Shougo/neomru.vim'} "{{
  call unite#filters#matcher_default#use(['matcher_fuzzy'])
  call unite#filters#sorter_default#use(['sorter_rank'])

  let g:unite_prompt = "❤  "
  let g:unite_winheight = 20
  let g:unite_split_rule = 'botright'
  let g:unite_enable_ignore_case = 1
  let g:unite_enable_smart_case = 1
  let g:unite_enable_start_insert = 1

  let g:unite_data_directory = '~/.vim/tmp/unite'
  let g:unite_source_file_mru_limit = 200
  let g:unite_source_history_yank_enable = 1
  let g:unite_source_rec_max_cache_files=5000
  call unite#custom#source('file_rec,file_rec/async', 'ignore_pattern', '(\.meta$|\.tmp)')

  nnoremap <Leader>y  :Unite history/yank<CR>
  nnoremap <Leader>/  :Unite grep:.<cr>
  nnoremap <Leader>s  :Unite -quick-match buffer<CR>
  nnoremap <Leader>n  :Unite -buffer-name=New -profile-name=files file/new<CR>
  nnoremap <Leader>f  :Unite -buffer-name=files buffer file_mru bookmark file<CR>

  autocmd FileType unite call s:unite_my_settings()
  function! s:unite_my_settings()
    imap <silent><buffer> <C-k> <C-p>
    imap <silent><buffer> <C-j> <C-n>
    imap <silent><buffer> <C-d> <CR>
  endfunction

  if executable('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_rec_async_command = 'ag --follow --nocolor --nogroup -g ""'
    "let g:unite_source_grep_default_opts='--nocolor --nogroup --column'
    let g:unite_source_grep_default_opts = '--line-numbers --nocolor --nogroup --hidden --ignore ' .
                                        \  '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
    let g:unite_source_grep_recursive_opt = ''
  endif
"}}
" ---------------------------------------------------------------------------


" ---------------------------------------------------------------------------
"  Comment Helper: NERDCommentor
" ---------------------------------------------------------------------------
NeoBundle 'scrooloose/nerdcommenter'


" ---------------------------------------------------------------------------
"  Status: Status Line Enhancement
" ---------------------------------------------------------------------------
NeoBundle 'bling/vim-airline' "{{
  let g:airline_powerline_fonts=1
  "let g:airline_theme='badwolf'
  let g:airline#extensions#tabline#enabled = 1
  " Show just the filename
  let g:airline#extensions#tabline#fnamemod = ':t'
"}}
"

" ---------------------------------------------------------------------------
"  Tags: Source Code Tags
" ---------------------------------------------------------------------------
if executable('ctags') " {{
  NeoBundle 'majutsushi/tagbar'
  let g:tagbar_width=30
  "autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx,*.go call tagbar#autoopen()
  nnoremap <silent> <Leader>tt :TagbarToggle<CR>
  " If using go please install the gotags program using the following
  " go install github.com/jstemmer/gotags
  " And make sure gotags is in your path
  if executable('gotags')
    let g:tagbar_type_go = {
\     'ctagstype' : 'go',
\     'kinds'     : [  'p:package', 'i:imports:1', 'c:constants', 'v:variables',
\                   't:types',  'n:interfaces', 'w:fields', 'e:embedded', 'm:methods',
\                   'r:constructor', 'f:functions' ],
\     'sro' : '.',
\     'kind2scope' : { 't' : 'ctype', 'n' : 'ntype' },
\     'scope2kind' : { 'ctype' : 't', 'ntype' : 'n' },
\     'ctagsbin'  : 'gotags',
\     'ctagsargs' : '-sort -silent'
\   }
  endif
endif
"}}


" ---------------------------------------------------------------------------
"  Languages:
" ---------------------------------------------------------------------------
" Golang Supports
" ---------------------------------------------------------------------------
NeoBundle 'fatih/vim-go' "{{
  "let g:go_fmt_autosave = 0
  let g:go_fmt_command = "goimports"
  nnoremap <silent> <leader>bb :GoInstall<CR>
"}}

" ---------------------------------------------------------------------------
" Markdown
" ---------------------------------------------------------------------------
NeoBundle 'tpope/vim-markdown' " {{
  au BufRead,BufNewFile *.md set filetype=markdown
"}}
" ---------------------------------------------------------------------------
" HTML5 + Jinja
" ---------------------------------------------------------------------------
NeoBundle 'othree/html5.vim'
NeoBundle 'lepture/vim-jinja'
au BufNewFile,BufRead *.html,*.htm,*.shtml,*.stm set ft=jinja
" ---------------------------------------------------------------------------
" Javascript: React JSX
" ---------------------------------------------------------------------------
NeoBundle 'mxw/vim-jsx', {'depends': 'pangloss/vim-javascript'} " {{
  let g:jsx_ext_required = 0
  let g:jsx_pragma_required = 0
"}}
NeoBundle 'othree/yajs.vim'
NeoBundle 'othree/javascript-libraries-syntax.vim'
let g:used_javascript_libs = 'underscore,react'
" ---------------------------------------------------------------------------


" ---------------------------------------------------------------------------
"  Syntax: Static Syntax Checking
" ---------------------------------------------------------------------------
NeoBundle 'scrooloose/syntastic' "{{
  hi SyntasticErrorSign ctermfg=196 guifg=#FF0000
  let g:syntastic_enable_signs = 1
  let g:syntastic_error_symbol = "✗"
  let g:syntastic_style_error_symbol = "✗>"
  let g:syntastic_warning_symbol = "⚠"
  let g:syntastic_check_on_open = 1
  if has('balloon_eval')
      let g:syntastic_enable_balloons = 1
  endif
  let g:syntastic_javascript_checkers = ['jsxhint']
"}}
" ---------------------------------------------------------------------------
"  Editing:
"   * Emmet: previously known as Zen Coding is a web-developer’s toolkit that
"           can greatly improve HTML/CSS workflow by combining shortcuts & snippets.
"   * Surround: CRUD for parentheses, brackets, quotes, XML tags, and more.
"   * AutoPairs: Insert or delete brackets, parens, quotes in pair.
"   * Multiple Curosr: Multiple selection/editing like Sublime Text.
" ---------------------------------------------------------------------------
NeoBundle 'mattn/emmet-vim'
NeoBundle 'tpope/vim-surround'
NeoBundle 'Raimondi/delimitMate'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'editorconfig/editorconfig-vim'


" ---------------------------------------------------------------------------
"  Authocomplete: Autocomplete & Code Snippets
" ---------------------------------------------------------------------------
NeoBundle 'Shougo/neocomplete' " {{
  set completeopt-=preview
  " Disable AutoComplPop.
  let g:acp_enableAtStartup = 0
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#enable_smart_case = 1
  " Set minimum syntax keyword length.
  let g:neocomplete#sources#syntax#min_keyword_length = 3
  let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'"
  " Define keyword.
  if !exists('g:neocomplete#keyword_patterns')
     let g:neocomplete#keyword_patterns = {}
  endif
  let g:neocomplete#keyword_patterns['default'] = '\h\w*'
  inoremap <expr><TAB>    pumvisible() ? "\<C-n>" : "\<TAB>"
  inoremap <expr><CR>     pumvisible() ? neocomplete#close_popup() : "\<CR>"
"}}
" ---------------------------------------------------------------------------
NeoBundle 'honza/vim-snippets', {'depends': 'SirVer/ultisnips'} " {{
  let g:UltiSnipsEditSplit="vertical"
  let g:UltiSnipsExpandTrigger="<TAB>"
  let g:UltiSnipsJumpForwardTrigger="<TAB>"
  let g:UltiSnipsJumpBackwardTrigger="<S-TAB>"
  let g:UltiSnipsRemoveSelectModeMappings = 0
  let g:ultisnips_python_style = "google"     " Available Styles: doxygen | sphinx | google
"}}
" ---------------------------------------------------------------------------


" ---------------------------------------------------------------------------
"  Editor & Templates: File Templates
" ---------------------------------------------------------------------------
NeoBundle 'aperezdc/vim-template' " {{
  let g:templates_directory = expand('~/.vim/templates')
"}}


NeoBundle 'benmills/vimux'
