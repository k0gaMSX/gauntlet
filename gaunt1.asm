;;; %include "tniasm.inc"
;;; %include "z80r800.inc"
;;; %include "z80().inc"


	
LINEINT equ	140	
TIMEFADE equ	3


	
%macro RGB %n,%n,%n
%def16 #2*256+#1*16+#3
%endmacro
	
	
		
section	code		
	
ShowIntro:	
	ld	a,1fh
	out	(2eh),a

	ld	hl,datab
	ld	de,databss
	ld	bc,datae-datab
	ldir
			
	ld	a,14h
	call	InitVDP
	
	call	ColourSFX
	call	SelectChars

	call	RestVDP
	xor	a
	call	initscr
	ret

	
PAL_NEGRO:	DS	32,0

	
  	
SelectChars:
	ld	hl,gchars
	ld	de,8000h
	scf
	call	UnTCFV
	
	ld	hl,copyscr	; First copy screen to page 1
	CALL	WAIT_COM
	CALL	COPYVRAM
	ld	hl,buildp2
	CALL	WAIT_COM	; And generate player 2 gfx
	CALL	COPYVRAM
	
	ld	a,3
	call	VER_PAGE
	call	BuildHand	; Load in vram hand sprite
	LD	HL,SelectPallette
	call	FADE_ON
	call	getNumbers	; Select number of players
	call	selectP1	; Select player 1
	ld	(0fffdh),a
	ld	a,(nplayers)
	dec	a
	call	nz,selectP2	; and player 2 if it is necessary
	ld	(0fffeh),a	
	ret
	


	
selectP2:
	ld	a,1
	ld	(copyline+3),a	
	call	selectP1
	ld	(0fffe),a
	ret

		
			
selectP1:
	call	SPD_OFF
	ld	a,96
	ld	(copyline),a
	call	showCart
	ld	b,120
.wait:	ei	
	halt
	djnz	.wait
	
	call	hideCart
	call	SPD_ON
	
.loop:		
	ei
	halt
	call	MoveHand
	call	PutHand
	call	TestF
	jr	z,.loop
	
	call	searchButton
	or	a
	jr	z,.loop
	dec	a
	out	(2fh),a
	ret

		

	



	
getNumbers:
	call	showCart
	call	SPD_ON
	ld	hl,rcopy1p
	ld	(copyptr),hl

.loop:		
	ei
	halt
	call	MoveHand
	call	PutHand
	call	searchButton
	or	a
	jr	nz,.one
.erase:		
	ld	hl,(copyptr)
	call	WAIT_COM
	call	COPYVRAM
	jr	.loop
	
.one:	dec	a
	cp	4
	jr	nz,.two
	ld	hl,rcopy1p
	ld	(copyptr),hl	
	ld	hl,copy1p
	ld	a,1
	jr	.tfire
	
.two:	cp	5
	jr	nz,.erase  
	ld	hl,rcopy2p
	ld	(copyptr),hl
	ld	hl,copy2p
	ld	a,2

.tfire:
	ld	(nplayers),a
	CALL	WAIT_COM
	CALL	COPYVRAM
	call	TestF
	jr	z,.loop
	call	SPD_OFF
	call	hideCart
	ret	



	
	

;;; e <-x
;;; d <- y

searchButton:
	ld	hl,COOR_XY
	ld	d,(hl)
	inc	hl
	ld	e,(hl)
	ld	hl,Pos-5
.next1:			
	inc	hl
.next2:			
	inc	hl
.next3:			
	inc	hl
.next4:			
	inc	hl

	inc	hl
			
	ld	a,(hl)
	or	a
	ret	z
		
	cp	e
	jr	nc,.next1
	inc	hl	
	ld	a,(hl)
	cp	d
	jr	nc,.next2
	
	inc	hl
	ld	a,(hl)
	cp	e
	jr	c,.next3
	inc	hl
	ld	a,(hl)
	cp	d
	jr	c,.next4
	inc	hl
	ld	a,(hl)
	ret
	
	

Pos:	db	143,90,167,99,6
	db	88,90,113,99,5
	db	1,1,127,107,1
	db	128,1,254,107,4
	db	1,108,129,208,2
	db	128,129,254,208,3
	db	0

	



hideCart:

	ld	e,80
	ld	d,80+44
	ld	b,46/2

.1:	ei
	halt
	
	ld	a,e
	inc	e
	ld	(copylineI+2),a
	ld	(copylineI+6),a
	exx
	CALL	WAIT_COM
	ld	hl,copylineI
	CALL	COPYVRAM
	exx
 
    	
	ld	a,d
	dec	d
	ld	(copylineI+2),a
	ld	(copylineI+6),a
	exx
	CALL	WAIT_COM
	ld	hl,copylineI  
	CALL	COPYVRAM
	exx
	djnz .1

	ei
	halt

	ld	a,80+43/2+2
	ld	(copylineI+2),a
	ld	(copylineI+6),a
	call	WAIT_COM
	ld	hl,copylineI
	call	COPYVRAM
	ret
	 
	

	
	
