" Vim syntax file
"
" Language:howm
" Maintainer:fuenor@gmail.com
" Last Change:2011-06-06 21:52

if &background == 'dark'
  hi howmTodo     ctermfg=Yellow      guifg=Yellow
  hi howmTodoUD   ctermfg=Magenta     guifg=LightRed
  hi howmSchedule ctermfg=Green       guifg=Green
  hi howmReminder ctermfg=Cyan        guifg=Cyan
  hi howmFinished ctermfg=DarkGrey    guifg=DarkGrey
else
  hi howmTodo     ctermfg=DarkYellow  guifg=DarkGoldenrod
  hi howmTodoUD   ctermfg=DarkMagenta guifg=DarkMagenta
  hi howmSchedule ctermfg=DarkGreen   guifg=DarkGreen
  hi howmReminder ctermfg=Blue        guifg=Blue
  hi howmFinished ctermfg=DarkGrey    guifg=Grey
endif
hi howmDeadline ctermfg=Red     guifg=Red
hi howmHoliday  ctermfg=Magenta guifg=Magenta
hi howmSpecial  ctermfg=Red     guifg=Red
hi link howmNormal Normal

hi link actionlockDate Underlined
hi link actionlockTime Constant

if exists('g:QFixHowm_Date')
  exec 'syntax match actionlockDate contained "'.g:QFixHowm_Date.'" '
else
  syntax match actionlockDate contained "\d\{4}-\d\{2}-\d\{2}"
endif
syntax match actionlockTime  contained "\d\d:\d\d\(:\d\d\)\?"

let s:pattern = '\[\d\{4}-\d\{2}-\d\{2}\( \d\{2}:\d\{2}\)\?]'
if exists('g:QFixHowm_Date')
  let s:pattern = '\['.g:QFixHowm_Date.'\( \d\{2}:\d\{2}\)\?]'
endif
let s:epat = '\{1,3}\((\([0-9]\+\)\?\([-+*]\?\c\(\(Sun\|Mon\|Tue\|Wed\|Thu\|Fri\|Sat\|Hdy\)\?\([-+]\d\+\)\?\)\?\))\)\?\d*'
exe 'syntax match howmNormal   "^'   .s:pattern.'"               contains=actionlockDate,actionlockTime'
exe 'syntax match howmSchedule "^\s*'.s:pattern.'@' . s:epat .'" contains=actionlockDate,actionlockTime'
exe 'syntax match howmDeadline "^\s*'.s:pattern.'!' . s:epat .'" contains=actionlockDate,actionlockTime'
exe 'syntax match howmTodo     "^\s*'.s:pattern.'+' . s:epat .'" contains=actionlockDate,actionlockTime'
exe 'syntax match howmReminder "^\s*'.s:pattern.'-' . s:epat .'" contains=actionlockDate,actionlockTime'
exe 'syntax match howmTodoUD   "^\s*'.s:pattern.'\~'. s:epat .'" contains=actionlockDate,actionlockTime'
exe 'syntax match howmFinished "^\s*'.s:pattern.'\."'
let s:pattern = '&\[\d\{4}-\d\{2}-\d\{2}\( \d\{2}:\d\{2}\)\?]\.'
if exists('g:QFixHowm_Date')
  let s:pattern = '&\['.g:QFixHowm_Date.'\( \d\{2}:\d\{2}\)\?]\.'
endif
exe 'syntax match howmFinished "'.s:pattern.'"'

syntax match howmUrl  "\(howm\|rel\|https\|http\|ftp\|file\):[-0-9a-zA-Z;/?:@&=+$,_.!~*'()%#]\+"
syntax match howmTxt '\([A-Za-z]:[/\\]\|\~\/\)[-0-9a-zA-Z;/?:@&=+$,_.!~*'()%{}[\]\\]\+'

syntax match howmUrl  '\[:\?&\?\zs\(howm\|rel\|https\|http\|ftp\|file\)://[^:]\+\ze:[^\]]*]'
syntax match howmTxt '\[:\?&\?\zs\([A-Za-z]:[/\\]\|\~\/\)[^:]\+\ze:[^\]]*]'

hi link howmUrl  Underlined
hi link howmTxt  Underlined

hi link outlineTitle                Type
hi link actionlockLink              Underlined
hi link actionlockKeyword           Underlined
hi link actionlockMacroAction       Underlined
hi link actionlockMacroActionDefine howmFinished
hi link actionlockList              Type
hi link recentmodeDate              howmFinished
hi link howmTitle                   Title
hi link howmTitleDesc               Special
hi link howmCategory                Label
hi link howmEntrySeparator          Special

if exists('g:QFixHowm_Title') && exists('g:QFixHowm_EscapeTitle')
  let s:QFixHowm_Title = escape(g:QFixHowm_Title, g:QFixHowm_EscapeTitle)
  exe 'syn region howmTitle start="^'.s:QFixHowm_Title.'" end="$" contains=howmTitleDesc,howmCategory'
  exe 'syn match howmTitleDesc contained "^'.s:QFixHowm_Title.'"'
  syn match howmCategory contained +\(\[.\{-}\]\)\++
  exec 'syntax match outlineTitle "^'.s:QFixHowm_Title.'\{2,}"'
endif

if exists('g:QFixHowm_MergeEntrySeparator')
  exe 'syntax match howmEntrySeparator ' . '"^'.g:QFixHowm_MergeEntrySeparator.'"'
endif
if exists('g:QFixHowm_Link')
  exe 'syntax match actionlockLink ' . '"'.g:QFixHowm_Link.'[^[:return:]].*"'
endif
if exists('g:QFixHowm_keyword') && g:QFixHowm_keyword != ''
  exe 'syntax match actionlockKeyword "\V\%('.g:QFixHowm_keyword.'\)"'
endif
if exists('g:QFixHowm_MacroActionKey') && exists('g:QFixHowm_MacroActionPattern')
  if g:QFixHowm_MacroActionKey != '' && g:QFixHowm_MacroActionPattern != ''
    exe 'syntax match actionlockMacroAction "^.*'.g:QFixHowm_MacroActionPattern.'.*$" contains=actionlockMacroActionDefine'
    exe 'syntax match actionlockMacroActionDefine "'.g:QFixHowm_MacroActionPattern.'.*$"'
  endif
endif

syntax match actionlockList "{[- *_]}"

