%include "z80r800.inc"
%include "z80__.inc"

MainLoop:	equ	0b258h
SetPtrVram:	equ	0b444h
NumSP:		equ	800h
WriteSpPat:	equ	0ba6fh
WritePortRW:	equ	0b587h
VramSpAtt:	equ	5e00h
VramSpColour:	equ	5c00h
Rg0Sav:		equ	0f3dfh
Rg4Sav:		equ	0f3dfh+4
LdAddress:	equ	8000h-7
Rg8sav:		equ	0FFE7h
PutColorF:	equ	0B4a6h
PatternMapPtr:	equ	84d3h
RefreshON:	equ	84d5h
WritePtr_VRAMI:	equ	0b43fh
ControlSound:	equ	0b468h
SpriteAttrib:	equ 	0d330h
WriteVDP_Reg:	equ	0b4a9h
WaitTime:	equ	0A257h
NWRVRM:		equ	177h



;;; Hay que trasladar los cambios de patrones
;;; a todas las paginas (pociones, jamon y todo eso
;;; LA FUNCION QUE SE ENCARGA DE ACTUALIZAR POSICION SPRITE PERSONAJE
;;; DoViewPJs




	fname	"gaunt.bin",0

	forg	8400h-LdAddress
	org	8400h
	jp	0b90fh	;evito inicio




SetPtr_VRAM:	equ	0b444h



;CAMBIO DE SC2 a SC4

	forg	0b9e3h-LdAddress
	jp	Sc2toSc4

	forg	0b8e1h-LdAddress
	org	0b8e1h

Sc2toSc4:
	di
	ld	a,(Rg0Sav)
	and	11111001b
	or	00000100b
	ld	(Rg0Sav),a

	ld	c,99h
	out	(c),a
	ld	a,128
	out	(c),a	;Screen 4 is set

	call	PutColor0

	ld	a,10111111b
	out	(c),a
	ld	a,128+5
	out	(c),a
	ld	hl,Pallette
	call	PutPal
	jp	MainLoop




	forg 0ba8dh-LdAddress
	org 0ba8dh

SetVRAM:	equ 0b5dch

Pallette:
	db 11h,1,73h,4,70h,0,44h,4,0,5,50h,3,27h,2,70h,6
	db 70h,4,77h,7,40h,1,0,0,37h,5,57h,0,65h,0,76h,4

PutPal:
	xor	a
	out	(99h),a
	ld	a,128+16
	out	(99h),a
	ld	b,32
	ld	c,9Ah
	otir
	ld	de,3000h
	ld	hl,800h
	ld	b,0bbh
	call	SetVRAM
	ei
	ret


PutColor0:
	ld	a,(Rg8sav)
	set	5,A
	ld	(Rg8sav),a
	out	(c),A
	ld	A,128+8
	out	(c),A
	ret

EnableScr:	equ	0b539h
PatternGenPers:	equ	2800h
WritePortRW_8:	equ	0b585h
PatternMap:	equ	0c000h



;;; Rutina reubicada  -> espacio libre en la posicion original


InitPatScr:
        call    EnableSCR           ;[0B5E9h]

	ld	hl,PatternGenPers
	ld	(.pointer),hl
	ld	b,3
	xor	a
.0:	push	bc
	push	af

	ld	de,0
	call    SetPtr_VRAM           ;[0B444h]

	ld	b,3
.1:	push	bc
	ld      hl,(.pointer)       ;Copio a VRAM 800 bytes de patrones :	2800
        ld      bc,98h                  ;del banco 1
        call    WritePortRW_8           ;[0B585h]
	pop	bc
	djnz	.1

	ld	hl,(.pointer)
	ld	a,8
	add	a,h
	ld	h,a
	ld	(.pointer),hl
	pop     af
	inc	a
	ld	b,a
	call	SetPage
	ei
	ld	a,b
	pop	bc
	djnz	.0


	xor	a
	call	SetPage
	ei


	ld	de,2000h
        call    SetPtr_VRAM           ;[0B444h]

        ld      hl,2000h              ;y hago lo mismo con 200 bytes de la
        ld      bc,98h                ;tabla de colores del banco 1
        call    WritePortRW_8           ;[0B585h]

	ld	hl,2000h
	ld	bc,98h
        call    WritePortRW_8           ;[0B585h]

	ld	hl,2000h
	ld	bc,98h
        call    WritePortRW_8           ;[0B585h]

        ld      hl,PatternGenPers
        ld      de,PatternMap        ;[0C000h]
	ld	bc,800h
	ldir
	ret

.pointer:	dw	0


	forg 8545h-LdAddress
	org 8545h

	nop			; Anular llamada a cambio de patron
	nop 			; a
	nop			; a



	forg 0b546h-LdAddress
	org  0b546h
	jp InitPatScr


;;; Necesario para el color del fondo


	forg	0b483h-LdAddress
	org	0b483h
	ld      (8489h),sp      ;[8489h]
	ld	b,22h
	ld	sp,0D323h
	ld	de,0
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

        ld	a,0bh           ;Coloca el borde negro
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
	ld	a,1
	ld	(RefreshScrD),a

        inc     (iy+12h)
	ld	a,0bh
        bit     3,(iy-1)
        jr      z,.313          ;[0A08Fh]   ¨Hay relampago?
        ld      a,0Fh           ;           ¨Pues pon el blanco como
                                ;            color de fondo?
.313:   call    PutColorF       ;[0B4A6h]
	sub	a
        ld      (RefreshON),a   ;[84D5h]
	call	ControlSound		;[0B468h]


	ld	a,4
	call	PutColorF

        ld      a,1
        ld      (RefreshON),a       ;[84D5h]
	ei
.315:	halt
	ld	a,(RefreshScrD)
	or	a
	jr	nz,.315
	ret




RefreshScrI:
	ld	a,0Fh
	call	PutColorF
	ld	de,1800h
        call    WritePTR_VRAMI           ;[0B43Fh]
        ld      hl,(PatternMapPtr)      ;[84D3h]
	ld	b,0
	call	WriteLinesSc4
	call	WriteLinesSc4
	ld	b,64
	call	WriteLinesSc4
;;; AÑADIR AQUI ACTUALIZACION DE SPRITES

	ld	de,1e00h
        call    WritePTR_VRAMI           ;[0B43Fh]
        ld      hl,SpriteAttrib
	ld	b,50h		;'H'

	ld	a,1
	out	(99h),a
	ld	a,14+128
	out	(99h),a

	nop
	nop
.318:	outi
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
	jp	nz,.318		;[0A147h]



	call	RestorePage
	ld	a,(0F3E0h)
	ld	b,a
	ld	a,1
        call    WriteVDP_Reg           ;[0B4A9h]
.label:	jp	WaitTime



WriteLinesSc4:
	ld	c,098h
.loop:	outi
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
	inc	hl
	inc	hl
	jp	nz,.loop
	ret


VecIntP:
        push    af
        in      a,(99h)
        ld      a,(RefreshON)   ;[84D5h]
	or	a
	jr	z,.out

	push	de
	push	hl
	push	bc


	ld	a,(RefreshScrD)
	or	a
	jp	z,.oui
	call	RefreshScrI
	call	ChangePatPer

	xor	a
	ld	(RefreshScrD),a
.oui:
	call	ControlSound	;Quitar el salvar registros
	pop	bc
	pop	hl
	pop	de

.out:	pop	af
	ei
	ret

RestorePage:
	ld	a,(vrampage)
SetPage:
	ld	(vrampage),a
	di
	out	(99h),a
	ld	a,14+128
	out	(99h),a
	ret
vrampage:	db	0






	forg	0b801h-LdAddress
	org	0b801h
	ret			; Este ret es para evitar la escritura de los datos de los personajes
	;;



	forg	8555h-LdAddress
	org	8555h

ChangePatPJS:	equ 85edh
ContItera:	equ 84d9h


ChangePatPer:

        call    ChangePatPJS             ;[85EDh]

        ld      a,(ContItera)       ;[84D9h]
	inc	a
	cp	6
	jr	nz,.9		;[85ABh]

        ld	a,(.PaginaV)	;[84DAh]
        add	a,8
	cp	18h
	jr	nz,.1
	xor	a
.1:	ld      (.PaginaV),a       ;[84DAh] otro sitio


	or	3
	di
	out	(99h),a
	ld	a,4+128
	out	(99h),a

	xor	a
.9:     ld      (ContItera),a   ;[84D9h] En esta primera llamada creo que
	ret


.PaginaV:	db 0


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
	ld	c,2Bh   	; Colores de los personajes tambien
	or	a
	ret	z

        ld	hl,4457h
	ld	c,6Bh
	sub	8
        ret	z

	ld	hl,4461h
	ld	c,7Bh
	sub	8
	ret	z

	ld	hl,4469h
	ld	c,4Bh
	ret



	forg 0b373h-LdAddress
	org 0b373h

	ld b,09bh


	forg 0b5b6h-LdAddress
	org 0b5b6h

	ld b,09bh

	forg 0b602h-LdAddress
	org 0b602h

DefSymbols:		equ 0b895h
PutColorTextPer:	equ 0b69eh
PutColorLetter:		equ 0b6b0h


InitPJ:
        push    de              ;Esta puede ser la funcion de inicializacion
        exx                     ;de un personaje
        bit     7,(ix+14h)      ;Estaba vivo antes?
	jr	z,.562		;[0B618h]

        pop     af              ;Porque sino no vuelvo a hacer esto
        call    DefSymbols      ;[0B895h]

	ld	c,5bh
        call    PutColorTextPer ;[0B69Eh]
	ld	c,08bh
        jp      PutColorLetter  ;[0B6B0h]

.562:


	forg 0b79fh-LdAddress
	org 0b79fh
	ld	b,0abh



	forg 9de4h-LdAddress
	org 9de4h

ChangeWalls:
	ld	a,(ix+2);en esta posicion se guarda el tipo de muro con su color.
	rra
	rra
	rra
	and	7
	cp	3
	jr	c,.278		;[9DF2h]
	sub	3

.278:	ld	de,0
	or	a
	jr	z,.279		;[9DFFh]

	ld	e,60h		;'`'
	dec	a
	jr	z,.279		;[9DFFh]

	ld	e,0C0h		;'À'
.279:	ld	hl,0EE0h
	add	hl,de
	push	de

	push	hl
       	push	hl
	ld	de,2808h	;Aqui cambiamos el patron en el banco 1
	ld	bc,60h		;de los muros
	ldir

	pop	hl
	ld	de,3008h
	ld	bc,60h
	ldir

	pop	hl
	ld	de,3808h
	ld	bc,60h
	ldir

	ld	a,(ix+2)
	and	38h		;Para cada muro hay 2 combinaciones distintas
	rrca
	rrca
	rrca

	ld	e,a
	ld	d,0
	ld	hl,WallColorList
	add	hl,de

	di
	ld	a,14
	out	(99h),a
	ld	a,128+16
	out	(99h),a
	ld	b,4
	ld	c,9Ah
	otir
       	ei
	jp ChangeWallColor





;;; Aqui hay mucho sitio para parches!!!!!!


WallColorList:	db 70h,5,40h,2
		db 11h,7,00h,4
		db 06h,5,04h,2
		db 54h,3,32h,1
		db 64h,4,42h,2
		db 56h,6,34h,3
		db 50h,4,30h,2
		db 50h,7,02h,4



;;; BUSCAR SITIO PARA METER ESTA RUTINA
;;; ESTA USADA -> ESTE TROZO HACE QUE SE CUELGUE SI SE PONE EN LA DIRECCION CORRECTA
	forg 	08000h-LdAddress
	org	08000h


	di
	ld	a,1
	out	(99h),a
	ld	a,14+128
	out	(99h),a

	ld	de,1c00h
        call    WritePTR_VRAMI           ;[0B43Fh]
	xor	a
	ld	e,2
.2:	ld	bc,098h
.1:	out	(c),a
	djnz	.1
	dec	e
	jr	nz,.2


	xor	a
	call	SetPage
	ei

	ld	hl,ChangeWallColorI
	ld	de,ChangeWallColor
	ld	bc,MakeColorEnd-ChangeWallColor
	ldir
	jp	8300h





ChangeWallColorI:
	org	0da00h
ChangeWallColor:		; ESTOS VALORES SE PUEDEN PONER DIRECTAMENTE Y DEJAR ESPACIO
	pop	de
	ld	hl,680h
	add	hl,de
	ld	de,2008h	;Cambio de colores de los muros
	ld	b,60h		;'`'
	call	MakeColorWall		;[9E4Bh]
	ld	hl,7A0h		;Cambio de colores de
	ld	de,2200h	;los muros rotos
	ld	b,58h		;'X'
	call	MakeColorWall
	ret






MakeColorWall:
	ld	c,0
	ld	a,(hl)
	and	0Fh
	jr	z,.280		;[9E5Eh]

	cp	7
	ld	a,c
	jr	z,.281		;[9E5Bh]

WallSM_NL_H
	or	0eh 	; B9E58
	jr	.282		;[9E5Dh]

WallSM_NH_L
.281:	or	0f0h	; B9E5C
.282:	ld	c,a
.280:	ld	a,(hl)
	and	0F0h		;'ð'
	jr	z,.283		;[9E6Fh]

	cp	70h		;'p'
	ld	a,c
	jr	z,.284		;[9E6Ch]

WallSM_NH_H
	or	0f0h	; B9E69
	jr	.285		;[9E6Eh]

WallSM_NL_L
.284:	or	0eh 	; B9E6D
.285:	ld	c,a
.283:	ld	a,c
	ld	(de),a
	inc	hl
	inc	de
	djnz	MakeColorWall		;[9E4Bh]
	ret

FillVRAMx8:	equ 0B693h


PutLineSP:
	inc	e
	ld	a,7Fh
	cp	l
	jr	nz,.1
	ld	hl,1D30h
	jr	.2
.1:	ld	hl,1D20h
.2:
	push	de
	ex	de,hl
	call    WritePTR_VRAMI
	di
	ld	a,1
	out	(99h),a
	ld	a,14+128
	out	(99h),a
	ei
	pop	de

	ld	a,e
	call	FillVRAMx8
	call	FillVRAMx8
	call	RestorePage
	ret




MakeColorEnd:		db 0




	forg 9AD4h-LdAddress
	org 9AD4h


GetPatSpPj:
        ld      e,8             ;-A¨Es el Guerrero?-b
	sub	8
	jr	c,.242		;[9AE8h]

        ld      e,4             ;-A¨Es la walkyria?-b
	sub	8
	jr	c,.242		;[9AE8h]

        ld      e,0Ah           ;-A¨Es el mago?-b
	sub	8
	jr	c,.242		;[9AE8h]

        ld      e,2             ;-A¨Es el elfo?-b
.242:	ld	a,b
	cp	2
	jr	nc,.243		;[9AF4h]

	bit	4,(iy+18h)
	jr	z,.243		;[9AF4h]
.243:	jp	PutLineSP




	forg 0b45bh-LdAddress
	org 0b45bh

;Nombre: VectorInt
;Objetivo: Sirve como vector de interrupcion al programa

VectorInt:
	jp	VecIntP
RefreshScrD:	db 0