showCart:
	ld	e,211+44/2
	ld	d,211+44/2+1
	ld	h,80+44/2
	ld	l,80+44/2+1
	ld	b,44/2

.1:	ei
	halt
		
	
	ld	a,e
	dec	e
	ld	(copyline+2),a
	ld	a,h
	dec	h
	ld	(copyline+6),a
	exx
	CALL	WAIT_COM
	ld	hl,copyline
	CALL	COPYVRAM
	exx

	
	ld	a,d
	inc	d
	ld	(copyline+2),a
	ld	a,l
	inc	l
	ld	(copyline+6),a
	exx
	CALL	WAIT_COM
	ld	hl,copyline
	CALL	COPYVRAM
	exx
	djnz .1
	ret
		
	

MoveHand:	
	call	ST_AMPL	
	ld	a,(JOYPORT1)
	ld	b,a
	ld	a,(JOYPORT2)
	or	b

	ld	hl,OffsetX
	bit	2,a
	jr	z,.derecha
	ld	b,a
	ld	a,(COOR_XY+1)
	or	a
	ld	a,b	
	jr	z,.derecha
	dec	(hl)
	dec	(hl)	
	
.derecha:	
	bit	3,a
	jr	z,.abajo
	ld	b,a
	ld	a,(COOR_XY+1)
	cp	224
	ld	a,b
	jr	z,.abajo
	inc	(hl)
	inc	(hl)		

.abajo:	ld	hl,OffsetY
	bit	1,a
	jr	z,.arriba
	ld	b,a
	ld	a,(COOR_XY)
	cp	182
	ld	a,b	
	jr	z,.arriba
	inc	(hl)
	inc	(hl)	

.arriba:		
	bit	0,a
	ret	z
	ld	a,(COOR_XY)
	or	a
	ret	z
	dec	(hl)
	dec	(hl)	
	ret







PutHand: 
	ld	hl,COOR_XY
	ld	b,8
	
.loop:		
	ld	e,(hl)
	ld	a,(OffsetY)
	add	a,e
	ld	(hl),a
	inc	hl
	ld	e,(hl)
	ld	a,(OffsetX)
	add	a,e
	ld	(hl),a
	inc	hl
	inc	hl
	inc	hl 
	djnz	.loop
	
	ld	a,1
	ld	hl,COOR_XY
	ld	de,03600h	
	ld	bc,32
	call	wvram
	xor	a
	ld	(OffsetX),a
	ld	(OffsetY),a
	ret
	
		





	

;NOMBRE: COPYVRAM
;OBJETIVO: COPIAR UN BLOQUE DE VRAM A VRAM
;	     Tambien es usada para otros comandos con igual
;	     numero de parametros.
;ENTRADA: HL -> PUNTERO A LOS DATOS DEL COPY.


COPYVRAM:	
	DI
	LD	A,32
	OUT	(99h),A
	LD	A,128+17
	OUT	(99h),A

	LD	C,9Bh
	LD	B,15
	OTIR
	EI
	RET

;NOMBRE: TESTCOM
;AUTOR: ROBERTO VARGAS CABALLERO
;OBJETIVO: ESTA FUNCIOM COMPRUEBA SI  SE ESTA EJECUTANDO UN COMANDO DEL VDP
;SALIDA: Z: SI SE HA ACABADO EL COMANDO Z VALDAR 0, EN CASO CONTRARIO VALDRA 1
;MODIFICA: AF,AF',C


TESTCOM:	LD	C,99h
	LD	A,2
	DI
	OUT	(C),A
	LD	A,128+15
	OUT	(C),A
	IN	A,(C)
	EX	AF,AF'
	XOR	A
	OUT	(C),A
	LD	A,128+15
	OUT	(C),A
	EI
	EX	AF,AF'
	BIT	0,A
	RET




;NOMBRE: WAIT_COM
;OBJETIVO: ESPERAR HASTA QUE SE PRODUZCA EL FINAL DE UN COMANDO DEL VDP


WAIT_COM:	CALL	TESTCOM
	JR	NZ,WAIT_COM
	RET



;NOMBRE: SPD_OFF
;OBJETIVO: ESTA FUNCION DESHABILITA LOS SPRITES
;MODIFICA: A


SPD_OFF:	DI
	LD	A,(RG8SAV)
	SET	1,A
	LD	(RG8SAV),A
	OUT	(99h),A
	LD	A,88H
	OUT	(99h),A
	EI
	RET
	
	
;NOMBRE: SPD_ON
;OBJETIVO: ESTA FUNCION HABILITA LOS SPRITES
;MODIFICA: A


SPD_ON:	DI
	LD	A,(RG8SAV)
	RES	1,A
	LD	(RG8SAV),A
	OUT	(99h),A
	LD	A,128+8
	OUT	(99h),A
	EI
	RET
		
	
	
;NOMBRE: FADE_OFF
;OBJETIVO: HACER UN FADE A NEGRO DE LA PALETA ACTUAL


FADE_OFF:	
	LD	DE,PALETAW1
	LD	BC,32
	LDIR
	LD	HL,PAL_NEGRO
	LD	(PALETAD1),HL
	JR	PUT_FADET



;NOMBRE: FADE_ON
;OBJETIVO: HACER UN FADE DE NEGRO A LA PALETA ACTUAL


FADE_ON:
	EXX	
	LD	HL,PAL_NEGRO
	LD	DE,PALETAW1
	LD	BC,32
	LDIR
	EXX
	LD	(PALETAD1),HL


PUT_FADET:	LD	B,16	;ESTA LA QUE REALMENTE SE ENCARGA DE
;                                       ;HACER LOS FADES
PFADE_OFFB:	
	PUSH	BC
PFADE_OFFW:		
	LD	A,(TIME)
	OR	A
	JR	NZ,PFADE_OFFW

	LD	DE,(PALETAD1)
	LD	IX,PALETAW1
	LD	HL,PALETAW1
	CALL	DOFADE



	LD	HL,PALETAW1
	LD	DE,PAL_GM
	LD	BC,32
	LDIR

	DI
	LD	A,TIMEFADE
	LD	(TIME),A
	EI

	POP	BC
	DJNZ	PFADE_OFFB

	

	RET






;NOMBRE: DOFADE
;OBJETIVO: REALIZA UN PASO DE FADE ENTRE DOS PALETAS
;ENTRADA: HL -> PALETA INICIAL
;         DE -> PALETA DESTINO
;SALIDA: (IX)-> RESULTADO DEL FADE




DOFADE:	LD	B,32

DOFADE1:		
	PUSH	BC
	LD	A,(HL)
	AND	7
	LD	C,A
	LD	A,(DE)
	AND	7
	CP	C
	JR	Z,DOFADEIG
	JR	C,DOFADEMAY
	INC	C
	JR	DOFADEIG
DOFADEMAY:		
	DEC	C

DOFADEIG:		
	LD	A,(HL)
	AND	070H
	LD	B,A
	LD	A,(DE)
	AND	070H
	CP	B
	JR	Z,DOFADEIG2
	JR	C,DOFADEMAY2
	LD	A,B
	ADD	A,16
	LD	B,A
	JR	DOFADEIG2
DOFADEMAY2:		
	LD	A,B
	SUB	16
	LD	B,A
DOFADEIG2:		
	LD	A,C
	ADD	A,B
	LD	(IX),A
	INC	IX
	INC	HL
	INC	DE
	POP	BC
	DJNZ	DOFADE1

	RET




XINICIAL:	equ	128
YINICIAL:	equ	96		



	
		


COLOR0_OFF:	DI
	LD	A,(RG8SAV)
	SET	5,A
	LD	(RG8SAV),A
	OUT	(99h),A
	LD	A,128+8
	OUT	(99h),A
	EI
	RET


Interrupt:
	push	af
	in	a,(99h)
	add	a,a
	jp	c,oldvector1

	ld	a,1		;PONEMOS EL REGISTRO DE ESTADO 1  
	out	(99h),a		;PARA COMPROBAR EL VALOR DEL FLAG
	ld	a,128+15	;INTERRUPCION HORIZONTAL
	out	(99h),a

	in	a,(99h)
	rrca
	jp	nc,endint

	push	hl
	push	de
	push	bc
	
	ld	a,2
	out	(99h),a
	ld	a,128+15
	out	(99h),a

	ld	b,29*3
	ld	hl,PalletteSFX2
	ld	a,(pointer)
	ld	(aux),a
	inc	a
	cp	138
	jr	nz,.2
	xor	a
	

.2:	ld	c,a
	ld	a,(counter)
	inc	a
	ld	(counter),a
	cp	1
	ld	a,c	
	jp	nz,.1
	
	xor	a
	ld	(counter),a
	ld	a,c
	ld	(pointer),a
	ld	(aux),a
	
.1:	
	add	a,a	
	ld	e,a
	ld	d,0
	add	hl,de
	ld	c,9ah
	

.loop:

	ld	a,1
	call	ChangeColor

	ld	hl,PalletteSFX2
	ld	a,(aux)
	inc	a
	cp	138
	jp	nz,.3
	xor	a
	
.3:	ld	(aux),a	
	ex	de,hl
	ld	l,a
	ld	h,0
	add	hl,hl	
	add	hl,de
	
.waitnhr:		
	in	a,(99h)
	and	20h
	jp	nz,.waitnhr

		

.waithr:		
	in	a,(99h)
	and	20h
	jp	z,.waithr

	outi
	outi		
	djnz	.loop

	pop	bc
	pop	de
	pop	hl
	
	

endint:

	xor	a
	out	(99h),a
	ld	a,128+15
	out	(99h),a
	pop	af
	ei
	reti







