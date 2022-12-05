if exists('s:loaded') | finish | endif
let s:loaded = 1

let s:default = {
    \ 'vim': 'echo("[ECHO]:" . [ECHO])',
    \ 'go': 'fmt.Printf("[ECHO]: %+v\f", [ECHO])',
    \ 'js': 'console.log(`[ECHO]: ${[ECHO]}`)',
    \ 'ts': 'console.log(`[ECHO]: ${[ECHO]}`)',
    \ 'vue': 'console.log(`[ECHO]: ${[ECHO]}`)',
    \ 'sh': 'echo [ECHO]: $[ECHO]',
    \ }
let s:vim_echo_by_file = get(g:, 'vim_echo_by_file', s:default)

func s:echo()
    let line = line('.')
    let tag = getline(line)[col("'<") - 1 : col("'>") - 2]
    let space = substitute(getline(line), '\v(^\s*).*', '\1', '')
    let express = get(s:vim_echo_by_file, expand('%:t'), get(s:vim_echo_by_file, expand('%:e'), 'print([ECHO])'))
    call appendbufline('%', line, space . substitute(express, '\[ECHO\]', tag, 'g'))
endf

command! VECHO call <SID>echo()
