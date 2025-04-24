if exists('s:loaded') | finish | endif
let s:loaded = 1

let s:default = {
    \ 'vim': 'echo("[RANDOM] [ECHO] [FILE]:" . [ECHO])',
    \ 'go': 'fmt.Printf("[%04d] [ECHO] %s: %+v\n", [RANDOM], "[FILE]", [ECHO])',
    \ 'c': 'printf("[%04d] [ECHO] %s: %s\n", [RANDOM], "[FILE]", [ECHO]);',
    \ 'js': 'console.log(`[[RANDOM]] [ECHO] [FILE]: ${[ECHO]}`);',
    \ 'ts': 'console.log(`[[RANDOM]] [ECHO] [FILE]: ${[ECHO]}`);',
    \ 'vue': 'console.log(`[[RANDOM]] [ECHO] [FILE]: ${[ECHO]}`);',
    \ 'sh': 'echo "[[RANDOM]] [ECHO] [FILE]: $[ECHO]"',
    \ 'zsh': 'echo "[[RANDOM]] [ECHO] [FILE]: $[ECHO]"',
    \ 'python': 'print(f"[{random.randint(1000,9999)}] [ECHO] [FILE]: {[ECHO]}")',
    \ }
let s:vim_echo_by_file = get(g:, 'vim_echo_by_file', s:default)

func s:get_express()
    let l:express = get(s:vim_echo_by_file, expand('%:t'), "nop")
    let l:express = l:express ==# "nop" ? get(s:vim_echo_by_file, expand('%:e'), "nop") : l:express
    let l:express = l:express ==# "nop" ? get(s:default, expand('%:e'), "nop") : l:express
    let l:express = l:express ==# "nop" ? "print(f'[[RANDOM]] [ECHO] [FILE]: {[ECHO]}')" : l:express
    return l:express
endf

func s:get_tag()
    let old = getreg('"')
    normal! gvy
    let tag = getreg('"')
    call setreg('"', old)
    return tag
endf

func s:generate_random()
    return str2nr(matchstr(reltimestr(reltime()), '\v\.\zs\d+')[1:4])
endf

func s:echo()
    let line = line('.')
    let tag = s:get_tag()
    let space = substitute(getline(line), '\v(^\s*).*', '\1', '')
    let express = s:get_express()
    let filename = expand('%:t')
    let random_num = s:generate_random()
    
    " Replace placeholders in specific order
    let express = substitute(express, '\[FILE\]', filename, 'g')
    let express = substitute(express, '\[RANDOM\]', random_num, 'g')
    let express = substitute(express, '\[ECHO\]', tag, 'g')
    let express = substitute(express, '\[ECHO\]', tag, 'g') " Second replacement for consistency
    
    call appendbufline('%', line, space . express)
endf

command! VECHO call <SID>echo()