PalletteSFX2:
	RGB	0,1,0		; 1
	RGB	0,2,0
	RGB	0,3,0
	RGB	0,4,0
	RGB	0,5,0
	RGB	0,5,0	
	RGB	0,6,0
	RGB	0,6,0	
	RGB	0,6,0
	RGB	0,7,0
	RGB	0,7,0
	RGB	0,7,0	
	RGB	0,7,0
	RGB	0,6,0	
	RGB	0,6,0
	RGB	0,6,0	
	RGB	0,5,0
	RGB	0,5,0	
	RGB	0,4,0
	RGB	0,3,0
	RGB	0,2,0
	RGB	0,1,0
	RGB	0,0,0


	RGB	1,1,0		; 2
	RGB	2,2,0
	RGB	3,3,0
	RGB	4,4,0
	RGB	5,5,0
	RGB	5,5,0	
	RGB	6,6,0
	RGB	6,6,0	
	RGB	6,6,0
	RGB	7,7,0
	RGB	7,7,0
	RGB	7,7,0	
	RGB	7,7,0
	RGB	6,6,0	
	RGB	6,6,0
	RGB	6,6,0	
	RGB	5,5,0
	RGB	5,5,0	
	RGB	4,4,0
	RGB	3,3,0
	RGB	2,2,0
	RGB	1,1,0
	RGB	0,0,0

	RGB	1,0,0		; 3
	RGB	2,0,0
	RGB	3,0,0
	RGB	4,0,0
	RGB	5,0,0
	RGB	5,0,0	
	RGB	6,0,0
	RGB	6,0,0	
	RGB	6,0,0
	RGB	7,0,0
	RGB	7,0,0
	RGB	7,0,0	
	RGB	7,0,0
	RGB	6,0,0	
	RGB	6,0,0
	RGB	6,0,0	
	RGB	5,0,0
	RGB	5,0,0	
	RGB	4,0,0
	RGB	3,0,0
	RGB	2,0,0
	RGB	1,0,0
	RGB	0,0,0

	RGB	1,0,1		; 4
	RGB	2,0,2
	RGB	3,0,3
	RGB	4,0,4
	RGB	5,0,5
	RGB	5,0,5	
	RGB	6,0,6
	RGB	6,0,6	
	RGB	6,0,6
	RGB	7,0,7
	RGB	7,0,7
	RGB	7,0,7	
	RGB	7,0,7
	RGB	6,0,6	
	RGB	6,0,6
	RGB	6,0,6	
	RGB	5,0,5
	RGB	5,0,5	
	RGB	4,0,4
	RGB	3,0,3
	RGB	2,0,2
	RGB	1,0,1
	RGB	0,0,0

	RGB	0,0,1		; 5
	RGB	0,0,2
	RGB	0,0,3
	RGB	0,0,4
	RGB	0,0,5
	RGB	0,0,5	
	RGB	0,0,6
	RGB	0,0,6	
	RGB	0,0,6
	RGB	0,0,7
	RGB	0,0,7
	RGB	0,0,7	
	RGB	0,0,7
	RGB	0,0,6	
	RGB	0,0,6
	RGB	0,0,6	
	RGB	0,0,5
	RGB	0,0,5	
	RGB	0,0,4
	RGB	0,0,3
	RGB	0,0,2
	RGB	0,0,1
	RGB	0,0,0

	RGB	0,1,1		; 6
	RGB	0,2,2
	RGB	0,3,3
	RGB	0,4,4
	RGB	0,5,5
	RGB	0,5,5	
	RGB	0,6,6
	RGB	0,6,6	
	RGB	0,6,6
	RGB	0,7,7
	RGB	0,7,7
	RGB	0,7,7	
	RGB	0,7,7
	RGB	0,6,6	
	RGB	0,6,6
	RGB	0,6,6	
	RGB	0,5,5
	RGB	0,5,5	
	RGB	0,4,4
	RGB	0,3,3
	RGB	0,2,2
	RGB	0,1,1
	RGB	0,0,0

				
	
oldvector1:
	ld	a,(TIME)
	or	a
	jp	z,.2
	dec	a
	ld	(TIME),a

.2:	
	
	LD	HL,PAL_GM
	CALL	PutPal
		
	pop	af
	ei
	reti

	
newvector:
	jp	Interrupt
	


	
	
		
ColourSFX:
	call	VIS_OFF
	ld	hl,gtitle
	ld	de,0
	scf
	call	UnTCFV

	ld	a,2
	call	VER_PAGE
	ld	hl,PAL_NEGRO
	ld	hl,TitlePallette	
	call	PutPal
	call	VIS_ON
	
	ld	a,LINEINT
	call	SETVDP_LI
	ld	hl,TitlePallette
	CALL	FADE_ON	
	call	waitKB
	call	waitnKB
	CALL	RESVDP_LI
	LD	HL,TitlePallette
	call	FADE_OFF
	
	
	ret
	



waitKB:			
.loop:	
	call	ST_AMPL	
	ld	a,(JOYPORT1)
	ld	b,a
	ld	a,(JOYPORT2)
	or	b
	ret	nz
	jr	.loop

	
