call plug#begin('~/.vim/plugged')

" Themes
Plug 'itchyny/lightline.vim'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
"Plug 'catppuccin/nvim', {'as': 'catppuccin'}

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Files
" Nerdtre
" https://github.com/Xuyuanp/nerdtree-git-plugin
Plug 'preservim/nerdtree'

" Web stuff:

" coc for auto completion - TODO Switch to native lsp later: https://github.com/neovim/nvim-lspconfig/wiki/Comparison-to-other-LSP-ecosystems-(CoC,-vim-lsp,-etc.)
" https://github.com/neoclide/coc.nvim
Plug 'neoclide/coc.nvim', {'branch': 'release'}


Plug 'maxmellon/vim-jsx-pretty'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

" Prettier
" https://prettier.io/docs/en/vim.html
" Plug 'sbdchd/cneoformat'

" Ident lines
" https://github.com/Yggdroot/indentLine
Plug 'Yggdroot/indentLine'

" Zen mode stuff
Plug 'smithbm2316/centerpad.nvim' " Does work, but resets with NERDtree
" Plug 'junegunn/goyo.vim' not good enough
Plug 'folke/zen-mode.nvim'

" Toggle comments
" https://github.com/tpope/vim-commentary
Plug 'tpope/vim-commentary'
" Surround stuff like '', (), {} and so on
" https://github.com/tpope/vim-surround
"Plug 'tpope/vim-surround'
"
" git diff integration
" https://github.com/airblade/vim-gitgutter
Plug 'airblade/vim-gitgutter'

"git diff
" https://github.com/sindrets/diffview.nvim
Plug 'sindrets/diffview.nvim'

" Telescope
" https://github.com/nvim-telescope/telescope.nvim#getting-started
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'kyazdani42/nvim-web-devicons'

Plug 'rmagatti/auto-session'
Plug 'rmagatti/session-lens'

" Vim Glow -> markdown preview
" https://github.com/ellisonleao/glow.nvim
Plug 'ellisonleao/glow.nvim'

" cheat.sh
" https://github.com/dbeniamine/cheat.sh-vim
" Use with <Leader>KK, <Leader>KP, <Leader>KR, <Leader>KC
Plug 'dbeniamine/cheat.sh-vim'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" Coc config from https://eliasjuremalm.com/blog/how-to-get-started-with-vim-for-web-development-in-2021
let g:coc_global_extensions = [
  \ 'coc-tsserver'
  \ ]

if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

" Typescript start ------------------------------
" set filetypes as typescriptreact
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact

" dark red
hi tsxTagName guifg=#E06C75
hi tsxComponentName guifg=#E06C75
hi tsxCloseComponentName guifg=#E06C75

" orange
hi tsxCloseString guifg=#F99575
hi tsxCloseTag guifg=#F99575
hi tsxCloseTagName guifg=#F99575
hi tsxAttributeBraces guifg=#F99575
hi tsxEqual guifg=#F99575

" yellow
hi tsxAttrib guifg=#F8BD7F cterm=italic

" light-grey
hi tsxTypeBraces guifg=#999999
" dark-grey
hi tsxTypes guifg=#666666

"------------------------------ Typescript 


" General stuff ------------------------------

let mapleader = " "


syntax enable
set number
set shiftwidth=4
set tabstop=4
set ignorecase
set smartindent
set cursorline
set updatetime=300
set signcolumn=yes

" Autosave on focus loss
:au FocusLost * :wa
colorscheme tokyonight-night
" colorscheme tokyonight-storm
" colorscheme tokyonight-day
" Yank and paste with the system clipboard
set clipboard=unnamedplus
" ----------------------------- General stuff

"  Binds ----------------------------------
nnoremap <f7> :ZenMode<CR>
nnoremap <f8> :Centerpad 50 10<CR>
nnoremap <C-Tab> gt
nnoremap <S-C-Tab> gT
nnoremap <F4> :q<CR>
nnoremap <leader>t <cmd>tabnew<cr>

" Telescope: Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fs <cmd>Telescope session-lens search_session<cr>

" Coc:::::::::::::::::::::::
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" use <c-space>for trigger completion
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <Tab> coc#pum#confirm()

nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')


" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" TODO set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')

" Show commands.
"nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>

" :::::::::::::::Coc

nnoremap <leader>p :Glow<CR>
"  ---------------------------------- Binds

" NERDTree stuff ----------------------------
nnoremap <f1> :NERDTreeToggle<CR>
nnoremap <f2> :NERDTree ~/Nextcloud/Notes<CR>
" Close NERDtree after opening file
let NERDTreeQuitOnOpen = 1
" Close last remaining tab if it's nerdtree
" autocmd bufenter * if (winnr(“$”) == 1 && exists(“b:NERDTreeType”) && b:NERDTreeType == “primary”) | q | endif

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
" ---------------------------- NERDTree stuff
