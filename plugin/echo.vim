if exists('s:loaded') | finish | endif
let s:loaded = 1

let s:default = {
    \ 'vim': 'echo(%s)',
    \ 'go': 'fmt.Println(%s)',
    \ 'js': 'console.log(%s)',
    \ 'ts': 'console.log(%s)',
    \ 'sh': 'echo $%s',
    \ }
let s:echo_by_ft = get(g:, 'vim_echo_by_ft', s:default)

func s:echo()
    let line = line('.')
    let tag = getline(line)[col("'<") - 1 : col("'>") - 2]
    let space = substitute(getline(line), '\v(^\s*).*', '\1', '')
    let express = get(s:echo_by_ft, expand('%:t'), get(s:echo_by_ft, expand('%:e'), 'print(%s)'))
    let tagcount = count(express, '%s')
    if 
         \ tagcount == 1 | call appendbufline('%', line, printf(space . express, tag))
    elseif tagcount == 2 | call appendbufline('%', line, printf(space . express, tag, tag))
    elseif tagcount == 3 | call appendbufline('%', line, printf(space . express, tag, tag, tag))
    elseif tagcount == 4 | call appendbufline('%', line, printf(space . express, tag, tag, tag, tag))
    elseif tagcount == 5 | call appendbufline('%', line, printf(space . express, tag, tag, tag, tag, tag))
    endif
endf

command! VECHO call <SID>echo()
