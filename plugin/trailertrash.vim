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
"nmap <silent> <Leader>sa :call KillTrailerTrash()<CR>

" User can override blacklist. This match as regexp pattern.
let s:blacklist = get(g:, 'trailertrash_blacklist', [
\ '__Calendar',
\])

function! s:TrailerMatch(pattern)
    if(&modifiable)
        let bufname = bufname('%')
        for ignore in s:blacklist
            if bufname =~ ignore
                return
            endif
        endfor
        exe "match" "UnwantedTrailerTrash" a:pattern
    endif
endfunction

" Create autocommand group
augroup TrailerTrash
augroup END

" Syntax
function! ShowTrailerTrash()
    if exists("g:show_trailertrash") && g:show_trailertrash == 1
        hi UnwantedTrailerTrash guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
        au! TrailerTrash ColorScheme *
        let g:show_trailertrash = 0
    else
        hi link UnwantedTrailerTrash Error
        au TrailerTrash ColorScheme * hi link UnwantedTrailerTrash Error
        let g:show_trailertrash = 1
    end
endfunction
command Trailer :call ShowTrailerTrash()
call ShowTrailerTrash()
"nmap <silent> <Leader>s :call ShowTrailerTrash()<CR>

" Matches
au BufEnter    * call s:TrailerMatch('/\s\+$/')
au InsertEnter * call s:TrailerMatch('/\s\+\%#\@<!$/')
au InsertLeave * call s:TrailerMatch('/\s\+$/')

" }}}1

let &cpo = s:cpo_save

" vim:set ft=vim ts=8 sw=4 sts=4:
