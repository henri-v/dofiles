" Copy into e.g. ~/.vim/syntax/abba.vim and set the file type (see
" filetype.vim)
syntax case match
syntax keyword Type int bool char float string const pointer
syntax keyword Structure record map stack vector
syntax keyword Conditional if then elsif else
syntax keyword Repeat for foreach while loop exit
syntax keyword Keyword end module is extern of initially internal procedure
    \ function import uses begin with do return returns in out val
syntax keyword Typedef type
syntax keyword Operator not div mod and or convert
syntax keyword Function ord chr len print println read readln
syntax keyword Statement eval
syntax keyword Boolean FALSE TRUE
syntax keyword Constant null
syntax match Comment "--.*$"
syntax region Comment start="{\*" end="\*}"
syntax match Number "\<[0-9]\+\>"
syntax match Number "\<[0-9]\+\.[0-9]\+\([Ee][-+]\?[0-9]\+\)\?\>"
syntax region String start=+"+ skip=+\\"+ end=+"\|$+ keepend contains=SpecialChar
syntax match Character "'.'"
syntax match Character "'\\.'" contains=SpecialChar
syntax match SpecialChar "\\."
