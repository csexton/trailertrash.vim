# Trailer Trash for Vim

Remove and irradiate unwanted whitespace at the end of the line in Vim.

This plugin will highlight trailing whitespace at the end of the line. This is done in a polite way:

 * You are not currently editing that line (prevents highlighting it as you type)
 * Youy are not in insert mode

 It also introduces a `:Trim` command that will strip all the trailing white space from a file (or range). This is done in a polite way:

 * Places the cursor back where is started
 * Resets the search highlight back to what it was

As always, Trailer Trash is polite.


### Ignoring Specific file types

You can ignore specific file types by adding an exluude list to your `.vimrc` file. If you have any specific types that should always be ignoreed plese send a pull request or open an issue.

    let g:trailertrash_blacklist = ['__Calendar', '^http:']

----

This is [not](http://blog.kamil.dworakowski.name/2009/09/unobtrusive-highlighting-of-trailing.html) [an](http://vim.wikia.com/wiki/Remove_unwanted_spaces) [original](http://vimcasts.org/episodes/tidying-whitespace/) [idea](http://vim.wikia.com/wiki/Highlight_unwanted_spaces), I just gathered tips and ideas from around the web and bundled them together in a way I liked.
