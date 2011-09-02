" Vim syntax file
"
" Language:howm
" Maintainer:fuenor@gmail.com
" Last Change:2011-06-06 21:53

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

hi link txtUrl  Underlined
hi link txtFile Underlined

syn match txtUrl  "\(howm\|rel\|https\|http\|ftp\|file\):[-0-9a-zA-Z;/?:@&=+$,_.!~*'()%#]\+"
syn match txtFile '\([A-Za-z]:[/\\]\|\~\/\)[-0-9a-zA-Z;/?:@&=+$,_.!~*'()%{}[\]\\]\+'

syn match txtFile '\[:\?&\?\zs\([A-Za-z]:[/\\]\|\~\/\)[^:]\+\ze:[^\]]*]'
syn match txtUrl  '\[:\?&\?\zs\(howm\|rel\|https\|http\|ftp\|file\)://[^:]\+\ze:[^\]]*]'

" for changelog
if exists('b:current_syntax') && b:current_syntax == "changelog"
  syn region	changelogFiles	start="^\s\+[+*]\s" end=":\s" end="^$" contains=changelogBullet,changelogColon,changelogError,howmSchedule,howmDeadline,howmTodo,howmReminder,howmTodoUD,howmFinished keepend
endif

