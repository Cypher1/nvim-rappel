" Open a file in the OS
function! rappel#do_launch(call)
  execute '!'.a:call.' &> /dev/null &'
endfunction

" Run any REPL
function! rappel#call(mode)
  " Attempt to launch a program, run the file or start a REPL in Term
  let l:ft = &filetype
  if has_key(g:rappel#repls, l:ft)
    let l:settings=g:rappel#repls[l:ft]
    if has_key(l:settings, a:mode)
      let l:call=l:settings[a:mode]

      if a:mode ==# 'launch'
        call rappel#do_launch(l:call)
      else
        " Compile if needed
        if has_key(l:settings, 'compiler')
          let l:comp=l:settings['compiler']
          let l:call='echo \"Compiling...\"; '.l:comp.'; echo \"Running...\"; '.l:call
        endif

        " Run or start REPL
        execute g:rappel#term.' '.l:call
      endif
    else
      echo 'Action "'.a:mode.'" is not defined for '.l:ft.'.'
    endif
  else
    echo g:rappel#default
    echo g:rappel#launch
    echo a:mode
    if exists('g:rappel#default')
      echo "DEFAULT"
      if a:mode ==# 'launch'
        call g:rappel#do_launch(g:rappel#launch)
      else
        execute g:rappel#default
      endif
    else
      echo 'Could not find settings for '.l:ft.'.'
    endif
  endif
endfunction

" REPL settings
let g:rappel#repls={}

let g:rappel#repls.sh = {
\ 'repl': 'bash',
\ 'run': 'bash %',
\}
let g:rappel#repls.zsh = {
\ 'repl': 'zsh',
\ 'run': 'zsh %',
\}
let g:rappel#repls.python = {
\ 'repl': 'python -i %',
\ 'run': 'python %',
\}
let g:rappel#repls['javascript.jsx'] = {
\ 'repl': 'node',
\ 'run': 'node %',
\}
let g:rappel#repls.ruby = {
\'repl': 'ruby',
\ 'run': 'ruby %',
\}
let g:rappel#repls.perl = {
\ 'repl': 'perl',
\ 'run': 'perl %',
\}
let g:rappel#repls.lisp = {
\ 'repl': 'clisp',
\ 'run': 'clisp %',
\}
let g:rappel#repls.prolog = {
\ 'repl': 'swipl -s %',
\ 'run': 'swipl -s %',
\}
let g:rappel#repls.c = {
\ 'compiler': 'gcc % -Wall -O2',
\ 'run': './a.out',
\}
let g:rappel#repls.cpp = {
\ 'compiler': 'g++ % -Wall -O2 -std=c++14',
\ 'run': './a.out',
\}
let g:rappel#repls.rust = {
\ 'compiler': 'rustc %',
\ 'run': g:rappel#run_file_no_ext,
\}
let g:rappel#repls.swift = {
\ 'compiler': 'swiftc %',
\ 'run': g:rappel#run_file_no_ext,
\}
let g:rappel#repls.haskell = {
\ 'repl': 'ghci %',
\ 'compiler': 'ghc % -Wall',
\ 'run': g:rappel#run_file_no_ext,
\}

" Load in custom repls
if exists('g:rappel#custom_repls')
  for ft in keys(g:rappel#custom_repls)
    let g:rappel#repls[ft] = g:rappel#custom_repls[ft]
  endfor
endif
