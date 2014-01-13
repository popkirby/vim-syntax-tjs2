" Vim syntax file
" Language: TJS2
" Maintainer: popkirby <popkirby@gmail.com>
" Last Change: 2012 Mar 5
" Remark: Included by kag3.vim
" Changes: First submission.
"
" TODO:
"  - Add Dictionaly syntax


if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif
  let main_syntax='tjs2'
endif

if version < 508
  command! -nargs=+ TJS2HiLink hi link <args>
else
  command! -nargs=+ TJS2HiLink hi def link <args>
endif

syntax case match

" keyword definitions
syntax keyword tjs2Conditional      if else switch
syntax keyword tjs2Repeat           while for do
syntax keyword tjs2Boolean          true false
syntax keyword tjs2Constant         null undefined void Infinity NaN
syntax keyword tjs2Identifier       this super global var
syntax keyword tjs2Operator         new invalidate isvalid delete typeof instanceof incontextof
syntax keyword tjs2Type             int real string
syntax keyword tjs2Statement        return with
syntax keyword tjs2Exceptions       throw try catch
syntax keyword tjs2Label            case default
syntax keyword tjs2ClassDecl        extends
syntax keyword tjs2ClassDecl        class
syntax keyword tjs2Branch           break continue
syntax match   tjs2VarArg           "\.\.\."
syntax keyword tjs2Property         property
syntax keyword tjs2PropDecl         setter getter
syntax keyword tjs2GlobalObjects    Exception Array Dictionary Date Math RegExp
syntax keyword tjs2Reserved         const debugger export enum finally goto import in import octet protected private public synchronized static

syntax cluster tjs2Top add=tjs2Conditional,tjs2Repeat,tjs2Boolean,tjs2Constant,tjs2Typedef,tjs2Operator
syntax cluster tjs2Top add=tjs2Type,tjs2Statement,tjs2Exceptions,tjs2Label,tjs2ClassDecl,tjs2Branch
syntax cluster tjs2Top add=tjs2VarArg,tjs2Property,tjs2PropDecl,tjs2Reserved

" Comments
syntax region  tjs2Comment          start="/\*" end="\*/" contains=tjs2Comment 
syntax match   tjs2LineComment      "//.*"
syntax match   tjs2Comment          "/\*\*/"

syntax cluster tjs2Top add=tjs2Comment,tjs2LineComment


" Strings and constants
syntax case ignore
syntax match   tjs2SpecialChar      contained "\\\([\\\"'abfnrtv]\|[xX]\x\{4\}\)"
syntax region  tjs2StringD          start=+"+ end=+"+ contains=tjs2SpecialChar
syntax region  tjs2StringS          start=+'+ end=+'+ contains=tjs2SpecialChar

syntax match   tjs2SpecialChar2     contained "\\[&\$]"
syntax region  tjs2EvaluableString  contained start="${" end="}" contains=@tjs2Top 
syntax region  tjs2EvaluableString  contained start="&" end=";" contains=@tjs2Top
syntax region  tjs2StringAtD        start=+@"+ end=+"+ contains=tjs2SpecialChar,tjs2SpecialChar2,tjs2EvaluableString
syntax region  tjs2StringAtS        start=+@'+ end=+'+ contains=tjs2SpecialChar,tjs2SpecialChar2,tjs2EvaluableString

syntax match   tjs2OctetNumber      contained "\<\x\x\>"
syntax region  tjs2Octet            start="<%" end="%>" contains=tjs2OctetNumber

syntax match   tjs2Number           "-\=\<\d\+\>"
syntax match   tjs2Number           "\(\<\d\+\.\d\+\|\.\d\+\|\d\+\)\([eE][-+]\=\d\+\)\="
syntax match   tjs2Number           "\<\(0[0-7]\+\|0[xX]\x\+\|0[bB][0-1]\+\)\(p\d\+\)\=\>"
syntax match   tjs2Number           "\<\(0[0-7]\+\|0[xX]\x\+\.\x+\|0[bB][0-1]\+\.[0-1]\+\)\(p\d\+\)\=\>"

syntax case match
syntax region  tjs2RegExp           start=+/\(\*\|/\)\@!+ skip=+\\\\\|\\/+ end=+/[gil]\{,3}+

syntax cluster tjs2Top              add=tjs2StringD,tjs2StringS,tjs2StringAtS,tjs2StringAtD
syntax cluster tjs2Top              add=tjs2Octet,tjs2Number,tjs2RegExp