waitnKB:	
.loop:	
	call	ST_AMPL	
	ld	a,(JOYPORT1)
	ld	b,a
	ld	a,(JOYPORT2)
	or	b
	ret	z
	jr	.loop
		

	

TestF:	
	call	ST_AMPL
	ld	a,(JOYPORT1)
	bit	4,a
	ret	nz
	ld	a,(JOYPORT2)
	bit	4,a
	ret	
	

	
RestVDP:				
	ld	hl,oldvector
	ld	de,0fd9ah
	ld	bc,5
	di
	ldir
	ei

	ld	hl,PAL_NEGRO
	call	PutPal
	call	RESVDP_LI
	call	VIS_OFF
	ret

	
	
		

	
					
InitVDP:	
	ld	a,5
	call	initscr
	call    SET_SPD16
	call	COLOR0_OFF
	xor	a	
	call	SET_CFONDO
	ld	hl,TitlePallette
	ld	de,PAL_GM
	ld	bc,32
	ldir
	call	SPD_OFF
	
	ld	hl,0fd9ah
	ld	de,oldvector
	ld	bc,5
	di
	ldir
	ei

	ld	hl,newvector
	ld	de,0fd9ah
	ld	bc,5
	di
	ldir
	ei

	ret
	




	
BuildHand:	
	ld	l,230
	ld	a,1
	ld	de,3600h
	ld	bc,4*32
	call	svram

	
	ld	l,13
	ld	a,1
	ld	de,03400h
	ld	bc,64
	call	svram
	
	ld	l,0
	ld	a,1
	ld	de,03440h
	ld	bc,64
	call	svram
		
	ld	a,1
	ld	hl,hand
	ld	de,03800h
	ld	bc,100h
	call	wvram
	
	ld	a,1
	ld	hl,COOR_XY
	ld	de,03600h	
	ld	bc,32
	call	wvram	
	ret



VIS_ON:	DI
	LD	A,(RG1SAV)
	SET	6,A
	LD	(RG1SAV),A
	OUT	(99h),A
	LD	A,128+1
	OUT	(99h),A
	EI
	RET

	

VIS_OFF:	
	DI
	LD	A,(RG1SAV)
	RES	6,A
	LD	(RG1SAV),A
	OUT	(99h),A
	LD	A,128+1
	OUT	(99h),A
	EI
	RET


	
	
;NOMBRE: SET_CFONDO
;OBJETIVO: COLOCAR UN COLOR DE FONDO.
;ENTRADA: A -> COLOR
;MODIFICA: A


SET_CFONDO:	
	DI
	OUT	(99h),A
	LD	A,128+7
	OUT	(99h),A
	EI
	RET


	
ChangeColor:	
	di
	out	(99h),a
	ld	a,128+16
	out	(99h),a

	ret
		
	
	
		
	
PutPal:	di
	xor	a
	out	(99h),a
	ld	a,128+16
	out	(99h),a
	ld	b,32
	ld	c,9Ah
	otir
	ei
	ret
	
Pallette:		
	db 11h,1, 73h,4, 70h,0, 44h,4, 00h,5, 50h,3, 27h,2, 70h,6
	db 70h,4, 77h,7, 40h,1, 00h,0, 37h,5, 57h,0, 65h,0, 76h,4

ColorChange:	db	0
	
TitlePallette:
	db  00h,0, 00h,6, 02h,0, 40h,2, 14h,0, 27h,0, 50h,0, 37h,4
	db  70h,0, 73h,4, 70h,6, 74h,7, 03h,4, 62h,3, 50h,2, 77h,7
		
SelectPallette:
	dw 0000h,0333h,0630h,0574h,0026h,0237h,0040h,0547h
	dw 0060h,0463h,0570h,0774h,0420h,0251h,0555h,0777h

		
VER_PAGE:
	DI	
	LD HL,PAGE0
	LD C,A
	LD B,0
	ADD HL,BC
	LD A,(HL)
	
	OUT	(99h),A
	LD	A,128+2
	OUT	(99h),A
	EI
	RET

PAGE0:		DB 00011111B
PAGE1:		DB 00111111B 
PAGE2:		DB 01011111B
PAGE3:		DB 01111111B		
	
	
			  	

SET_SPD16:	DI
	LD	A,(RG1SAV)
	SET	1,A
	LD	(RG1SAV),A
	OUT	(99h),A
	LD	A,128+1
	OUT	(99h),A
	EI
	RET

	
SETVDP_LI:	
	DI
	OUT	(99h),A
	LD	A,128+19
	OUT	(99h),A

	LD	A,(RG0SAV)
	SET	4,A
	OUT	(99h),A
	LD	A,128+0
	OUT	(99h),A
	EI
	RET


;NOMBRE: RESVDP_LI
;OBJETIVO: DESACTIVAR LAS INTERRUPCIONES HORIZONTALES


RESVDP_LI:	DI
	LD	A,(RG0SAV)
	RES	4,A
	OUT	(99h),A
	LD	A,128+0
	OUT	(99h),A
	EI
	RET	
		



