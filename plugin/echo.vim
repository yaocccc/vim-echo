if exists('s:loaded') | finish | endif
let s:loaded = 1

let s:default = {
    \ 'vim': 'echo("[ECHO]:" . [ECHO])',
    \ 'go': 'fmt.Printf("[ECHO] %s: %+v\n", "[FILE]", [ECHO])',
    \ 'c': 'printf("[ECHO] %s: %s\n", "[FILE]", [ECHO]);',
    \ 'js': 'console.log(`[ECHO] [FILE]: ${[ECHO]}`);',
    \ 'ts': 'console.log(`[ECHO] [FILE]: ${[ECHO]}`);',
    \ 'vue': 'console.log(`[ECHO] [FILE]: ${[ECHO]}`);',
    \ 'sh': 'echo "[ECHO] [FILE]: $[ECHO]"',
    \ 'zsh': 'echo "[ECHO] [FILE]: $[ECHO]"',
    \ }
let s:vim_echo_by_file = get(g:, 'vim_echo_by_file', s:default)

func s:get_express()
    let l:express = get(s:vim_echo_by_file, expand('%:t'), "nop")                                   " 匹配文件名   从g:vim_echo_by_file中获取
    let l:express = l:express ==# "nop" ? get(s:vim_echo_by_file, expand('%:e'), "nop") : l:express " 匹配文件后缀 从g:vim_echo_by_file中获取
    let l:express = l:express ==# "nop" ? get(s:default, expand('%:e'), "nop") : l:express          " 匹配文件后缀 从s:default中获取
    let l:express = l:express ==# "nop" ? "print('[ECHO] [FILE]: ' .. [ECHO])" : l:express          " 默认: print('[ECHO] [FILE]: ' .. [ECHO])
    return l:express
endf

func s:get_tag()
    let old = getreg('"')
    normal! gvy
    let tag = getreg('"')
    call setreg('"', old)
    return tag
endf

func s:echo()
    let line = line('.')
    let tag = s:get_tag()
    let space = substitute(getline(line), '\v(^\s*).*', '\1', '')
    let express = s:get_express()
    let filename = expand('%:t')  " Get current filename
    let express = substitute(express, '\[FILE\]', filename, 'g')
    let express = substitute(express, '\[ECHO\]', tag, 'g')
    call appendbufline('%', line, space . express)
endf

command! VECHO call <SID>echo()
