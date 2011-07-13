


p2size  equ     p2end-p2load
p2padd  equ     3*pagsize-p2size
p2sizeT equ     p2endf-p2load



section code

org     p2load

gchars: equ $
        incbin  "select.tcf",8

gtitle: equ $
        incbin  "gtitle.tcf",8


section         code

p2end:          ds      p2padd,0
p2endf:         equ $

%if p2size > pagsize*3
   %warn "Page 234 boundary broken"
%endif

