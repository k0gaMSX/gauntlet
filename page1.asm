

p1size  equ     p1end-p1load
p1padd  equ     pagsize-p1size
p1sizeT equ     p1endf-p1load


section code
        org     p1load

        db      'AB'
        dw      Init
        dw      0,0,0,0,0,0,0,0


LoadMazeRJ:
        jp      LoadMazeR
RamSlotPage0J:
        jp      RamSlotPage0
RamSlotPage1J:
        jp      RamSlotPage1
RamSlotPage2J:
        jp      RamSlotPage2



Init:
        ld      sp,0f660h

        call    SaveSlotC
        call    searchramnormal
        call    SetIntroPages
.intro:
        call    StartLogo
        call    ShowIntro
	or      a
	jr      z,.intro

        call    SetBloadPages
        call    LoadFirstBload
        call    SetBloadPages
        call    LoadSecondBload
        ret



%include "sys.asm"
%include "gaunt1.asm"
%include "aamsx.asm"

section         code

p1end:  ds      p1padd,0
p1endf:         equ $

%if p1size > pagsize
   %warn "Page 0 boundary broken"
%endif
