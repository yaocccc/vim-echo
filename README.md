# vim-echo

vim & nvim plugin for quickly print some thing base by filetype or filename

## usage

```plantext
  plug 'yaocccc/vim-echo'

  OR

  use { 'yaocccc/vim-echo' }
```

```options
  e.g. 

  [ECHO] will be replace to you selected context.

  Your selected context: hello
  fmt.Printf("[ECHO]: %s", [ECHO]) => fmt.Printf("hello: %s", hello);
  
  ---

  let s:vim_echo_by_ft = {
      \ 'vim': 'echo([ECHO])',
      \ 'go': 'fmt.Printf([ECHO])',
      \ 'js': 'console.log([ECHO])',
      \ 'ts': 'console.log([ECHO])',
      \ 'vue': 'console.log([ECHO])',
      \ 'sh': 'echo $[ECHO]',
      \ }

  keymap
  e.g.
    vnoremap <silent> C :<c-u>VECHO<cr>
```
