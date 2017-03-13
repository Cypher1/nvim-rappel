# Rappel
## REPLs for NeoVim

Use ```<leader>r``` to open the current file in a REPL
or ```<leader>R``` to open the current file in a REPL

Use ```<leader>l``` to open the current file with the OS

## Currently supports:
- c
- cpp
- haskell
- javascript
- lisp
- perl
- prolog
- python
- ruby
- rust
- sh
- swift
- zsh

## Settings

To set keybindings:
```
let g:rappel#repl_key   = '<leader>p'
let g:rappel#run_key    = '<leader>P'
let g:rappel#launch_key = '<leader>l'
```

To change what the bindings do:
```
let g:rappel#term       = 'vsp | term '
let g:rappel#launch     = 'chrome %'
let g:rappel#default    = g:rappel#term

```

To set up REPLs of your own (```%``` expands to the current file):
```
let g:rappel#custom_repls={
\ 'cpp': {
\   'compiler': 'g++ -Wall -Werror -O2 %',
\   'run':      './a.out',
\ },
\ 'markdown': {
\   'launch': 'marked % > %.html; chrome %.html'
\}
```

Adds the following commands

```
:RappelRepl   " Opens a Repl in a split
:RappelRun    " Runs the program a split
:RappelLaunch " Opens the file with the default program
```
