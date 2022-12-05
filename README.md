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

  [ECHO] will be replace to your selected context.

  Your selected context: hello
  fmt.Printf("[ECHO]: %s", [ECHO]) => fmt.Printf("hello: %s", hello);
  
  ---

  let s:vim_echo_by_ft = {
      \ 'vim': 'echo("[ECHO]:" . [ECHO])',
      \ 'go': 'fmt.Printf("[ECHO]: %+v\f", [ECHO])',
      \ 'js': 'console.log(`[ECHO]: ${[ECHO]}`)',
      \ 'ts': 'console.log(`[ECHO]: ${[ECHO]}`)',
      \ 'vue': 'console.log(`[ECHO]: ${[ECHO]}`)',
      \ 'sh': 'echo [ECHO]: $[ECHO]',
      \ }

  keymap
  e.g.
    vnoremap <silent> C :<c-u>VECHO<cr>
```
