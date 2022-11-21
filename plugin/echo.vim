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
    let l = line('.')
    let t = getline(l)[col("'<") - 1 : col("'>") - 2]
    let s = substitute(getline(l), '\v(^\s*).*', '\1', '')
    let e = get(s:echo_by_ft, expand('%:t'), get(s:echo_by_ft, expand('%:e'), 'print(%s)'))
    echo [s . e, t]
    call appendbufline('%', l, printf(s . e, t))
endf

command! VECHO call <SID>echo()