;;; Parametros de entrada
;;; hl -> Direccion RAM
;;; de -> Direccion VRAM
;;; bc -> contador;
;;; a -> Pagina
	

wvram:	call	setVram
	call	WriteVRAM
	ret


svram:	call	setVram
	call	FillVRAM
	ret
	

FillVRAM:
	ld	a,b
	or	c
	ret	z

	ld	a,l	
.FillVRAM1:		
	out	(98h),a
	dec	bc
	jp	nz,FillVRAM
	

	
		
WriteVRAM:
	ld	d,b
	ld	e,c
	ld	c,98h
	
	xor	a
	or	d
	ld	b,0
	jr	z,.end
.loop:	otir
	dec	d
	jr	nz,.loop	
			
.end:	ld	b,e
	otir
	ret
	
		
SetVram:	
	DI	
	PUSH	AF
	LD	A,E	;Y ENVIRLA COMO PUNTERO RAM
	OUT	(99h),A	;AL VDP
	LD	A,D	
	AND	3Fh
	OR	40h
	OUT	(99h),A	
                                     

	POP	AF		; AHORA ESCRIBO LA PAGINA
	OUT	(99h),A	    
	LD	A,128+14	
	OUT	(99h),A	   
	EI
	RET
	
	
	
		
InitScr:	
;;; ld	iy,(EXBRSA-1)
;;; ld	ix,CHGMOD
;;; call	CALSLT
	call	05fh
	ret


	
	
	
ST_AMPL:

        ld      e,8Fh           ;'~O'
        call    LEE_JOY           ;[88DEh]
        ld      (JOYPORT1),a       ;[9439h]
        ld      e,0CFh          ;'-bœ'-A
        call    LEE_JOY           ;[88DEh]
        ld      (JOYPORT2),a       ;[943AH]

        push    bc
        push    af

        ld      b,0
        ld      a,8
        call    SNSMAT
        bit     0,a
        jr      nz,nojoy
        set     4,b

nojoy:
        and     0f0h
        bit     7,a     ;leeR
        jr      nz,LEE_JOY_D
        set     3,a

LEE_JOY_D:
        bit     6,a
        jr      nz,LEE_JOY_U
        set     1,a
LEE_JOY_U:
        bit     5,a
        jr      nz,LEE_JOY_L
        set     0,a
LEE_JOY_L:
        bit     4,a
        jr      nz,LEE_JOY_2
        set     2,a
	
LEE_JOY_2:
        and     0fh
	or	b
		
        ld      b,a

        ld      hl,JOYPORT1
        or      (hl)
        ld      (hl),a

        ld      a,b

        ld      hl,JOYPORT2
        or      (hl)
        ld      (hl),a

        pop     af
        pop     bc
        ret
	


		
LEE_JOY:
        ld      a,0Fh
        call    WRTPSG
        ld      a,0Eh
        call    RDPSG
        cpl
        and     1Fh
        ret
	





; in: hl = source
;     de = destination
; changes: af,af',bc,de,hl,ix

UnTCF:: ld      ix,-1           ; last_m_off

        ld      a,[hl]          ; read first byte
        inc     hl
        scf
        adc     a,a
        jr      nc,.endlit

.litlp: ldi
.loop:  call    GetBit
        jp      c,.litlp
.endlit:

        push    de              ; save dst
        ld      de,1
.moff:  call    GetBit
        rl      e
        rl      d
        call    GetBit
        jr      c,.gotmoff
        dec     de
        call    GetBit
        rl      e
        rl      d
        jp      nc,.moff
        pop     de              ; end of compression
        ret

.gotmoff:
        ex      af,af'
        ld      bc,0            ; m_len
        dec     de
        dec     de
        ld      a,e
        or      d
        jr      z,.prevdist
        ld      a,e
        dec     a
        cpl
        ld      d,a
        ld      e,[hl]
        inc     hl
        ex      af,af'
        ; scf - carry is already set!
        rr      d
        rr      e
        ld      ixl,e
        ld      ixh,d
        jp      .newdist
.prevdist:
        ex      af,af'
        ld      e,ixl
        ld      d,ixh
        call    GetBit
.newdist:
        jr      c,.mlenx
        inc     bc
        call    GetBit
        jr      c,.mlenx

.mlen:  call    GetBit
        rl      c
        rl      b
        call    GetBit
        jp      nc,.mlen
        inc     bc
        inc     bc
.gotmlen:
        ex      af,af'
        ld      a,d
        cp      -5
        jp      nc,.nc
        inc     bc
.nc:    inc     bc
        inc     bc
        ex      af,af'

        ex	[sp],hl		; save src, and get dst in hl, de = offset
        ex      de,hl           ; de = dst, hl = offset
        add     hl,de           ; new src = dst+offset
        ldir
        pop	hl		; get src back
        jp      .loop

.mlenx: call    GetBit
        rl      c
        rl      b
        jp      .gotmlen


	
	
	
			

