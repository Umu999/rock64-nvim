" ================================
" 一般設定
" --------------------------------
" TABキー入力時にスペースを入れる
set expandtab
set tabstop=4
set shiftwidth=4
set number
set cursorline
set encoding=utf-8
set incsearch



" nvimにpyenvでグローバルにインストールされたpythonを認識させる設定
let g:python_host_prog = expand('~/.pyenv/shims/python')

" ディレクトリ設定
let $CACHE = expand('$HOME/.cache')
let $CONFIG = expand('$HOME/.config')
let $DATA = expand('$HOME/.local/share')

" dein設定
let s:dein_dir = expand('$DATA/dein')

" !~は正規表現にマッチしないという意味 #はケースセンシティブ
" &runtimepathはruntimepathオプションをvimrcの中で変数として使っている
" runtimepathはvimが開いたときに読み込まれるパス
" つまりこの条件式は、vimが開いたときに読み込まれるパスに/dein.vimを含むパスがなければ真となる
if &runtimepath !~# '/dein.vim'
	" `.`は文字列結合
	let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

	" 自動ダウンロード
	if !isdirectory(s:dein_repo_dir)
		"!をつけると外部シェルコマンドを実行する
		execute '!git clone https://github.com/Shougo/dein.vim ' . s:dein_repo_dir
	endif

	" ^=で先頭に追加、+=で末尾に追加
	execute 'set runtimepath^=' . s:dein_repo_dir
endif

let g:dein#install_max_processes = 16


call dein#begin(s:dein_dir, expand('<sfile>'))

let s:toml_dir = expand('$CONFIG/nvim/dein')

call dein#load_toml(s:toml_dir . '/plugins.toml', {'lazy': 0})
call dein#load_toml(s:toml_dir . '/lazy.toml', {'lazy': 1})
if has('python')
	call dein#load_toml(s:toml_dir . '/python.toml', {'lazy': 1})
endif

call dein#end()
call dein#save_state()

if has('vim_starting') && dein#check_install()
	call dein#install()
endif

" ============================
" 補完設定
" ----------------------------
let g:neocomplete#enable_at_startup = 1
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#source#omni#input_patterns = {}
endif
let g:neocomplete#source#omni#input_patterns = '[^.[:digit:] *\t]\%(\.\|\::\)\%(\h\w*\)\?'

" ===============================
" Rusr
" -------------------------------
au FileType rust compiler cargo


" ========================
" NERDTree設定
" -----------------------
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeShowHidden = 1
" vim起動時の処理
" ファイルの方にフォーカス(\<C-w>\<C-w>)
autocmd VimEnter * NERDTree | call feedkeys("\<C-w>\<C-w>", 'n')

" NERDTree開閉キー設定
map <C-n> :NERDTreeToggle<CR>
" 他のバッファをすべて閉じたときにNERDTreeが開いてきたらNERDTreeも同時に閉じる
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" ============================
" カラースキーム
" ----------------------------
if (has("termguicolors"))
    set termguicolors
endif

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

syntax on
colorscheme night-owl
