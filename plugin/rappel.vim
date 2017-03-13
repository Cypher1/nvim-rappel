"  rappel.vim: A Read-Execute-Print-Loop (REPL) plugin for NeoVim
"  Last Change: Sun 12 Mar 2017
"  Maintainer:  Joshua Pratt <joshp@cse.unsw.edu.au>
"  Version:     0.1, for NeoVim 0.1.7+
"  URL: https://github.com/Cypher1/nvim-rappel

" allow user to prevent loading
" and prevent duplicate loading
if exists("loaded_rappel") || &cp
  finish
endif
let loaded_rappel = 1

" Defaults for rappel
let g:rappel#term       = get(g:, 'rappel#term',   'vsp | term ')
let g:rappel#launch     = get(g:, 'rappel#launch', 'xdg-open %')
let g:rappel#default    = get(g:, 'rappel#default', g:rappel#term)

let g:rappel#repl_key   = get(g:, 'rappel#repl_key',   '<leader>r')
let g:rappel#run_key    = get(g:, 'rappel#run_key',    '<leader>R')
let g:rappel#launch_key = get(g:, 'rappel#launch_key', '<leader>l')

let g:rappel#run_file_no_ext = "./`sed 's/\.[^\.]*$//' <<< '%'`"

" Create calls
command! RappelRepl   call rappel#call('repl')
command! RappelRun    call rappel#call('run')
command! RappelLaunch call rappel#call('launch')

execute 'nmap <silent> '.g:rappel#launch_key.' :RappelLaunch<CR>'
execute 'nmap <silent> '.g:rappel#run_key.' :RappelRun<CR>'
execute 'nmap <silent> '.g:rappel#repl_key.' :RappelRepl<CR>'
