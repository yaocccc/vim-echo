if exists('s:loaded') | finish | endif
let s:loaded = 1

let s:default = {
    \ 'vim': 'echo("[ECHO]:" . [ECHO])',
    \ 'go': 'fmt.Printf("[ECHO]: %+v\n", [ECHO])',
    \ 'js': 'console.log(`[ECHO]: ${[ECHO]}`)',
    \ 'ts': 'console.log(`[ECHO]: ${[ECHO]}`)',
    \ 'vue': 'console.log(`[ECHO]: ${[ECHO]}`)',
    \ 'sh': 'echo [ECHO]: $[ECHO]',
    \ 'zsh': 'echo [ECHO]: $[ECHO]',
    \ }
let s:vim_echo_by_file = get(g:, 'vim_echo_by_file', s:default)

func s:get_express()
    let l:express = get(s:vim_echo_by_file, expand('%:t'), "nop")                              " 匹配文件名   从g:vim_echo_by_file中获取
    let l:express = l:express ==# "nop" ? get(s:vim_echo_by_file, expand('%:e'), "nop") : l:express " 匹配文件后缀 从g:vim_echo_by_file中获取
    let l:express = l:express ==# "nop" ? get(s:default, expand('%:e'), "nop") : l:express          " 匹配文件后缀 从s:default中获取
    let l:express = l:express ==# "nop" ? "print([ECHO])" : l:express                                " 默认: print([ECHO])
    return l:express
endf

func s:echo()
    let line = line('.')
    let tag = getline(line)[col("'<") - 1 : col("'>") - (&selection == "exclusive" ? 2 : 1)]
    let space = substitute(getline(line), '\v(^\s*).*', '\1', '')
    let express = s:get_express()
    call appendbufline('%', line, space . substitute(express, '\[ECHO\]', tag, 'g'))
endf

command! VECHO call <SID>echo()
