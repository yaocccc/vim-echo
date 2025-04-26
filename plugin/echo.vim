if exists('s:loaded') | finish | endif
let s:loaded = 1

let s:default = {
    \ 'vim': 'echo("[DEBUG][[RANDOM]] [FILE]:[LINE] " . [ECHO])',
    \ 'go': 'fmt.Printf("[DEBUG][%04d] %s:%d %+v\n", [RANDOM], "[FILE]", [LINE], [ECHO])',
    \ 'c': 'printf("[DEBUG][%04d] %s:%d %s\n", [RANDOM], "[FILE]", [LINE], [ECHO]);',
    \ 'js': 'console.log(`[DEBUG][[RANDOM]] [FILE]:[LINE] ${[ECHO]}`);',
    \ 'ts': 'console.log(`[DEBUG][[RANDOM]] [FILE]:[LINE] ${[ECHO]}`);',
    \ 'vue': 'console.log(`[DEBUG][[RANDOM]] [FILE]:[LINE] ${[ECHO]}`);',
    \ 'sh': 'echo "[DEBUG][[RANDOM]] [FILE]:[LINE] $[ECHO]"',
    \ 'zsh': 'echo "[DEBUG][[RANDOM]] [FILE]:[LINE] $[ECHO]"',
    \ 'python': 'print(f"[DEBUG][[RANDOM]] [FILE]:[LINE] {[ECHO]}")',
    \ 'lua': 'print(string.format("[DEBUG][%04d] %s:%d %s", [RANDOM], "[FILE]", [LINE], [ECHO]))',
    \ }
let s:vim_echo_by_file = get(g:, 'vim_echo_by_file', s:default)

function! s:get_express() abort
    let l:file_name = expand('%:t')
    let l:file_ext = expand('%:e')
    
    let l:express = get(s:vim_echo_by_file, l:file_name, "nop")
    if l:express ==# "nop"
        let l:express = get(s:vim_echo_by_file, l:file_ext, "nop")
    endif
    if l:express ==# "nop"
        let l:express = get(s:default, l:file_ext, "nop")
    endif
    return l:express ==# "nop" ? 'print("[DEBUG][[RANDOM]] [FILE]:[LINE] [ECHO]")' : l:express
endfunction

function! s:get_visual_selection() abort
    try
        let l:old_reg = getreg('"')
        let l:old_regtype = getregtype('"')
        normal! gvy
        return getreg('"')
    finally
        call setreg('"', l:old_reg, l:old_regtype)
    endtry
endfunction

function! s:generate_random() abort
    " More reliable random number generation
    let l:time = reltimestr(reltime())
    let l:millis = matchstr(l:time, '\.\zs\d\+')
    if empty(l:millis)
        let l:millis = localtime()
    endif
    return str2nr(l:millis[-4:]) % 10000
endfunction

function! s:echo() abort range
    let l:current_line = line('.')
    let l:indent = matchstr(getline(l:current_line), '^\s*')
    let l:tag = s:get_visual_selection()
    if empty(l:tag)
        echohl WarningMsg | echo "No text selected" | echohl None
        return
    endif
    
    let l:express = s:get_express()
    let l:filename = expand('%:t')
    let l:random_num = s:generate_random()
    
    " Replace placeholders
    let l:express = substitute(l:express, '\[FILE\]', l:filename, 'g')
    let l:express = substitute(l:express, '\[LINE\]', l:current_line + 1, 'g')
    let l:express = substitute(l:express, '\[RANDOM\]', l:random_num, 'g')
    let l:express = substitute(l:express, '\[ECHO\]', l:tag, 'g')
    
    call append(l:current_line, l:indent . l:express)
endfunction

command! -range VECHO call <SID>echo()
