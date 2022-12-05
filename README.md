# vim-echo

vim & nvim plugin for quickly print some thing base by filetype or filename

![avatar](./show.gif)

## usage

```plantext
  plug 'yaocccc/vim-echo'

  OR

  use { 'yaocccc/vim-echo', cmd = "VECHO" }
```

```options
  " [ECHO] will be replace to your selected context.
  e.g. 
    Your selected context: hello
    fmt.Printf("[ECHO]: %s", [ECHO]) => fmt.Printf("hello: %s", hello);

  " you can set custom config for difference filename or file ext, or you can set it is ''
  let s:vim_echo_by_file = {
      \ 'vim': 'echo("[ECHO]:" . [ECHO])',
      \ 'go': 'fmt.Printf("[ECHO]: %+v\f", [ECHO])',
      \ 'js': 'console.log(`[ECHO]: ${[ECHO]}`)',
      \ 'ts': 'console.log(`[ECHO]: ${[ECHO]}`)',
      \ 'vue': 'console.log(`[ECHO]: ${[ECHO]}`)',
      \ 'sh': 'echo [ECHO]: $[ECHO]',
      \ 'go.mod': '[ECHO]',
      \ 'json': '',
      \ }

  " keymap
  e.g.
    vnoremap <silent> C :<c-u>VECHO<cr>
```