; decompresses to VRAM
; in: hl = source
;     de = destination
;     cf = carry 0 for low 64K, 1 for high 64K
; changes: af,af',bc,de,hl,ix
; note: does NOT check for CE. destination must be 80h aligned.

UnTCFV:
	push	af
	push	de
	push	hl
	push	bc
	ld	hl,hmmc_sh
	ld	de,hmmc
	ld	bc,11
	ldir
	pop	bc
	pop	hl
	pop	de
	pop	af
		
	ld      ix,-1           ; last_m_off

	ld	a,d
        rla
        rla
        and	00000011b
        ld	[hmmc+3],a
        and     00000010b
        ld      iyl,a

	ld	a,e
	add	a,a
	ld	a,d
	adc	a,a
	ld	[hmmc+2],a

        ld      a,[hl]          ; read first byte
        inc     hl
        scf
        adc     a,a
        ;jr      nc,.endlit

	ex	af,af'
	ld	a,[hl]
	inc	hl
        ld	[hmmc+8],a
	inc	de

        ld      a,36                    ; start HMMC
.di1:	di
        out     [99h],a
        ld      a,17+128
        out     [99h],a
	ei	
	push	hl
        ld      hl,hmmc
        ld      bc,0B9Bh
        otir
        pop	hl
        ld      a,44+128                ; continue HMMC
.di2:	di
	out     [99h],a
        ld      a,17+128
        out     [99h],a
	ei	
        ex	af,af'
	jp	.loop

.litlp: outi
        inc     de

.loop:  call    GetBit
        jp      c,.litlp
.endlit:

        push    de              ; save dst
        ld      de,1
.moff:  call    GetBit
        rl      e
        rl      d
        call    GetBit
        jr      c,.gotmoff
        dec     de
        call    GetBit
        rl      e
        rl      d
        jp      nc,.moff

	xor	a		; stop HMMC
.di3:	di
	out	[99h],a
	ld	a,46+128
	out	[99h],a
	ei

        pop     de              ; end of compression
        ret

.gotmoff:
        ex      af,af'
        ld      bc,0            ; m_len
        dec     de
        dec     de
        ld      a,e
        or      d
        jr      z,.prevdist
        ld      a,e
        dec     a
        cpl
        ld      d,a
        ld      e,[hl]
        inc     hl
        ex      af,af'
        ; scf - carry is already set!
        rr      d
        rr      e
        ld      ixl,e
        ld      ixh,d
        jp      .newdist

.mlenx: call    GetBit
        rl      c
        rl      b
        jp      .gotmlen

.prevdist:
        ex      af,af'
        ld      e,ixl
        ld      d,ixh
        call    GetBit
.newdist:
        jr      c,.mlenx
        inc     bc
        call    GetBit
        jr      c,.mlenx

.mlen:  call    GetBit
        rl      c
        rl      b
        call    GetBit
        jp      nc,.mlen
        inc     bc
        inc     bc
.gotmlen:
        ex      af,af'
        ld      a,d
        cp      -5
        jp      nc,.nc
        inc     bc
.nc:	inc     bc
        inc     bc

	ex	[sp],hl		; save src, and get dst in hl, de = offset
        ex      de,hl           ; de = dst, hl = offset
        add     hl,de           ; new src = dst+offset

        ld      a,h
        and     11000000b
        rlca
	or	iyl
        rlca
.di4:	di
        out     [99h],a
        ld      a,14+128
	ei
        out     [99h],a
        ld      a,l
	di
.di5:   out     [99h],a
        ld      a,h
        and     00111111b
        out     [99h],a
	ei	
	
	inc	hl
	sbc	hl,de
	jp	z,.unbuffer
	
	ex	de,hl
	add	hl,bc
	ex	de,hl

.matchlp:
        in      a,[98h]                 ; read byte
        dec     bc
        out     [9Bh],a                 ; write byte
        ld      a,c
        or      b
        jp      nz,.matchlp
        ex      af,af'

        pop	hl			; get src back
	ld	c,9Bh
        jp      .loop

.unbuffer:
	ex	de,hl
	add	hl,bc
	ex	de,hl

        in      a,[98h]                 ; read byte
	ld	iyh,a
.bufmatch:
	ld	a,iyh
        out     [9Bh],a                 ; write byte
        dec     bc
        ld      a,c
        or      b
        jp      nz,.bufmatch 
        ex      af,af'

        pop	hl			; get src back
	ld	c,9Bh
        jp      .loop

	
GetBit: add     a,a
        ret     nz
        ld      a,[hl]          ; read new byte
        inc     hl
        adc     a,a             ; cf = 1, last bit shifted is always 1
        ret
	

			

	
