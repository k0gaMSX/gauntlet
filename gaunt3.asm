%include "tniasm.inc"
%include "z80r800.inc"
%include "z80().inc"

PrintDigit:     equ     0B6D9h
MainLoop:       equ     0b258h
SetPtrVram:     equ     0b444h
NumSP:          equ     800h
WriteSpPat:     equ     0ba6fh
WritePortRW:    equ     0b587h
VramSpAtt:      equ     5e00h
VramSpColour:   equ     5c00h
Rg0Sav:         equ     0f3dfh
Rg1Sav:         equ     0f3e0h
Rg4Sav:         equ     0f3dfh+4
LdAddress:      equ     8000h-7
Rg8sav:         equ     0FFE7h
PutColorF:      equ     0B4a6h
PatternMapPtr:  equ     84d3h
RefreshON:      equ     84d5h
WritePtr_VRAMI: equ     0b43fh
ControlSound:   equ     0b468h
SpriteAttrib:   equ     0d330h
WriteVDP_Reg:   equ     0b4a9h
WaitTime:       equ     0A257h
NWRVRM:         equ     177h
RowKeyb:        equ     847Fh



        ;; BAA4 sitio libre.
;;; Colores estan en 3a0d

;;; Hay que trasladar los cambios de patrones
;;; a todas las paginas (pociones, jamon y todo eso
;;; La funcion que hace el cambio de patrones es LdirPat

        %outfile   "gaunt.bin",0
        forg    0
        db      0feh
        dw      8000h
        dw      0ca20h
        dw      8000h

        forg    979fh-LdAddress
        org     979fh
	bit	7,(iy+07)

        forg    97a9h-LdAddress
        org     97a9h
	bit	1,(iy+06)


        forg    83d0h-LdAddress
        org     83d0h
        jp      0b90fh           ; evito rutina de slot


        forg 0956ch-LdAddress
        call    PutBios         ; Put Bios and Rom slot

        forg 09578h-LdAddress
        call    DisableSCR
        call    4014h           ; Patch to read mazes from ROM
        call    PutSlotRam      ;[95CDh]
        call    EnableSCR
        ei
        ld      iy,RowKeyb      ;[847Fh]
        jp      0D000h          ;Esta es la direccion de ejecucion del bloque




SaveSP:         equ     0dffdh
RamSlotPage1J:  equ     401Ah

        forg    095cdh-LdAddress
        org     095cdh
        call    RamSlotPage1J           ; Put again ram pages
        ld      a,(Rampage0)
        call    ENASLT_0
        ret



SetPtr_VRAM:    equ     0b444h



;CAMBIO DE SC2 a SC4

        forg    0b9e3h-LdAddress
        jp      Sc2toSc4

        forg    0b8e1h-LdAddress
        org     0b8e1h

Sc2toSc4:
        di
        call    sc4
        ld      a,10111111b
        out     (c),a
        ld      a,128+5
        out     (c),a
        ld      hl,Pallette
        call    PutPal
        ei
        jp      MainLoop




        forg 0ba8dh-LdAddress
        org 0ba8dh

SetVRAM:        equ 0b5dch

Pallette:
        db 11h,1, 73h,4, 70h,0, 44h,4, 00h,5, 50h,3, 27h,2, 70h,6
        db 70h,4, 77h,7, 40h,1, 00h,0, 37h,5, 57h,0, 65h,0, 76h,4



PutPal:
        xor     a
        out     (99h),a
        ld      a,128+16
        out     (99h),a
        ld      b,32
        ld      c,9Ah
        otir
        ld      de,3000h
        ld      hl,800h
        ld      b,0bbh
        call    SetVRAM
        ei
        ret



DisableSCR:     equ     0b5E9h
PatternGenPers: equ     2800h
WritePortRW_8:  equ     0b585h
PatternMap:     equ     0c000h



;;; Rutina reubicada  -> espacio libre en la posicion original


InitPatScr:
        call    DisableSCR           ;[0B5E9h]

        ld      hl,PatternGenPers
        ld      (.pointer),hl
        ld      b,3
        xor     a
.0:     push    bc
        push    af

        ld      de,0
        call    SetPtr_VRAM           ;[0B444h]

        ld      b,3
.1:     push    bc
        ld      hl,(.pointer)       ;Copio a VRAM 800 bytes de patrones :       2800
        ld      bc,98h                  ;del banco 1
        call    WritePortRW_8           ;[0B585h]
        pop     bc
        djnz    .1

        ld      hl,(.pointer)
        ld      a,8
        add     a,h
        ld      h,a
        ld      (.pointer),hl
        pop     af
        inc     a
        ld      b,a
        call    SetPage
        ei
        ld      a,b
        pop     bc
        djnz    .0


        xor     a
        call    SetPage
        ei


        ld      de,2000h
        call    SetPtr_VRAM           ;[0B444h]

        ld      b,3
.loop:  push    bc
        ld      hl,2000h              ;y hago lo mismo con 200 bytes de la
        ld      bc,98h                ;tabla de colores del banco 1
        call    WritePortRW_8           ;[0B585h]
        pop     bc
        djnz    .loop

        ld      hl,PatternGenPers
        ld      de,PatternMap        ;[0C000h]
        ld      bc,800h
        ldir
        ret

.pointer:       dw      0

SB63C:
        bit     0,e
        call    nz,0AA6Eh         ;[0AA6Eh]
        call    PutSplitPage
        call    0B63ch + 3
        jp      RestorePage

SB693:
        or      a
        jr      nz,.1
        ld      a,0bbh
.1:     ld      b,8
.571:   out     (98h),a         ;VRAM access
        inc     e
        djnz    .571            ;[0B695h]
        ret

        forg    97c9h-LdAddress
        org     097c9h
        jp      nz,0B40Bh

        ;; Hay sitio libre en 0B40Bh <- 5-7-2011

        forg   0B40Bh-LdAddress
        org    0B40Bh

KillPJ:         equ 9606h
        di
        call    PutSplitPage
        call    KillPJ
        call    RestorePage
        ei
        ret

EnableSCR:
        ld      a,(0F3E0h)
        ld      b,a
        ld      a,1
        jp    WriteVDP_Reg    ;[0B4A9h]



        ;; SB63C-> Esta rutina esta relacionada con cosas que se escriben en VRAM
        ;;         Creo que es la que activa/desactiva items

        forg 0b63ch-LdAddress
        org 0b63ch
        jp      SB63c
        ld      a,ixl
        and     20h             ;' '
        ld      de,3400h
        jr      nz,.565         ;[0B64Dh]
        ld      de,3488h
.565:   call    WritePTR_VRAMI           ;[0B43Fh]
        ld      c,(ix+14h)
        sub     a
        rr      c
        jr      nc,.566         ;[0B65Ah]
        ld      a,07Bh          ;''
.566:   call    SB693           ;[0B693h]
        sub     a
        rr      c
        jr      nc,.567         ;[0B664h]
        ld      a,05Bh          ;''
.567:   call    SB693           ;[0B693h]
        sub     a
        rr      c
        jr      nc,.568         ;[0B66Eh]
        ld      a,4bh           ;' '
.568:   call    SB693           ;[0B693h]
        ld      a,e
        add     a,48h           ;'H'
        ld      e,a
        call    WritePTR_VRAMI           ;[0B43Fh]
        sub     a
        rr      c
        jr      nc,.569         ;[0B67Fh]
        ld      a,2Bh           ;'
.569:   call    SB693           ;[0B693h]
        sub     a
        rr      c
        jr      nc,.570         ;[0B689h]
        ld      a,03Bh          ;''
.570:   call    SB693           ;[0B693h]
        sub     a
        rr      c
        jr      nc,SB693_p        ;[0B693h]
        ld      a,cbh           ;'p'

SB693_p:
        jp      SB693

        forg    0B79Ch-LdAddress
        org     0B79Fh
        ld      b,0Abh

        forg    0B7C6h-LdAddress
        org     0B7C6h
        ld      b,0cbh


        forg 0b63ch-LdAddress
        org 0b63ch
        jp      SB63c

        forg 8545h-LdAddress
        org 8545h
	ei		        ; Anular llamada a cambio de patron
	halt                    ; porque ya se actualiza en la interrupcion
	halt


        forg 980Ch-LdAddress    ;Patch to allow introduction screen
        org 980Ch

CheckStatusPJ:
        ld      a,(ix+14h)
        and     80h
        ld      (ix+14h),a

        ld      a,ixl
        and     20h                     ;Compruebo el personaje
        exx                             ;con el que estoy a partir de la
                                        ;direccion. (CAMBIAR ESTO!!!!!)
        ld      de,1400h
        jp      nz,InitPJP         ;[0B602h]
        ld      de,1488h
        jp      InitPJP            ;[0B602h]



        forg 0b546h-LdAddress
        org  0b546h
        jp InitPatScr
LdirSpetialPotion:
        push    hl
        push    hl
        ld      de,2970h
        ld      bc,10h
        ldir

        pop     hl
        ld      de,2970h+800h
        ld      c,10h
        ldir


        pop     hl
        ld      de,2970h+1000h
        ld      c,10h
        ldir
        ret



;;; Necesario para el color del fondo


        forg    0b483h-LdAddress
        org     0b483h
InitAttSp:
        ld      (8489h),sp      ;[8489h]
        ld      b,22h
        ld      sp,0D323h
        ld      de,0
;
.548:   push    de
        push    de
        push    de
        push    de
        push    de
        push    de
        push    de
        push    de
        push    de
        push    de
        push    de
        push    de
        djnz    .548
        ld      sp,(8489h)

        nop
        nop
        nop

        ld      a,0bh           ;Coloca el borde negro
        ld      b,a
        ld      a,7
        ld      c,99h
        or      80h
        di
        out     (c),b
        out     (c),a
        ei
        ret





;;; *********************************************************************
;;;
;;;
;;;  Rutina de refresco
;;;
;;;
;;; ********************************************************************


        forg 0a083h-LdAddress
        org 0a083h

RefreshScr:
        ld      a,1
        ld      (RefreshScrD),a

        inc     (iy+12h)
        ld      a,0bh
        bit     3,(iy-1)
        jr      z,.313          ;[0A08Fh]   ¨Hay relampago?
        ld      a,0Fh           ;           ¨Pues pon el blanco como
                                ;            color de fondo?
.313:   call    PutColorF       ;[0B4A6h]
        sub     a
        ld      (RefreshON),a   ;[84D5h]
        call    ControlSound            ;[0B468h]



        ld      a,1
        ld      (RefreshON),a       ;[84D5h]
        ei
.315:   halt
        ld      a,(RefreshScrD)
        or      a
        jr      nz,.315
        ret


RefreshScrI:
        ld      de,1800h
        call    SetPtrVram
        ld      hl,(PatternMapPtr)      ;[84D3h]
        ld      b,0
        call    WriteLinesSc4
        call    WriteLinesSc4
        ld      b,96
        call    WriteLinesSc4
        ret


RefreshSpr:
        ld      de,1e00h
        call    SetPtrVram
        ld      hl,SpriteAttrib
        ld      b,50h   ;Si se pone 48 en lugar de 50 se queda colgado O_O

        nop
        nop
.318:   outi
        outi
        outi
        outi
        outi
        outi
        outi
        outi
        outi
        outi
        outi
        outi
        outi
        outi
        outi
        outi
        jp      nz,.318         ;[0A147h]


        ld      a,(0F3E0h)
        ld      b,a
        ld      a,1
        call      WriteVDP_Reg           ;[0B4A9h]
.label: jp      WaitTime



WriteLinesSc4:
        ld      c,098h
.loop:  outi
        outi
        outi
        outi
        outi
        outi
        outi
        outi
        outi
        outi
        outi
        outi
        outi
        outi
        outi
        outi
        outi
        outi
        outi
        outi
        outi
        outi
        outi
        outi
        outi
        outi
        outi
        outi
        outi
        outi
        outi
        outi
        inc     hl
        inc     hl
        jp      nz,.loop
        ret


VecIntP:
        push    af              ;We are using line interrupt
        in      a,(99h)
        rlca
        jp      c,.vhInt

        ld      a,1             ;line interrupt
        out     (99h),a
        ld      a,128+15
        out     (99h),a
        in      a,(99h)

        ld      a,2
        out     (99h),a
        ld      a,128+15
        out     (99h),a

.waithr:
        in      a,(99h)
        and     20h
        jp      nz,.waithr

        call    SetSplitColorTable
        call    ViewSplitPage

        xor     a
        out     (99h),a
        ld      a,128+15
        out     (99h),a
        pop     af
        ei
        ret



.vhInt:                         ;Vertical interrupt
        call    RestoreViewPage
        call    SetNormalColorTable
        ;; ld      a,3
        ;; call    set_cfondo

        ld      a,(RefreshON)   ;[84D5h]
        or      a
        jp      z,.out

        push    de
        push    hl
        push    bc


        ld      a,(RefreshScrD)
        or      a
        jp      z,.oui

        call    RefreshScrI
        call    PutSpritePage
        call    RefreshSpr

        ld      a,(SpriteAttrib+19*4+3)
        ld      (SpriteAttrib+20*4+3),a ; Restore color sprite of moved player1
        ld      a,61h
        ld      (SpriteAttrib+21*4+3),a
        ld      (SpriteAttrib+19*4+3),a
        call    RestoreSpriteColor
        call    Put2Sprites
        call    RestorePage
        call    ChangePatPer

        xor     a
        ld      (RefreshScrD),a
.oui:
        call    ControlSound    ;Quitar el salvar registros
        ld      a,bh
        call    set_cfondo
        pop     bc
        pop     hl
        pop     de


.out:   pop     af
        ei
        ret



PrintDigitMarquee:
        di
        call PutSplitPage
        call PrintDigit
        call RestorePage
        ei
        ret


set_cfondo:
        di
        out     (99h),a
        ld      a,128+7
        out     (99h),a
        ret


RestoreViewPage:
        ld      a,(PaginaV)
ViewPage:
        or      3
        di
        out     (99h),a
        ld      a,4+128
        out     (99h),a
        ret


SetNormalColorTable:
        xor     a
        jr      SetColorTable
SetSplitColorTable:
        ld      a,4
SetColorTable:
        di
        out     (99h),a
        ld      a,128+10
        out     (99h),a
        ret



InitPJP:
        call    PutSplitPage
        call    InitPJ
        jp      RestorePage


RestorePage:
        ld      a,(vrampage)
SetPage:
        ld      (vrampage),a
SetPage_1:
        di
        out     (99h),a
        ld      a,14+128
        out     (99h),a
        ret

vrampage:       db      0



PutColorTextPerP:
        call    PutSplitPage
        ld      a,ixl           ;Mira con que personaje se ha llamado
        and     20h             ;en funcion de la parte baja de la direccion
        ld      de,3400h        ;por lo que si se crea un nuevo fuente
        jr      nz,.572         ;[0B6AAh] hay que modificar esto
        ld      de,3488h
.572:   call    PutColorLetter           ;[0B6B0h]
        call    PutColorLetter           ;[0B6B0h]
        call    PutColorLetter
        jp    RestorePage




ENASLT_0:
        di
        ld      e,a             ; e parameter in ENASLT_0
        in      a,(0a8h)
        ld      b,a             ; b original contet of a8
        and     3Fh             ; Bits upper clear
        ld      d,a             ; d -> a8 with upper bits clears

        ld      a,e
        and     3
        rrca
        rrca
        or      d
;;;                             ; a -> configuration to put page 3 in slot
;;;                             ;parameter
        out     (a8h),a         ; Put page 3 in same slot that 0 will be
        ld      a,(0ffffh)
        cpl
        ld      c,a             ; c original value of -1 of slot para
        and     0fch
        ld      l,a

        ld      a,e
        and     0ch
        rrca
        rrca
        or      l
        ld      (0ffffh),a      ; Put subslot

        ld      a,b
        and     0fch
        ld      h,a
        ld      a,e
        and     03h
        or      h
        out     (a8h),a
        ret


        forg    0b801h-LdAddress
        org     0b801h
;Nombre: PrintDataPer
;Objetivo: Creo que se dedica a imprimir la vida en la pantalla
;Entrada: hl -> Puntero al numero a imprimir
;         b -> longitud del numero


PrintDataPer:
        ld      c,0
        bit     1,(iy+12h)              ;Y QUE CONO ES ESTO????
        jr      z,.593          ;[0B80Dh]

        ld      a,l
        add     a,20h           ;' '
        ld      l,a

.593:   ld      a,(hl)          ;El bucle esta en dos partes
        rrca
        rrca
        rrca
        rrca
        call    PrintDigitMarquee
        ld      a,b
        dec     a
        jr      nz,.594         ;[0B81Bh]
        set     0,c

.594:   ld      a,(hl)          ;para desmpaquetar el numero BCD
        call    PrintDigitMarquee
        inc     hl
        djnz    .593            ;[0B80Dh]

        ret



        forg    085edh-LdAddress
        org     085edh

ChangePatPJS:
        ld      ix,DataPers1    ;[8420h]
        ld      de,3800h
        call    ChangePatPJ_1   ;[85FEh]
        ld      ix,DataPers2    ;[8440h]
        ld      de,3820h        ;

ChangePatPJ_1:  equ $

        forg    8555h-LdAddress
        org     8555h
ContItera:      equ 84d9h
TIME_CHANGE_ENEMY:      equ 6

ChangePatPer:

        call    ChangePatPJS             ;[85EDh]

        ld      a,(ContItera)       ;[84D9h]
        inc     a
        cp      TIME_CHANGE_ENEMY
        jr      nz,.9           ;[85ABh]

        ld      a,(PaginaV)     ;[84DAh]
        add     a,8
        cp      18h
        jr      nz,.1
        xor     a
.1:     ld      (PaginaV),a       ;[84DAh] otro sitio

        xor     a
.9:     ld      (ContItera),a   ;[84D9h] En esta primera llamada creo que
        ret

PaginaV:        db 0


;;; ***********************************************************************
;;; Color de fondo de los records.
;;; ***********************************************************************

        forg 0b8c4h -LdAddress
        org 0b8c4h


;Nombre: GetNamePJ
;Objetivo: devolver el nombre y color del personaje que se le pasa como
;          parametro.
;Entrada: a  -> Codificacion del personaje
;salida:  hl -> Direccion donde se almacena el nombre del personaje
;         c -> Color del personaje


GetNamePJ:
        ld      hl,444Fh
        ld      c,2Bh           ; Colores de los personajes tambien
        or      a
        ret     z

        ld      hl,4457h
        ld      c,6Bh
        sub     8
        ret     z

        ld      hl,4461h
        ld      c,7Bh
        sub     8
        ret     z

        ld      hl,4469h
        ld      c,4Bh
        ret



        forg    0b5c0h-LdAddress
        org     0b5c0h
        ld      de,1e00h



        forg 0b373h-LdAddress
        ret
        ;; Aqui hay sitio para parches. 8-7-2011

        forg 0b5b6h-LdAddress
        org 0b5b6h
        ld b,09bh


        forg 094c7h-LdAddress
        org 094c7h
        ld      (hl),220        ; Modificacion para ocultar sprites


        forg 0b97fh-LdAddress
        org 0b97fh              ;Put color b as background in marquee
        ld      de,3000h
        call    PutSplitPage    ;3 bytes
        ld      b,0bbh
        call    CleanVRAM
        call    RestorePage
        nop
        nop

EraseMarc:              equ     0B7E7h
WritePatternText:       equ     0B6EBh
        forg 0B69Eh-LdAddress
        org 0B69Eh
        jp  PutColorTextPerP    ;Put character colour in split table
EraseMarcP:
        call    PutSplitPage
        call    EraseMarc
        ld      a,c
        jp      WritePatternText



        forg 0B7B0h-LdAddress
        org 0B7B0h
        jp      EraseMarcP
        ld      a,c
        jp      RestorePage


        forg 0b602h-LdAddress
        org 0b602h

DefSymbols:             equ 0b895h
PutColorTextPer:        equ 0b69eh
PutColorLetter:         equ 0b6b0h


InitPJ:
        push    de              ;Esta puede ser la funcion de inicializacion
        exx                     ;de un personaje
        bit     7,(ix+14h)      ;Estaba vivo antes?
        jr      z,.562          ;[0B618h]

        pop     af              ;Porque sino no vuelvo a hacer esto
        call    DefSymbols      ;[0B895h]

        ld      c,5bh
        call    PutColorTextPer ;[0B69Eh]
        ld      c,8bh
        jp      PutColorLetter  ;[0B6B0h]

.562:


        forg 0b79fh-LdAddress
        org 0b79fh
        ld      b,08bh          ; Rectificacion del color de marcador



        forg 9de4h-LdAddress
        org 9de4h

ChangeWalls:
        ld      a,(ix+2);en esta posicion se guarda el tipo de muro con su color.
        rra
        rra
        rra
        and     7
        cp      3
        jr      c,.278          ;[9DF2h]
        sub     3

.278:   ld      de,0
        or      a
        jr      z,.279          ;[9DFFh]

        ld      e,60h           ;'`'
        dec     a
        jr      z,.279          ;[9DFFh]

        ld      e,0C0h          ;'À'
.279:   ld      hl,0EE0h
        add     hl,de
        push    de

        push    hl
        push    hl
        ld      de,2808h        ;Aqui cambiamos el patron en el banco 1
        ld      bc,60h          ;de los muros
        ldir

        pop     hl
        ld      de,3008h
        ld      bc,60h
        ldir

        pop     hl
        ld      de,3808h
        ld      bc,60h
        ldir

        ld      a,(ix+2)
        and     38h             ;Para cada muro hay 2 combinaciones distintas
        rrca


        ld      e,a
        ld      d,0
        ld      hl,WallColorList
        add     hl,de

        di
        ld      a,14
        out     (99h),a
        ld      a,128+16
        out     (99h),a
        ld      b,4
.1:     ld      c,9Ah
        otir
        ei
        jp      ChangeWallColor


;;; Aqui hay mucho sitio para parches!!!!!!


WallColorList:  db 70h,5,40h,2
                db 11h,7,00h,4
                db 06h,5,04h,2
                db 54h,3,32h,1
                db 64h,4,42h,2
                db 56h,6,34h,3
                db 50h,4,30h,2
                db 50h,7,02h,4




RELMEM: equ 0f41fh

        forg    08000h-LdAddress
        org     08000h


        ld      a,-1
        ld      hl,Spritecolorcache
        ld      de,Spritecolorcache+1
        ld      (hl),a
        ld      bc,32
        ldir

        call    7eh
        di
        ld      a,1
        out     (99h),a
        ld      a,14+128
        out     (99h),a

        ld      de,1c00h
        call    WritePTR_VRAMI           ;[0B43Fh]
        ld      a,9
        ld      e,2
.2:     ld      bc,098h
.1:     out     (c),a
        djnz    .1
        dec     e
        jr      nz,.2

        call    PutSlotRam
        xor     a
        call    SetPage
        ei

        ld      hl,RelocableCode
        ld      de,RELMEM
        ld      bc,RelocableCodeEnd-ChangeWallColor
        ldir
        jp      8300h

sc4:
        ld      a,(Rg0Sav)
        and     11110001b
        or      00000100b
        ld      (Rg0Sav),a
        ld      c,99h
        out     (c),a
        ld      a,128
        out     (c),a   ;Screen 4 is set

        ld      a,(Rg1Sav)
        and     11100111b
        ld      (Rg1Sav),a
        out     (c),a
        ld      a,128+1
        out     (c),a

        ld      a,0C3h
        ld      (0fd9ah),a
        ld      hl,VectorInt
        ld      (0fd9bh),hl

        ld      a,149           ; Put interrupt line
        out     (c),a
        ld      a,128+19
        out     (c),a

        ld      a,(Rg0Sav)      ; Enable interrupt line vertical
        set     4,a
        ld      (Rg0Sav),a
        out     (c),a
        ld      a,128+0
        out     (c),a

;;; Aqui hay sitio para parches: 06-2010

        ret







;;; Inicio codigo conflictivo

RelocableCode:
        org     RELMEM
ChangeWallColor:
        pop     de
        ld      hl,680h
        add     hl,de
        ld      de,2008h        ;Cambio de colores de los muros
        ld      b,60h
        call    MakeColorWall           ;[9E4Bh]
        ld      hl,7A0h         ;Cambio de colores de
        ld      de,2200h        ;los muros rotos
        ld      b,58h
        call    MakeColorWall
        ret



MakeColorWall:
        ld      c,0             ; Default colors are black
        ld      a,(hl)          ; Load the colour wall byte
        and     0Fh             ; and get the lower nibble
        jr      z,.280          ; if colour is 0, then load 1st color (0)


        cp      7               ; If color is 4 then load the 2nd color (15)
        ld      a,c             ;
        jr      z,.281          ;

WallSM_NL_H
        or      0eh
        jr      .282

WallSM_NH_L
.281:   or      0fh
.282:   ld      c,a


.280:   ld      a,(hl)
        and     0F0h
        jr      z,.283
        cp      70h
        ld      a,c
        jr      z,.284

WallSM_NH_H
        or      0f0h
        jr      .285

WallSM_NL_L
.284:   or      0e0h
.285:   ld      c,a
.283:   ld      a,c
        ld      (de),a
        inc     hl
        inc     de
        djnz    MakeColorWall
        ret

FillVRAMx8:     equ 0B693h







InitScr:        equ 0b590h
CleanVRAM:      equ 0b5d9h
HideSprites:    equ 094c4h

InitScrP:                       ; Reubicada entera, hay espacio en la posicion
	ei
	halt
	di
        call    DisableSCR
        ld      a,3             ; original
        di
        out     (99h),a
        ld      a,4+128
        out     (99h),a
        xor     a
        ld      (PaginaV),a


        ld      de,1800h
        call    WritePTR_VRAMI           ;[0B43Fh]

        sub     a
.557:   out     (98h),a
        inc     a
        jr      nz,.557         ;[0B59Ah]

.558:   out     (98h),a
        inc     a
        jr      nz,.558         ;[0B59Fh]


.559:   ld      e,a
        out     (98h),a
        ld      a,e
        inc     a
        jr      nz,.559         ;[0B5A4h]

        ld      de,0
        ld      b,e
        call    CleanVRAM         ;[0B5D9h]      ;Limpio la tabla de definicion
                                                ;de patrones
        ld      de,2000h                        ;La tabla de definicion de
        ld      b,09bh          ;               ;los colores
        call    CleanVRAM        ;[0B5D9h]

        ld      b,80h           ;'P'
        call    HideSprites           ;[94C4h]

        ld      de,1e00h
        call    WritePTR_VRAMI  ;[0B43Fh]

        ld      a,1
        out     (099h),a
        ld      a,128+14
        out     (99h),a

        ld      hl,SpriteAttrib ;Escribo las caracteristica de 20 sprites
        ld      b,80h
.560:   outi
        jp      nz,.560         ;[0B5CBh]
        call    RestorePage

        ld      a,(0F3E0h)      ;Esto no es correcto!!!!!
        ld      b,a
        ld      a,1
        call      WriteVDP_Reg    ;[0B4A9h]
	ei
	ret

        ;; Hay algunos bytes libres aqui 6-7-2011





romslt:         equ 0f37fh
rampage0:       equ 0f37eh
rampage1:       equ 0f37dh
rampage2:       equ 0f37ch
rampage3:       equ 0f37bh
EXPTBL:         equ 0fcc1h
ENASLT:         equ 24h

PutBios:
        di
        ld      a,(EXPTBL)
        call    ENASLT_0
        ld      a,(romslt)
        ld      hl,1<<14
        call    ENASLT
        ret






ReadPTR_VRAM:   equ 0B454h




DATAPERS1:      equ 8420h
DATAPERS2:      equ 8440h
warspr:         equ 6000h
valspr:         equ 6300h
wizspr:         equ 6600h
elfspr:         equ 6900h
PutSlotRam:     equ 95CDh



PutSplitPage:
        push    af
        ld      a,4
        call    SetPage_1
        pop     af
        ret


ViewSplitPage:
        ld      a,20h
        jp      ViewPage
        ret


PutSpritePage:
        ld      a,1
        jp      SetPage_1


PutPatternPage:
        xor     a
        jp      SetPage_1




Spritecolorcache:       equ     0f806h

RestoreSpriteColor:
        ld      b,32
        ld      hl,SpriteAttrib
        ld      de,01c00h
        ld      (.ptr),de
        ld      de,Spritecolorcache

.2:     push    de
        inc     hl
        inc     hl
        inc     hl
        push    hl

        ld      a,(hl)
        ex      de,hl
        cp      (hl)
        jr      z,.3

        ld      (hl),a
        push    af
        ld      de,(.ptr)
        call    SetPtrVram
        pop     af
        cp      61h
        jr      z,.write

        and     0Fh
        ld      de,SpriteColorLT
        ld      h,0
        ld      l,a
        add     hl,de
        ld      a,(hl)
        or      20h


.write:
        ld      c,b
        ld      b,16
.loop:  out     (98h),a
        djnz    .loop
        ld      b,c


.3:     ld      hl,(.ptr)
        ld      de,16
        add     hl,de
        ld      (.ptr),hl
        pop     hl
        pop     de
        inc     de
        inc     hl
        djnz    .2
        ret

.ptr:   dw      0






;;; Move character 1 to 20 position
;;; Wrote pattern 2nd sprite player 1 at 6 pattern position
;;; Write player 1 2nd sprite at 21
;;; Wrote pattern 2nd sprite player 1 at 5 pattern position
;;; Write player 2 2nd sprite at 19


Put2Sprites:
        call    PutBios

        ld      a,(842bh)
        bit     7,a
        jr      nz,.no1p

        ld      de,1e00h+20*4
        call    SetPtrVram
        ld      hl,SpriteAttrib+19*4
        ld      bc,0498h
        otir                    ; Move character 1 to position 20

        ld      de,DATAPERS1    ; Character data
        ld      bc,3800h+32*6   ; Cogo el patron 6
        call    SndSprPat       ; Put Pattern of 2nd spr

        ld      hl,SpriteAttrib+19*4
        ld      de,1e00h+21*4   ; spriteatt => y el sprite 20 (2º personaje)
        ld      a,6*4           ; Number of pattern and color
        call    SndSprAtt
        jr      .2p

.no1p:
        ld      de,1e00h+20*4   ; Esto hay que hacerlo si no se pone
        call    SetPtrVram      ; player 2
        ld      bc,0298h
        ld      a,230
.11:    out     (c),a
        djnz    .11

        ld      de,1e00h+21*4   ; Esto hay que hacerlo si no se pone
        call    SetPtrVram      ; player 2
        ld      bc,0298h
        ld      a,230
.12:    out     (c),a
        djnz    .12

.2p:
        ld      a,(844bh)
        bit     7,a
        jr      nz,.no2p

        ld      de,DATAPERS2    ; Character data
        ld      bc,3800h+32*5   ; Cogo el patron 5
        call    SndSprPat       ; Put Pattern of 2nd spr

        ld      hl,SpriteAttrib+18*4
        ld      de,1e00h+19*4   ; spriteatt => y el sprite 19 (2º personaje)
        ld      a,5*4           ; Number of pattern and color
        call    SndSprAtt
        jr      .end

.no2p:
        ld      de,1e00h+19*4   ; Esto hay que hacerlo si no se pone
        call    SetPtrVram      ; player 2
        ld      bc,0298h
        ld      a,230
.21:    out     (c),a
        djnz    .21

        ld      de,1e00h+18*4   ; Esto hay que hacerlo si no se pone
        call    SetPtrVram      ; player 2
        ld      bc,0298h
        ld      a,230
.22:    out     (c),a
        djnz    .22


.end:   call    PutSlotRam
        ret




;;; de -> Pointer to data
;;; bc -> Pointer to vram pattern


SndSprPat:
        ld      a,8
        ld      (6800h),a
        push    ix
        ld      ixl,e
        ld      ixh,d
        push    bc
        ld      hl,13h
        add     hl,de
        ld      a,(hl)
        or      a
        jr      nz,.nowar
        ld      hl,warspr
        jr      .endc

.nowar:
        cp      8
        jr      nz,.noval
        ld      hl,valspr
        jr      .endc

.noval: cp      10h
        jr      nz,.nowiz
        ld      hl,wizspr
        jr      .endc

.nowiz: ld      hl,elfspr


.endc:                          ; hl=ram pattern table

        ld      d,0
        bit     6,(ix+0Eh)
        jr      z,.15           ;[8630h]

        inc     d
        bit     7,(ix+0Eh)
        jr      z,.15           ;[8630h]
        inc     d

.15:    ld      a,(ix+0Dh)
        bit     0,(ix+0Eh)
        jr      z,.16           ;[863Bh]
        ld      a,4

.16:    rrca
        rrca
        rrca
        and     0E0h
        ld      e,a
        add     hl,de           ; hl=animation absolute address in ram

        call    PutPatternPage
        pop     de
        call    SetPtrVram

        ld      bc,2098h
        otir

        call    PutSpritePage
        pop     ix
        ret


;;; hl -> Atributo
;;; de -> VRAM attribute address
;;; a  -> Numero de patron



SndSprAtt:
        push    af
        call    SetPtrVram
        ld      bc,298h
        otir
        pop     af
        out     (98h),a
        ret

LdirPat2:
        pop     hl
        ld      de,28E8h+1000h
        ld      bc,18h
        ldir

        ld      de,2A88h+1000h
        ld      c,8
        ldir
        ret



RelocableCodeEnd: equ   $
;;; Fin de codigo conflictivo




        forg    0ba06h-LdAddress ; Tabla de colores de la pocima dorada.

        db 09bh,070h,000h,090h,09bh,090h,0c0h,000h
        db 0b7h,070h,000h,0c0h,0cbh,0c0h,060h,000h
        db 07bh,070h,70h,070h, 8bh,80h, 80h, 80h
        db 0b8h, 08h, 08h,08h,0b8h,08h, 80h, 08h



        forg 09fa6h-LdAddress   ;Parche para meter la nueva tabla de
                                ;colores de las pociones especiales

        db  090h,070h           ;Escudo  -FIXED
        db  080h,050h           ;Redonda -FIXED
        db  070h,040h           ;raro    -FIXED
        db  010h,020h           ;reloj   -FIXED
        db  090h,030h           ;malla   -FIXED
        db  090h,0c0h           ;espada  -FIXED

;;; La funcion de cambio de pociones especiales esta en ChangeSpetialPotion:







        forg    InitScr-LdAddress
        org     InitScr
        jp      InitScrP
SpriteColorLT:  db 2
                db 11
                db 4
                db 4
                db 6
                db 12
                db 10
                db 13

                db 2
                db 1
                db 8
                db 7
                db 4
                db 1
                db 3
                db 9





        forg 0b45bh-LdAddress
        org 0b45bh

;Nombre: VectorInt
;Objetivo: Sirve como vector de interrupcion al programa

VectorInt:
        jp      VecIntP
RefreshScrD:    db 0



        forg    9F89h-LdAddress ;Parche para copiar el patron en todas las pantallas
        org     9F89h
        call    LdirSpetialPotion
        nop
        nop


        forg    9f3dh-LdAddress ;Parche para que haya pocion en todas las pantallas > 8
        org     9f3dh
        nop
        nop



        forg    0baa4h-LdAddress ;Nuevas rutinas para copiar los patrones especiales
        org     0baa4h



;;; Aqui se pueden meter rutinas pero para ello primero hay que asegurarse
;;; de que nunca se llega aqui






        forg    958Eh-LdAddress
        org     958Eh

LdirPat:
        push    hl
        push    hl
        ld      de,28E8h             ;copiamos los patrones de las
        ld      bc,18h               ;salidas a 4 y 8
        ldir

        ld      de,2A88h             ;El patron del Ex
        ld      c,8                  ;
        ldir

        ld      de,20E8h             ;El patron del IT
        ld      c,18h                ;ademas del de la sidra
        ldir

        ld      de,2288h
        ld      c,8
        ldir

        pop     hl
        ld      de,28E8h+800h
        ld      bc,18h
        ldir

        ld      de,2A88h+800h
        ld      c,8
        ldir
        jp      LdirPat2



