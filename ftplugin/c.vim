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
    let l:line = getline('.')
    let l:parts = split(l:line, '(')

    if len(l:parts) <= 1
        return
    endif

    normal 0f(ili

    while 1
        let l:line = getline('.')
        let l:parts = split(l:line, ',')

        if len(l:parts) > 1
            normal 0f,li
        else
            let l:line = getline('.')
            let l:parts = split(l:line, ')')

            if len(l:parts) <= 1
                return
            else
                normal 0f)i
                return
            endif
        endif
    endwhile
endfunction
command! CFixFunctionLength :call <SID>CFixFunctionLength()

nnoremap <leader>cf :CFixFunctionLength<cr>

setlocal textwidth=80
setlocal formatoptions=tcroqj
