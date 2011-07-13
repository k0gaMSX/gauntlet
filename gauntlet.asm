%include "tniasm.inc"
%include "z80r800.inc"
%include "z80().inc"
%include "msx.inc"



        fname   "gauntlet.rom"



orgcode 4000h
orgrdata 0E000h



pagsize: equ 2000h


p1load: equ     4000h
p2load: equ     6000h
p3load: equ     6000h
p4load: equ     8000h
p5load: equ     6000h




%include "page1.asm"            ; 1b20 bytes used
%include "page234.asm"          ; gtitle.tcf and select.tcf -> 17478
%include "page567.asm"          ; gaunt.2 and gaunt.3 ->
%include "page8.asm"            ; free page
%include "page9plus.asm"        ; Levels








