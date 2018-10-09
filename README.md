# Trailer Trash for Vim

Eradicate unwanted whitespace at the end of the line in Vim.

This plugin will highlight trailing whitespace at the end of the line. This is done in a polite way:

 * You are not currently editing that line (prevents highlighting it as you type)
 * You are not in insert mode

 It also introduces a `:TrailerTrim` command that will strip all the trailing white space from a file (or range). This is done in a polite way:

 * Places the cursor back where is started
 * Resets the search highlight back to what it was

TrailerTrash defines a `:TrailerToggle` command to stop showing unwanted whitespace, for those projects where you don't want to start fighting it.

As always, Trailer Trash is polite.


### Ignoring Specific file types

You can ignore specific file types by adding an exclude list to your `.vimrc` file. If you have any specific types that should always be ignored please send a pull request or open an issue.

    let g:trailertrash_blacklist = ['__Calendar', '^http:']

### Styling TrailerTrash

You can modify the appearance of TrailerTrash with the `hi UnwantedTrailerTrash` setting.

For example, you can set the background of all trailing trash to red with the following:

    hi UnwantedTrailerTrash guibg=red ctermbg=red

### Disabling TrailerTrash

In most cases, if you want to hide the highlighting you can simply call `:TrailerHide`, and toggle it back on at any time.

If you want something more extreme, and want stop the underlying mechnism from working all together you can clear the `2match` in vim:

TrailerTrash uses `2match` ([vimdoc](http://vimdoc.sourceforge.net/htmldoc/pattern.html#match-highlight)) to define a highlight pattern. If you would like to disable it you can call `2match none`. This works great in plugins that provide you a hook to customize buffers, such as Unite's `unite_settings()`

```viml
function! s:unite_settings()
  2match none
endfunction
```


----

This is [not](http://blog.kamil.dworakowski.name/2009/09/unobtrusive-highlighting-of-trailing.html) [an](http://vim.wikia.com/wiki/Remove_unwanted_spaces) [original](http://vimcasts.org/episodes/tidying-whitespace/) [idea](http://vim.wikia.com/wiki/Highlight_unwanted_spaces), I just gathered tips and ideas from around the web and bundled them together in a way I liked.

# License

Copyright (c) Christopher Sexton. Distributed under the same terms as Vim itself. See `:help license`.
