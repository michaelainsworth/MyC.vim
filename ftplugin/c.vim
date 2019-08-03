" Only do this when not done yet for this buffer
if exists("b:did_ftplugin") && b:did_ftplugin == 1
  finish
endif

let b:did_ftplugin = 1

setlocal formatprg=astyle\ --style=allman\ --max-code-length=80

" Fixes the length of a function line, by changing from:
"
"     foo(1, 2, 3);
"
" to:
"
"     foo
"     (
"         1,
"         2,
"         3
"     );
function! s:CFixFunctionLength()
    norm 0vwh"sy0maf(ila$himbk:s/, /,/g'aV'b<.........2j>i('aV'b
endfunction

command! CFixFunctionLength :call <SID>CFixFunctionLength()

nnoremap <leader>cf :CFixFunctionLength<cr>

setlocal textwidth=80
setlocal formatoptions=tcroqj

