# vim-echo

vim & nvim plugin for quickly print some thing base by filetype or filename

## usage

```plantext
  plug 'yaocccc/vim-echo'

  OR

  use { 'yaocccc/vim-echo' }
```

```options
  let s:vim_echo_by_ft = {
      \ 'vim': 'echo(%s)',
      \ 'go': 'fmt.Println(%s)',
      \ 'js': 'console.log(%s)',
      \ 'ts': 'console.log(%s)',
      \ 'sh': 'echo $%s',
      \ }

  keymap
  e.g.
    vnoremap <silent> C :<c-u>VECHO<cr>
```
