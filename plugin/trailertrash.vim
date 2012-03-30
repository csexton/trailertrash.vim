" trailertrash.vim - Trailer Trash
" Maintainer:   Christopher Sexton
"
" Ideas taken from numerous places like:
" http://vim.wikia.com/wiki/Highlight_unwanted_spaces
" http://vimcasts.org/episodes/tidying-whitespace/
" http://blog.kamil.dworakowski.name/2009/09/unobtrusive-highlighting-of-trailing.html
" and more!

" Exit quickly when:
" - this plugin was already loaded (or disabled)
" - when 'compatible' is set
if exists("g:loaded_trailertrash") || &cp
  finish
endif
let g:loaded_trailertrash = 1

let s:cpo_save = &cpo
set cpo&vim

" Code {{{1
if &modifiable
    let g:hide_trailer = 0
else
    let g:hide_trailer = 1
endif

function! KillTrailerTrash()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

command! -bar -range=% Trim :call KillTrailerTrash()
"nmap <silent> <Leader><space> :call KillTrailerTrash()<CR>

function! HideTrailer()
    match none UnwantedTrailerTrash
    let g:hide_trailer = 1
endfunction

command! HideTrailer :call HideTrailer()

function! ShowTrailer()
    let g:hide_trailer = 0
endfunction

command! ShowTrailer :call ShowTrailer()

hi link UnwantedTrailerTrash ErrorMsg
au ColorScheme * hi link UnwantedTrailerTrash ErrorMsg
au BufEnter    * if g:hide_trailer == 0 | match UnwantedTrailerTrash /\s\+$/ | endif
au InsertEnter * if g:hide_trailer == 0 | match UnwantedTrailerTrash /\s\+\%#\@<!$/ | endif
au InsertLeave * if g:hide_trailer == 0 | match UnwantedTrailerTrash /\s\+$/ | endif

" }}}1

let &cpo = s:cpo_save

" vim:set ft=vim ts=8 sw=4 sts=4:


