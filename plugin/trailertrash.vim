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

function! s:TrailerKill(startline, endline)
    " Preparation: save last search, and cursor position.
    let pos=getpos(".")
    let _s=@/

    exec a:startline . ',' . a:endline. 's/\s\+$//e'

    " Cleanup: restore previous search history, and cursor position
    let @/=_s
    call setpos(".",pos)
endfunction

command! -bar -range=% TrailerTrim :call s:TrailerKill(<line1>,<line2>)

" User can override blacklist. This match as regexp pattern.
let s:blacklist = get(g:, 'trailertrash_blacklist', [
            \ '__Calendar',
            \ '\[unite\]',
            \])

function! s:ShouldMatch()
    if(!&modifiable)
        return 0
    endif

    if(g:show_trailertrash == 0)
        return 0
    endif

    let bufname = bufname('%')
    for ignore in s:blacklist
        if bufname =~ ignore
            return 0
        endif
    endfor

    " We should match
    return 1
endfunction

function! s:TrailerMatch(pattern)
    if(s:ShouldMatch())
        exe "2match" "UnwantedTrailerTrash" a:pattern
    else
        exe "2match" "UnwantedTrailerTrash" "/$^/"
    endif
endfunction

" Create autocommand group
augroup TrailerTrash
augroup END

function! s:TrailerHide()
    au! TrailerTrash ColorScheme *
    hi link UnwantedTrailerTrash Normal
    let g:show_trailertrash = 0
    call s:TrailerMatch('/\s\+$/')
endfunction

function! s:TrailerShow()
    hi link UnwantedTrailerTrash Error
    au TrailerTrash ColorScheme * hi link UnwantedTrailerTrash Error
    let g:show_trailertrash = 1
    call s:TrailerMatch('/\s\+$/')
endfunction

" Syntax
function! s:TrailerToggle()
    if (exists("g:show_trailertrash") && g:show_trailertrash == 1)
        call s:TrailerHide()
    else
        call s:TrailerShow()
    end
endfunction

command TrailerHide :call s:TrailerHide()
command TrailerShow :call s:TrailerShow()
command Trailer :call s:TrailerToggle()
call s:TrailerToggle()

"nmap <silent> <Leader>s :call ShowTrailerTrash()<CR>

" Matches
au BufEnter    * call s:TrailerMatch('/\s\+$/')
au InsertEnter * call s:TrailerMatch('/\s\+\%#\@<!$/')
au InsertLeave * call s:TrailerMatch('/\s\+$/')

" }}}1

let &cpo = s:cpo_save

" vim:set ft=vim ts=8 sw=4 sts=4:
