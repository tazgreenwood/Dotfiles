" Dracula Theme: v1.5.0 {{{
"
" https://github.com/zenorocha/dracula-theme
"
" Copyright 2016, All rights reserved
"
" Code licensed under the MIT license
" http://zenorocha.mit-license.org
"
" @author Trevor Heins <@heinst>
" @author Éverton Ribeiro <nuxlli@gmail.com>
" @author Derek Sifford <dereksifford@gmail.com>
" @author Zeno Rocha <hi@zenorocha.com>
scriptencoding utf8
" }}}

" Configuration: {{{

if v:version > 580
  highlight clear
  if exists('syntax_on')
    syntax reset
  endif
endif

let g:colors_name = 'zerodark'

if !(has('termguicolors') && &termguicolors) && !has('gui_running') && &t_Co != 256
  finish
endif

" Palette: {{{2

let s:fg          = ['#CCCCCC', 255]

let s:bglighter = ['#3a3a3a', 237]
let s:bglight   = ['#303030', 236]
let s:bg          = ['#242424', 235]
let s:bgdark    = ['#1c1c1c', 234]
let s:bgdarker  = ['#121212', 233]

let s:subtle    = ['#444444', 238]

let s:selection   = ['#364c3b', 65]
let s:comment     = ['#676767', 242]

let s:blue        = ['#49a6d2', 69]
let s:lightblue     = ['#88aed5',  110]
let s:orange    = ['#f07b3c', 208]
let s:lime      = ['#89f5a2', 121]
let s:purple    = ['#8b6ccf', 98]
let s:yellow    = ['#cdb943', 185]
let s:red       = ['#cc6666', 167]

let s:none      = ['NONE', 'NONE']

let g:dracula_palette = {
      \ 'fg': s:fg,
      \ 'bg': s:bg,
      \
      \ 'selection': s:selection,
      \ 'comment': s:comment,
      \
      \ 'blue': s:blue,
      \ 'lightblue': s:lightblue,
      \ 'lime': s:lime,
      \ 'orange': s:orange,
      \ 'purple': s:purple,
      \ 'red': s:red,
      \ 'yellow': s:yellow,
      \
      \ 'bglighter': s:bglighter,
      \ 'bglight': s:bglight,
      \ 'bgdark': s:bgdark,
      \ 'bgdarker': s:bgdarker,
      \ 'subtle': s:subtle,
      \}

" if has('nvim')
"   let g:terminal_color_0  = '#21222C'
"   let g:terminal_color_1  = '#FF5555'
"   let g:terminal_color_2  = '#50FA7B'
"   let g:terminal_color_3  = '#F1FA8C'
"   let g:terminal_color_4  = '#BD93F9'
"   let g:terminal_color_5  = '#FF79C6'
"   let g:terminal_color_6  = '#8BE9FD'
"   let g:terminal_color_7  = '#F8F8F2'
"   let g:terminal_color_8  = '#6272A4'
"   let g:terminal_color_9  = '#FF6E6E'
"   let g:terminal_color_10 = '#69FF94'
"   let g:terminal_color_11 = '#FFFFA5'
"   let g:terminal_color_12 = '#D6ACFF'
"   let g:terminal_color_13 = '#FF92DF'
"   let g:terminal_color_14 = '#A4FFFF'
"   let g:terminal_color_15 = '#FFFFFF'
" endif

" }}}2
" User Configuration: {{{2

if !exists('g:dracula_bold')
  let g:dracula_bold = 1
endif

if !exists('g:dracula_italic')
  let g:dracula_italic = 1
endif

if !exists('g:dracula_underline')
  let g:dracula_underline = 1
endif

if !exists('g:dracula_undercurl') && g:dracula_underline != 0
  let g:dracula_undercurl = 1
endif

if !exists('g:dracula_inverse')
  let g:dracula_inverse = 1
endif

if !exists('g:dracula_colorterm')
  let g:dracula_colorterm = 1
endif

"}}}2
" Script Helpers: {{{2

let s:attrs = {
      \ 'bold': g:dracula_bold == 1 ? 'bold' : 0,
      \ 'italic': g:dracula_italic == 1 ? 'italic' : 0,
      \ 'underline': g:dracula_underline == 1 ? 'underline' : 0,
      \ 'undercurl': g:dracula_undercurl == 1 ? 'undercurl' : 0,
      \ 'inverse': g:dracula_inverse == 1 ? 'inverse' : 0,
      \}

function! s:h(scope, fg, ...) " bg, attr_list, special
  let l:fg = copy(a:fg)
  let l:bg = get(a:, 1, ['NONE', 'NONE'])

  let l:attr_list = filter(get(a:, 2, ['NONE']), 'type(v:val) == 1')
  let l:attrs = len(l:attr_list) > 0 ? join(l:attr_list, ',') : 'NONE'

  " Falls back to coloring foreground group on terminals because
  " nearly all do not support undercurl
  let l:special = get(a:, 3, ['NONE', 'NONE'])
  if l:special[0] !=# 'NONE' && l:fg[0] ==# 'NONE' && !has('gui_running')
    let l:fg[0] = l:special[0]
    let l:fg[1] = l:special[1]
  endif

  let l:hl_string = [
        \ 'highlight', a:scope,
        \ 'guifg=' . l:fg[0], 'ctermfg=' . l:fg[1],
        \ 'guibg=' . l:bg[0], 'ctermbg=' . l:bg[1],
        \ 'gui=' . l:attrs, 'cterm=' . l:attrs,
        \ 'guisp=' . l:special[0],
        \]

  execute join(l:hl_string, ' ')
endfunction

function! s:Background()
  if g:dracula_colorterm || has('gui_running')
    return s:bg
  else
    return s:none
  endif
endfunction

"}}}2
" Zero Highlight Groups: {{{2

call s:h('ZeroBgLight', s:none, s:bglight)
call s:h('ZeroBgLighter', s:none, s:bglighter)
call s:h('ZeroBgDark', s:none, s:bgdark)
call s:h('ZeroBgDarker', s:none, s:bgdarker)

call s:h('ZeroFg', s:fg)
call s:h('ZeroFgUnderline', s:fg, s:none, [s:attrs.underline])
call s:h('ZeroFgBold', s:fg, s:none, [s:attrs.bold])

call s:h('ZeroComment', s:comment)
call s:h('ZeroCommentBold', s:comment, s:none, [s:attrs.bold])

call s:h('ZeroSelection', s:none, s:selection)

call s:h('ZeroSubtle', s:subtle)

" 'blue'
call s:h('ZeroBlue', s:blue)
call s:h('ZeroBlueBold', s:blue, s:none, [s:attrs.bold])
call s:h('ZeroBlueItalic', s:blue, s:none, [s:attrs.italic])
call s:h('ZeroBlueBoldItalic', s:blue, s:none, [s:attrs.bold, s:attrs.italic])
call s:h('ZeroBlueInverse', s:bg, s:blue)

" 'lightblue'
call s:h('ZeroLightBlue', s:lightblue)
call s:h('ZeroLightBlueBold', s:lightblue, s:none, [s:attrs.bold])
call s:h('ZeroLightBlueItalic', s:lightblue, s:none, [s:attrs.italic])
call s:h('ZeroLightBlueBoldItalic', s:lightblue, s:none, [s:attrs.bold, s:attrs.italic])
call s:h('ZeroLightBlueInverse', s:bg, s:lightblue)

" 'lime'
call s:h('ZeroLime', s:lime)
call s:h('ZeroLimeBold', s:lime, s:none, [s:attrs.bold])
call s:h('ZeroLimeItalic', s:lime, s:none, [s:attrs.italic])
call s:h('ZeroLimeBoldItalic', s:lime, s:none, [s:attrs.bold, s:attrs.italic])
call s:h('ZeroLimeInverse', s:bg, s:lime)

" 'orange'
call s:h('ZeroOrange', s:orange)
call s:h('ZeroOrangeBold', s:orange, s:none, [s:attrs.bold])
call s:h('ZeroOrangeItalic', s:orange, s:none, [s:attrs.italic])
call s:h('ZeroOrangeBoldItalic', s:orange, s:none, [s:attrs.bold, s:attrs.italic])
call s:h('ZeroOrangeInverse', s:bg, s:orange)

" 'purple'
call s:h('ZeroPurple', s:purple)
call s:h('ZeroPurpleBold', s:purple, s:none, [s:attrs.bold])
call s:h('ZeroPurpleItalic', s:purple, s:none, [s:attrs.italic])
call s:h('ZeroPurpleBoldItalic', s:purple, s:none, [s:attrs.bold, s:attrs.italic])
call s:h('ZeroPurpleInverse', s:bg, s:purple)

" 'red'
call s:h('ZeroRed', s:red)
call s:h('ZeroRedBold', s:red, s:none, [s:attrs.bold])
call s:h('ZeroRedItalic', s:red, s:none, [s:attrs.italic])
call s:h('ZeroRedBoldItalic', s:red, s:none, [s:attrs.bold, s:attrs.italic])
call s:h('ZeroRedInverse', s:bg, s:red)

" 'yellow'
call s:h('ZeroYellow', s:yellow)
call s:h('ZeroYellowBold', s:yellow, s:none, [s:attrs.bold])
call s:h('ZeroYellowItalic', s:yellow, s:none, [s:attrs.italic])
call s:h('ZeroYellowBoldItalic', s:yellow, s:none, [s:attrs.bold, s:attrs.italic])
call s:h('ZeroYellowInverse', s:bg, s:yellow)

call s:h('ZeroError', s:red, s:none, [], s:red)

call s:h('ZeroErrorLine', s:none, s:none, [s:attrs.undercurl], s:red)
call s:h('ZeroWarnLine', s:none, s:none, [s:attrs.undercurl], s:yellow)
call s:h('ZeroInfoLine', s:none, s:none, [s:attrs.undercurl], s:lightblue)

call s:h('ZeroTodo', s:lightblue, s:none, [s:attrs.bold, s:attrs.inverse])
call s:h('ZeroSearch', s:lime, s:none, [s:attrs.inverse])
call s:h('ZeroBoundary', s:comment, s:bgdark)
call s:h('ZeroLink', s:lightblue, s:none, [s:attrs.underline])

call s:h('ZeroDiffChange', s:none, s:none)
call s:h('ZeroDiffText', s:bg, s:orange)
call s:h('ZeroDiffDelete', s:red, s:bgdark)

" }}}2

" }}}
" User Interface: {{{

set background=dark

" Required as some plugins will overwrite
call s:h('Normal', s:fg, s:Background())
call s:h('StatusLine', s:none, s:bglighter, [s:attrs.bold])
call s:h('StatusLineNC', s:none, s:bglight)
call s:h('WildMenu', s:bg, s:purple, [s:attrs.bold])
call s:h('CursorLine', s:none, s:subtle)

hi! link ColorColumn  ZeroSelection
hi! link CursorColumn ZeroSelection
hi! link CursorLineNr ZeroYellow
hi! link DiffAdd      ZeroLime
hi! link DiffAdded    DiffAdd
hi! link DiffChange   ZeroDiffChange
hi! link DiffDelete   ZeroDiffDelete
hi! link DiffRemoved  DiffDelete
hi! link DiffText     ZeroDiffText
hi! link Directory    ZeroBlueBold
hi! link ErrorMsg     ZeroRedInverse
hi! link FoldColumn   ZeroSubtle
hi! link Folded       ZeroBoundary
hi! link IncSearch    ZeroLightBlueInverse
hi! link LineNr       ZeroComment
hi! link MoreMsg      ZeroFgBold
hi! link NonText      ZeroSubtle
hi! link Pmenu        ZeroBgDark
hi! link PmenuSbar    ZeroBgDark
hi! link PmenuSel     ZeroSelection
hi! link PmenuThumb   ZeroSelection
hi! link Question     ZeroFgBold
hi! link Search       ZeroSearch
hi! link SignColumn   ZeroComment
hi! link TabLine      ZeroBoundary
hi! link TabLineFill  ZeroBgDarker
hi! link TabLineSel   Normal
hi! link Title        ZeroBlueBold
hi! link VertSplit    ZeroBoundary
hi! link Visual       ZeroSelection
hi! link VisualNOS    Visual
hi! link WarningMsg   ZeroYellowInverse

" }}}
" Syntax: {{{

" Required as some plugins will overwrite
call s:h('MatchParen', s:fg, s:lightblue, [s:attrs.underline])
call s:h('Conceal', s:comment, s:bglight)

hi! link Comment ZeroComment
hi! link Underlined ZeroFgUnderline
hi! link Todo ZeroTodo

hi! link Error ZeroError
hi! link SpellBad ZeroErrorLine
hi! link SpellLocal ZeroWarnLine
hi! link SpellCap ZeroInfoLine
hi! link SpellRare ZeroInfoLine

hi! link Constant ZeroFg
hi! link String ZeroOrange
hi! link Character ZeroLime
hi! link Number ZeroLime
hi! link Boolean ZeroLime
hi! link Float ZeroLime

hi! link Identifier ZeroPurple
hi! link Function ZeroBlue

hi! link Statement ZeroPurple
hi! link Conditional ZeroPurple
hi! link Repeat ZeroPurple
hi! link Label ZeroOrange
hi! link Operator ZeroYellow
hi! link Keyword ZeroPurple
hi! link Exception ZeroPurple

hi! link PreProc ZeroComment
hi! link Include ZeroPurple
hi! link Define ZeroPurple
hi! link Macro ZeroPurple
hi! link PreCondit ZeroPurple
hi! link StorageClass ZeroPurple
hi! link Structure ZeroPurple
hi! link Typedef ZeroPurple

hi! link Type ZeroPurpleItalic

hi! link Delimiter ZeroFg

hi! link Special ZeroOrange
hi! link SpecialKey ZeroRed
hi! link SpecialComment ZeroLightBlueItalic
hi! link Tag ZeroLightBlue
hi! link helpHyperTextJump ZeroLink
hi! link helpCommand ZeroPurple
hi! link helpExample ZeroLime
hi! link helpBacktick Special

" HTML SPECIFIC CONFIGS
hi! link xmlEndTag ZeroBlue
hi! link xmlAttrib ZeroLightBlue
hi! link htmlTagName ZeroBlue
hi! link htmlEndTag ZeroBlue
hi! link htmlArg ZeroLightBlue

" JS SPECIFIC CONFIGS
hi! link jsThis ZeroPurple
hi! link jsFuncArgs ZeroBlue

"}}}

" vim: fdm=marker ts=2 sts=2 sw=2:

