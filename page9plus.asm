p5size  equ     p5end-p5load
p5padd  equ     16*pagsize-p5size
p5sizeT equ     p5endf-p5load



section code

org     p5load



section         code

warspr:
incbin  "war1.spr"

valspr:
incbin  "val1.spr"

wizspr:
incbin  "wiz1.spr"

elfspr:
incbin  "elf1.spr"


maze00:
incbin  "maze/maze00",7
maze01:
incbin  "maze/maze01",7
maze02:
incbin  "maze/maze02",7
maze03:
incbin  "maze/maze03",7
maze04:
incbin  "maze/maze04",7
maze05:
incbin  "maze/maze05",7
maze06:
incbin  "maze/maze06",7
maze07:
incbin  "maze/maze07",7
maze08:
incbin  "maze/maze08",7
maze09:
incbin  "maze/maze09",7
maze10:
incbin  "maze/maze10",7
maze11:
incbin  "maze/maze11",7
maze12:
incbin  "maze/maze12",7
maze13:
incbin  "maze/maze13",7
maze14:
incbin  "maze/maze14",7
maze15:
incbin  "maze/maze15",7
maze16:
incbin  "maze/maze16",7
maze17:
incbin  "maze/maze17",7
maze18:
incbin  "maze/maze18",7
maze19:
incbin  "maze/maze19",7
maze20:
incbin  "maze/maze20",7
maze21:
incbin  "maze/maze21",7
maze22:
incbin  "maze/maze22",7
maze23:
incbin  "maze/maze23",7
maze24:
incbin  "maze/maze24",7
maze25:
incbin  "maze/maze25",7
maze26:
incbin  "maze/maze26",7
maze27:
incbin  "maze/maze27",7
maze28:
incbin  "maze/maze28",7
maze29:
incbin  "maze/maze29",7
maze30:
incbin  "maze/maze30",7



p5end:          ds      p5padd,0
p5endf:         equ $

%if p5size > pagsize*16
   %warn "Page 9-16 boundary broken"
%endif

