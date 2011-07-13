p4size  equ     p4end-p4load
p4padd  equ     1*pagsize-p4size
p4sizeT equ     p4endf-p4load



section code

org     p4load



section         code

p4end:          ds      p4padd,0
p4endf:         equ $

%if p4size > pagsize*1
   %warn "Page 8 boundary broken"
%endif

