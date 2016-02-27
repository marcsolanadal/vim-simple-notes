" --------------------------------------------------------------
" vim-simple-notes
" --------------------------------------------------------------

let g:notes_directory="~/Dropbox/blog/notes"
let g:notes_extension=".md"

function! GetInput(prompt)
    let curline = getline('.')
    call inputsave()
    let input = input(a:prompt)
    call inputrestore()
    return input
endfunction

" TODO: show message if no notes available
function! ListNotes()
    let notes = {}
    let files = split(globpath(g:notes_directory, '*' . g:notes_extension), '\n')
    let num = 0
    for i in files
        let num += 1
        let notes[num] = i
        echo num . " - " . fnamemodify(i, ":t:r")
    endfor
    return notes
endfunction

function! CreateNote()
    let filename = GetInput('Filename: ')
    if !empty(filename)
        silent execute "!" . "mkdir -p " . g:notes_directory
        silent execute "vs " . g:notes_directory . "/" . filename . g:notes_extension
    endif
endfunction

" TODO: check valid note number
function! RemoveNote()
    let notes = ListNotes()
    let num = GetInput('Note to remove: ')
    if !empty(num) && filereadable(notes[num])
        silent execute "!rm -rf " . notes[num]
    endif
endfunction

function! SelectNote()
    let notes = ListNotes()
    let num = GetInput('Note: ')
    if !empty(num)
        silent execute "vs " . notes[num]
    endif
endfunction

nnoremap <leader>nc :call CreateNote()<CR>
nnoremap <leader>nr :call RemoveNote()<CR>
nnoremap <leader>nn :call SelectNote()<CR>