" Braces
syntax match   tjs2Braces           "[{}\[\]]\|%\["
syntax match   tjs2Parens           "[()]"
syntax match   tjs2OpSymbols        "=\{1,3}\|!==\|!=\|<\|>\|>=\|<=\|<->\|+=\|-=\|&=\||=\|^=\|%=\|/=\|\\=\|\*=\|||=\|&&=\|>>=\|<<=\|>>>=\|--\|++\|=>"
syntax match   tjs2EndColons        "[;,]"
syntax match   tjs2LogicSymbols     "\(&&\)\|\(||\)"

syntax cluster tjs2Top              add=tjs2EndColons

syntax region  tjs2Bracket          matchgroup=tjs2Bracket      transparent keepend start="\[\|%\["  end="\]" contains=@tjs2Top,tjs2Braces,tjs2Parens,tjs2OpSymbols,tjs2LogicSymbols,tjs2Bracket,tjs2Paren,tjs2Block,tjs2ParensErrB,tjs2ParensErrC
syntax region  tjs2Paren            matchgroup=tjs2Paren        transparent keepend start="("        end=")"  contains=@tjs2Top,tjs2Braces,tjs2Parens,tjs2OpSymbols,tjs2LogicSymbols,tjs2Bracket,tjs2Paren,tjs2Block,tjs2ParensErrA,tjs2ParensErrC
syntax region  tjs2Block            matchgroup=tjs2Block        transparent keepend start="{"        end="}"  contains=@tjs2Top,tjs2Braces,tjs2Parens,tjs2OpSymbols,tjs2LogicSymbols,tjs2Bracket,tjs2Paren,tjs2Block,tjs2ParensErrA,tjs2ParensErrB

syntax match   tjs2ParensError      ")\|}\|\]"
syntax match   tjs2ParensErrA       contained "\]"
syntax match   tjs2ParensErrB       contained ")"
syntax match   tjs2ParensErrC       contained "}"


if main_syntax == "tjs2"
  syntax sync clear
"  syntax sync ccomment tjs2Comment minlines=200
  syntax sync match tjs2Highlight grouphere tjs2Block /{/
endif

syntax keyword tjs2Function         function
syntax cluster tjs2Top add=tjs2Function

if version >= 508 || !exists("did_tjs2_syn_inits")
  if version < 508
    let did_tjs2_syn_inits = 1
  endif

  TJS2HiLink tjs2EndColons          Operator
  TJS2HiLink tjs2OpSymbols          Operator
  TJS2HiLink tjs2LogicSymbols       Boolean
  TJS2HiLink tjs2Braces             Function
  TJS2HiLink tjs2Parens             Operator

  TJS2HiLink tjs2Function           Function
  TJS2HiLink tjs2Conditional        Conditional
  TJS2HiLink tjs2Repeat             Repeat
  TJS2HiLink tjs2Boolean            Boolean
  TJS2HiLink tjs2Constant           Constant
  TJS2HiLink tjs2Identifier         Identifier
  TJS2HiLink tjs2Operator           Operator
  TJS2HiLink tjs2Type               Type
  TJS2HiLink tjs2Statement          Statement
  TJS2HiLink tjs2Exceptions         Exception
  TJS2HiLink tjs2Label              Label
  TJS2HiLink tjs2ClassDecl          StorageClass
  TJS2HiLink tjs2Branch             Conditional
  TJS2HiLink tjs2VarArg             Function
  TJS2HiLink tjs2Property           Structure
  TJS2HiLink tjs2PropDecl           StorageClass
  TJS2HiLink tjs2Reserved           Error
  TJS2HiLink tjs2Comment            Comment
  TJS2HiLink tjs2LineComment        Comment
  TJS2HiLink tjs2SpecialChar        SpecialChar
  TJS2HiLink tjs2StringD            String
  TJS2HiLink tjs2StringS            String
  TJS2HiLink tjs2SpecialChar2       SpecialChar
  TJS2HiLink tjs2EvaluableString    SpecialChar
  TJS2HiLink tjs2StringAtD          String
  TJS2HiLink tjs2StringS            String
  TJS2HiLink tjs2OctetNumber        Number
  TJS2HiLink tjs2Octet              SpecialChar
  TJS2HiLink tjs2Number             Number
  TJS2HiLink tjs2RegExp             String
  TJS2HiLink tjs2GlobalObjects      Special
  TJS2HiLink tjs2ParensError        Error
  TJS2HiLink tjs2ParensErrA         Error
  TJS2HiLink tjs2ParensErrB         Error
  TJS2HiLink tjs2ParensErrC         Error
endif

delcommand TJS2HiLink

let b:current_syntax = "tjs2"
if main_syntax == 'tjs2'
  unlet main_syntax
endif

