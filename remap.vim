" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{,}} foldmethod=marker:
"map y <Plug>(operator-flashy)
"nmap Y <Plug>(operator-flashy)$
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
nnoremap <F5> mX:sp ~/.fortunes<CR>ggd/^--/<CR>Gp:wq<CR>'XGA<CR><Esc>p`X
" Preview markdown
nnoremap <C-p> :PreviewAuto<CR>
" no enter ex mode
nnoremap Q <Nop>
vnoremap < <gv
vnoremap > >gv
"nnoremap <c-v> "+p
vnoremap <c-c> "+y
nnoremap <expr> n  'Nn'[v:searchforward]
nnoremap <expr> N  'nN'[v:searchforward]
" yank to end
nnoremap Y y$
" clear highlight reset diff
nnoremap <silent> <C-u> :let @/=''<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR>
nnoremap gca :Gcommit -a -v<CR>
nnoremap gcc :Gcommit -v -- <C-R>=expand('%')<CR><CR>
"nnoremap gp  :Gpush --force<CR>

nnoremap gp :call <SID>gpush()<CR>

function! s:gpush()
  let branch = system('git rev-parse --abbrev-ref HEAD')
  if !v:shell_error
    execute 'Gpush origin '. substitute(branch, "\n$", '', '').' --force'
  endif
endfunction
"nnoremap <C-c> :echo 3<CR>
" remap <cr> when completing
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <C-w> <C-[>diwa
inoremap <C-h> <BS>
inoremap <C-d> <Del>
inoremap <C-u> <C-G>u<C-U>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-a> <Home>
inoremap <C-e> <End>

nmap [g <Plug>GitGutterPrevHunk
nmap ]g <Plug>GitGutterNextHunk


" easy align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" ale
nmap <silent> [k <Plug>(ale_previous_wrap)
nmap <silent> [j <Plug>(ale_next_wrap)

" window navigate {{
  nnoremap <C-l> <c-w>l
  nnoremap <C-h> <c-w>h
  nnoremap <C-j> <c-w>j
  nnoremap <C-k> <c-w>k
" }}

" command line alias {{
  cnoremap w!! w !sudo tee % >/dev/null
  cnoremap <C-p> <Up>
  cnoremap <C-n> <Down>
  cnoremap <C-j> <Left>
  cnoremap <C-k> <Right>
  cnoremap <C-b> <S-Left>
  cnoremap <C-f> <S-Right>
  cnoremap <C-a> <Home>
  cnoremap <C-e> <End>
  cnoremap <C-d> <Del>
  cnoremap <C-h> <BS>
" }}

" visual search {{
  "  In visual mode when you press * or # to search for the current selection
  vnoremap    <silent> * :call <SID>visualSearch('f')<CR>
  vnoremap    <silent> # :call <SID>visualSearch('b')<CR>

  function!   s:visualSearch(direction)
    let       l:saved_reg = @"
    execute   'normal! vgvy'
    let       l:pattern = escape(@", '\\/.*$^~[]')
    let       l:pattern = substitute(l:pattern, "\n$", '', '')
    if        a:direction ==# 'b'
      execute 'normal! ?' . l:pattern . "\<cr>"
    elseif    a:direction ==# 'f'
      execute 'normal! /' . l:pattern . '^M'
    endif
    let       @/ = l:pattern
    let       @" = l:saved_reg
  endfunction
" }}

" improved ultisnip complete {{
inoremap <C-l> <C-R>=SnipComplete()<CR>
func! SnipComplete()
  let line = getline('.')
  let start = col('.') - 1
  while start > 0 && line[start - 1] =~# '\k'
    let start -= 1
  endwhile
  let suggestions = []
  let snips =  UltiSnips#SnippetsInCurrentScope(0)
  for item in snips
    let trigger = item.key
    let entry = {'word': item.key, 'menu': item.description}
    call add(suggestions, entry)
  endfor
  if empty(suggestions)
    echohl Error | echon 'no match' | echohl None
  elseif len(suggestions) == 1
    let pos = getcurpos()
    if start == 0
      let str = trigger
    else
      let str = line[0:start - 1] . trigger
    endif
    call setline('.', str)
    let pos[2] = len(str) + 1
    call setpos('.', pos)
    call UltiSnips#ExpandSnippet()
  else
    call complete(start + 1, suggestions)
  endif
  return ''
endfunc
" }}

" meta keys {{
  vnoremap <M-c> "+y
  inoremap <M-v> <C-o>"+]p
  nnoremap <M-q> :qa!<cr>
  nnoremap <M-s> :wa<cr>
  inoremap <M-s> <C-o>:w<cr>
  nnoremap <M-1> 1gt
  nnoremap <M-2> 2gt
  nnoremap <M-3> 3gt
  nnoremap <M-4> 4gt
  nnoremap <M-5> 5gt
  inoremap <M-1> <C-o>1gt
  inoremap <M-2> <C-o>2gt
  inoremap <M-3> <C-o>3gt
  inoremap <M-4> <C-o>4gt
  inoremap <M-5> <C-o>5gt
" }}
