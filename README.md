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
      \ 'go': 'fmt.Printf("[ECHO]: %+v\n", [ECHO])',
      \ 'js': 'console.log(`[ECHO]: ${[ECHO]}`)',
      \ 'ts': 'console.log(`[ECHO]: ${[ECHO]}`)',
      \ 'vue': 'console.log(`[ECHO]: ${[ECHO]}`)',
      \ 'sh': 'echo [ECHO]: $[ECHO]',
      \ 'zsh': 'echo [ECHO]: $[ECHO]',
      \ 'go.mod': '[ECHO]',
      \ 'json': '',
      \ }

  " keymap
  e.g.
    vnoremap <silent> C :<c-u>VECHO<cr>
```

## Support

<a href="https://www.buymeacoffee.com/yaocccc" target="_blank">
  <img src="https://github.com/yaocccc/yaocccc/raw/master/qr.png">
</a>

<br>

<a href="https://www.buymeacoffee.com/yaocccc" target="_blank">
  <img src="https://cdn.buymeacoffee.com/buttons/v2/default-violet.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 200px !important;" >
</a>