hand:	 db 060h,078h,05eh,03fh,017h,00fh,005h,002h
	 db 005h,00bh,00bh,007h,006h,008h,00eh,00fh
	 db 000h,000h,000h,080h,0e0h,0f8h,01eh,0e7h
	 db 0ffh,0ffh,05fh,03fh,03fh,01fh,09eh,00eh
	 db 000h,000h,000h,000h,000h,000h,000h,080h
	 db 0e0h,0f8h,0feh,0bfh,07fh,07fh,0feh,0fch
	 db 000h,000h,000h,000h,000h,000h,000h,000h
	 db 000h,000h,000h,080h,0e0h,018h,004h,004h
	 db 002h,00ch,00eh,007h,001h,000h,000h,000h
	 db 000h,000h,000h,000h,000h,000h,000h,000h
	 db 011h,05eh,09eh,01eh,00fh,000h,000h,000h
	 db 000h,000h,000h,000h,000h,000h,000h,000h

	 db 0fch,0f8h,0f8h,0f8h,078h,038h,018h,008h
	 db 00ch,005h,006h,003h,001h,000h,000h,000h
	 db 00ah,006h,00ah,016h,02ah,016h,02ah,056h
	 db 0ach,054h,0a8h,050h,0e0h,000h,000h,000h
	
	 db 078h,0feh,0ffh,07fh,03fh,01fh,00fh,007h
	 db 00fh,01fh,01fh,01fh,01fh,01fh,01fh,01fh
	 db 000h,000h,080h,0e0h,0f8h,0feh,0ffh,0ffh
	 db 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	 db 000h,000h,000h,000h,000h,000h,080h,0e0h
	 db 0f8h,0feh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	 db 000h,000h,000h,000h,000h,000h,000h,000h
	 db 000h,000h,080h,0e0h,0f8h,0fch,0feh,0ffh
	 db 01fh,01fh,01fh,00fh,007h,001h,000h,000h
	 db 000h,000h,000h,000h,000h,000h,000h,000h
	 db 0ffh,0ffh,0ffh,0ffh,0dfh,08fh,000h,000h
	 db 000h,000h,000h,000h,000h,000h,000h,000h
	 db 0ffh,0ffh,0ffh,0ffh,0ffh,07fh,03fh,01fh
	 db 01fh,00fh,00fh,007h,003h,001h,000h,000h
 	 db 0feh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	 db 0feh,0feh,0fch,0f8h,0f0h,0e0h,000h,000h


datab:	equ	$	


hmmc_sh:  db     0,0,0,0
        db     0,1,0,3
        db     0,0,F0h

	
COOR_XY_sh: 
	 db YINICIAL,XINICIAL
	 db 0,0
	 db YINICIAL,XINICIAL+16
	 db 4,0
	 db YINICIAL+16,XINICIAL
	 db 8,0
	 db YINICIAL+16,XINICIAL+16
	 db 12,0

		
	 db YINICIAL,XINICIAL
	 db 16,0
	 db YINICIAL,XINICIAL+16
	 db 20,0
	 db YINICIAL+16,XINICIAL
	 db 24,0
	 db YINICIAL+16,XINICIAL+16
	 db 28,0
	

rcopy1p_sh:	db	1,0,   213,3, 80,0,  82,3, 32,0, 18,0, 0,0, 0d0h
rcopy2p_sh:	db	56,0,  213,3, 136,0, 82,3, 32,0, 18,0, 0,0, 0d0h		
copy1p_sh:		db	224,0, 213,3, 87,0,  82,3, 32,0, 18,0, 0,0, 0d0h
copy2p_sh:		db	224,0, 237,3, 136,0, 82,3, 32,0, 18,0, 0,0, 0d0h
copyptr_sh:	dw	0
nplayers_sh:	db	0		
copyscr_sh:	db	0,0,   0,3,   0,0,   0,1,   255,0, 0,1,  0,0, 0d0h
buildp2_sh:	db	192,0, 211,1, 161,0, 211,1, 32,0,  45,0, 0,0, 0d0h	
copyline_sh:	db	0,0,   212,3, 80,0,  80,3,  96,0,  1,0,  0,0, 0d0h
copylineI_sh:	db	80,0,  0,1,   80,0,  0,3,   96,0,  1,0,  0,0, 0d0h	
Pointer_sh:	db	0
counter_sh:	db	0
TIME_sh:	db	0	
OffsetX_sh:	db	0
OffsetY_sh:	db	0	



datae:		equ $	

	
	
end:		equ	$



section	rdata

	
databss:	equ	$
hmmc:		rb	11
COOR_XY:	rw	16	
rcopy1p:	rb	15
rcopy2p:	rb	15
copy1p:		rb	15
copy2p:		rb	15
copyptr:	rw	1
nplayers:	rb	1		
copyscr:	rb	15
buildp2:	rb	15
copyline:	rb	15
copylineI:	rb	15
Pointer:	rb	1
counter:	rb	1
TIME:		rb	1
OffsetX:	rb	1
OffsetY:	rb	1	

	
bufmatch_v:	rb	1	
hmod:		rb	1
aux:		rb	1	
oldvector:	rb	5			
JOYPORT1:	rb	1
JOYPORT2:	rb	1
PALETAD1:	rw	1
PALETAW1:	rb	32
PAL_GM:		rb	32

