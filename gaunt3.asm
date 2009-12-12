%include "tniasm.inc"
%include "z80r800.inc"
%include "z80().inc"

MainLoop:	equ	0b258h
SetPtrVram:	equ	0b444h
NumSP:		equ	800h
WriteSpPat:	equ	0ba6fh
WritePortRW:	equ	0b587h
VramSpAtt:	equ	5e00h
VramSpColour:	equ	5c00h	 
Rg0Sav:		equ	0f3dfh
Rg1Sav:		equ	0f3e0h	
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
RowKeyb:	equ     847Fh


;;; Hay que trasladar los cambios de patrones
;;; a todas las paginas (pociones, jamon y todo eso
;;; LA FUNCION QUE SE ENCARGA DE ACTUALIZAR POSICION SPRITE PERSONAJE
;;; DoViewPJs


	
	
	fname	"gaunt.bin",0
	forg	0
	db	0feh
	dw	8000h
	dw	0ca20h
	dw	8000h


	forg	8400h-LdAddress
	org	8400h
	jp	0b90fh		;evito inicio
	

	forg	0b38ah-LdAddress
	ret			;avoid tape message 
	

	forg 0956ch-LdAddress
	call	PutBios		; Put Bios and Rom slot
	
	forg 09578h-LdAddress
	call	4014h		; Patch to read mazes from ROM
        call    PutSlotRam      ;[95CDh]
	ei
        ld      iy,RowKeyb      ;[847Fh]
        jp      0D000h          ;Esta es la direccion de ejecucion del bloque
	



SaveSP:		equ	0dffdh	
RamSlotPage1J:	equ	401Ah
		
	forg	095cdh-LdAddress
	org	095cdh
;;; PutSlotRam
	call	RamSlotPage1J		; Put again ram pages
	ld	a,(Rampage0)	
	call	ENASLT_0
	ret
	

		 
SetPtr_VRAM:	equ	0b444h		

	
  
;CAMBIO DE SC2 a SC4

	forg	0b9e3h-LdAddress
	jp	Sc2toSc4

	forg	0b8e1h-LdAddress
	org	0b8e1h
	
Sc2toSc4:
	di	
	call	sc4
	ld	a,10111111b
	out	(c),a
	ld	a,128+5
	out	(c),a
	ld	hl,Pallette
	call	PutPal
	ei
	jp	MainLoop




	forg 0ba8dh-LdAddress
	org 0ba8dh

SetVRAM:	equ 0b5dch
	
Pallette:		
	db 11h,1, 73h,4, 70h,0, 44h,4, 00h,5, 50h,3, 27h,2, 70h,6
	db 70h,4, 77h,7, 40h,1, 00h,0, 37h,5, 57h,0, 65h,0, 76h,4

	

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



DisableSCR:	equ	0b5E9h
PatternGenPers:	equ	2800h
WritePortRW_8:	equ	0b585h
PatternMap:	equ	0c000h					



;;; Rutina reubicada  -> espacio libre en la posicion original

	
InitPatScr:
        call    DisableSCR           ;[0B5E9h]

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

	;; AQUI HAY ALGO DE SITIO LIBRE
	

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


	
        ld      a,1    
        ld      (RefreshON),a       ;[84D5h]
	ei
.315:	halt
	ld	a,(RefreshScrD)
	or	a
	jr	nz,.315
	ret

		
RefreshScrI:
	ld	de,1800h
	call	SetPtrVram	
        ld      hl,(PatternMapPtr)      ;[84D3h]
	ld	b,0
	call	WriteLinesSc4
	call	WriteLinesSc4
	ld	b,64
	call	WriteLinesSc4
	ret

	
RefreshSpr:		
	ld	de,1e00h
	call	SetPtrVram
        ld      hl,SpriteAttrib
	ld	b,50h	;Si se pone 48 en lugar de 50 se queda colgado O_O

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
	
	call	PutSpritePage
	call	RefreshSpr
.t:	call	RestoreSpriteColor ; ,
	call	Put2Sprites
	call	RestorePage			
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
	
	
	
;;; Aqui hay casi 80h bytes libres


	forg	0b801h-LdAddress
	org	0b801h		
		
	ret	; Este ret es para evitar la escritura
		;;; de los datos de los personajes
	;; 


	

	forg	085edh-LdAddress
	org	085edh
	
ChangePatPJS:
        ld      ix,DataPers1    ;[8420h]
	ld	de,3800h
        call    ChangePatPJ_1   ;[85FEh]
        ld      ix,DataPers2    ;[8440h]
	ld	de,3820h	; 

ChangePatPJ_1:	equ $

	forg	8555h-LdAddress
	org	8555h
			
;;; ChangePatPJS:	equ 85edh
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



	forg	0b5c0h-LdAddress
	org	0b5c0h
	ld	de,1e00h


	
	forg 0b373h-LdAddress
	org 0b373h
	
	ld b,09bh

	
	forg 0b5b6h-LdAddress
	org 0b5b6h	
	ld b,09bh


	forg 094c7h-LdAddress
	org 094c7h
	ld	(hl),220	; Modificacion para ocultar sprites


	
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
	ld	b,0abh		; Rectificacion del color de marcador
	
	

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
	

	res	6,a
	ld	b,a
	ld	a,1
        jp      WriteVDP_Reg           ;[0B4A9h]
	
	

		
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

RELMEM:	equ 0f41fh
	
	forg 	08000h-LdAddress
	org	08000h 

	call	7eh
	di
	ld	a,1
	out	(99h),a
	ld	a,14+128
	out	(99h),a
	
	ld	de,1c00h
        call    WritePTR_VRAMI           ;[0B43Fh]
	ld	a,9
	ld	e,2
.2:	ld	bc,098h
.1:	out	(c),a
	djnz	.1
	dec	e
	jr	nz,.2
	
	
	xor	a
	call	SetPage
	ei
	
	ld	hl,RelocableCode
	ld	de,RELMEM
	ld	bc,RelocableCodeEnd-ChangeWallColor
	ldir
	jp	8300h

sc4:		
	ld	a,(Rg0Sav)
	and	11110001b
	or	00000100b
	ld	(Rg0Sav),a
	ld	c,99h
	out	(c),a
	ld	a,128
	out	(c),a	;Screen 4 is set

	ld	a,(Rg1Sav)
	and	11100111b
	ld	(Rg1Sav),a
	out	(c),a
	ld	a,128+1
	out	(c),a	
	ret
	



;;; Inicio codigo conflictivo
	
RelocableCode:		
	org	RELMEM
ChangeWallColor: ; ESTOS VALORES SE PUEDEN PONER DIRECTAMENTE Y DEJAR ESPACIO
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



ENASLT_0:			; Is necessary move this function to page 2
	di			; And this function is not working properly
	push	af		; because it's necessary put first
        and     3		; the slot in ffff
        ld      b,a                     
        in      a,(0A8h)                ; Read A8h slot port
        and     011111100b              ; Ignore 0-1 bits
        or      b
        out     (0A8h),a                ; and set BIOS Slot

	pop	af			; Check if EXPANDED Slot
        ld      b,a
        and     080h
        ret	z	            ; No. Go to Next Rungame Routine

        ld      a,b            ; Yes. Read 0FFFFh Expanded Slot Port.
        and     000001100b
        rrca
        rrca
        ld      b,a
        ld      a,(0FFFFh)
	cpl
        and     011111100b         ; Ignore 0-1 actual bits (page 0)
        or      b
        ld      (0FFFFh),a          ; and set BIOS Slot
	ret
	

InitScr:	equ 0b590h
CleanVRAM:	equ 0b5d9h
HideSprites:	equ 094c4h	
	
InitScrP:			; Reubicada entera, hay espacio en la posicion
	ld	a,3		; original
	di
	out	(99h),a
	ld	a,4+128
	out	(99h),a
	call	DisableSCR
	
	ld	de,1800h
        call    WritePTR_VRAMI           ;[0B43Fh]

        sub     a                                               
.557:   out     (98h),a         
	inc	a
	jr	nz,.557		;[0B59Ah]

.558:   out     (98h),a         
	inc	a
	jr	nz,.558		;[0B59Fh]

.559:   out     (98h),a         
	inc	a
        cp      60h             
	jr	nz,.559		;[0B5A4h]

	ld	de,0
	ld	b,0
        call    CleanVRAM         ;[0B5D9h]      ;Limpio la tabla de definicion
                                                ;de patrones
        ld      de,2000h                        ;La tabla de definicion de 
        ld      b,09bh          ;               ;los colores
        call    CleanVRAM        ;[0B5D9h]

	ld	b,80h		;'P'
        call    HideSprites           ;[94C4h]        
                                                
	ld	de,1e00h
        call    WritePTR_VRAMI  ;[0B43Fh]

	di
	ld	a,1
	out	(099h),a
	ld	a,128+14
	out	(99h),a
	ei
	
        ld      hl,SpriteAttrib ;Escribo las caracteristica de 20 sprites
        ld      b,80h           
.560:	outi
	jp	nz,.560		;[0B5CBh]
	call	RestorePage
	
        ld      a,(0F3E0h)      ;Esto no es correcto!!!!!
	ld	b,a
	ld	a,1
        jp      WriteVDP_Reg    ;[0B4A9h]



romslt:		equ 0f37fh
rampage0:	equ 0f37eh
rampage1:	equ 0f37dh		
rampage2:	equ 0f37ch
rampage3:	equ 0f37bh	
EXPTBL:		equ 0fcc1h
ENASLT:		equ 24h
		
PutBios:			
	di
        ld      a,(EXPTBL)
	call	ENASLT_0
	ld	a,(romslt)
	ld	hl,1<<14
	call	ENASLT
	ret
	
	

	


ReadPTR_VRAM:	equ 0B454h		

;;; ESTA FUNCION NO ES NECESARIA!!!!!!
;;; LO QUE HAY QUE HACER ES CREAR UNA TABLA DE COLORES QUE EMULE
;;; A LA PALETA DE SC2!!!!!!!!!!!!!!!!
;;; NO. EL PROBLEMA ESTA EN QUE NO SE ACTUALIZA EL CAMPO DE COLOR
;;; EN SPRITE ATTRIBUTE. NO SE POR QUE.
;;; COMPROBADO EN EL ORIGINAL QUE ESE ES EL COMPORTAMIENTO NORMAL
;;; ESCRIBE EN ALGUN MOMENTO EN MEDIO DEL CODIGO SIN TENER EN CUENTA
;;; LA TABLA SPRITEATTRIBUTE
	
;;; ESTA FUNCION ESTA MAL PORQUE NO SELECCIONA LA PAGINA ANTES
;;; DE ESCRIBIR:	 LA TABLA DE SPRITES ESTA EN PAGINA 1
;;; ------------------------------------------------------------
;;; YA HE CONSEGUIDO QUE SE COPIE EL COLOR DESDE LA TABLA
;;; DE ATRIBUTOS A LA TABLA DE COLORES. AHORA EL PROBLEMA RESIDE
;;; EN QUE LA TABLA DE ATRIBUTOS NO TIENE BIEN PUESTO EL COLOR
	
;;; Probando a partir de ruptura en 9298(comprobar olision de disparo)
;;; PARECE QUE EL PROBLEMA VIENE DE QUE EN EL ORIGINAL LA ESCRITURA
;;; DE LOS SPRITES SE HACIA FUERA DE LA INTERRUPCION. EL PROBLEMA RESIDE EN
;;; QUE DESPUES DEL PUNTO DONDE EL ESCRIBIA, TOCA DE NUEVO LA TABLA.
;;; EL JUEGO MODIFICA LA TABLA DE ATRIBUTOS DESPUES DE LA FUNCION 
;;;   9093,9327,905b
;;; EL JUEGO ESCRIBE EN LA TABLA DE ATRIBUTOS RAM ENTRE LAS FUNCIONES:
;;; 1. ProcessPJ y DecLifePJ
;;; 2. Entre las posiciones 9327 y 905b => Sucede en las dos versiones
;;; En affe sigue el valor escrito en RAM
;;; SOLUCIONADO!!!!!
;;; AHORA TAN SOLO FALTAN LOS SPRITES DE LOS PERSONAJES JUGADORES.
	

	
DATAPERS1:	equ 8420h
DATAPERS2:	equ 8440h
warspr:		equ 6000h
valspr:		equ 6300h
wizspr:		equ 6600h
elfspr:		equ 6900h					
PutSlotRam:	equ 95CDh	

	
PutSpritePage:				
	di
	ld	a,1 
	out	(99h),a
	ld	a,14+128
	out	(99h),a
	ret

PutPatternPage:
	di
	xor	a
	out	(99h),a
	ld	a,128+14
	out	(99h),a
	ret
			
				
RestoreSpriteColor:
	ld	b,21
	ld	hl,SpriteAttrib+8*4
	ld	de,01c00h+8*16
	call	SetPtrVram	


.2:	ld	de,SpriteColorLT
	inc	hl
	inc	hl
	inc	hl
	ld	a,(hl)
	and	0Fh

	push	hl
	ld	h,0
	ld	l,a
	add	hl,de
	ld	a,(hl)		
	or	20h
	
	out (98h),a
	out (98h),a
	out (98h),a
	out (98h),a
	out (98h),a
	out (98h),a
	out (98h),a
	out (98h),a
	out (98h),a
	out (98h),a
	out (98h),a
	out (98h),a
	out (98h),a
	out (98h),a
	out (98h),a
	out (98h),a	
	

	pop	hl
	inc	hl
	djnz	.2
	ret


	
Put2Sprites:
	call	PutBios

;;; Move character 1 to 20 position
;;; Wrote pattern 2nd sprite player 1 at 6 pattern position
;;; Write player 1 2nd sprite at 21
;;; Wrote pattern 2nd sprite player 1 at 5 pattern position	
;;; Write player 2 2nd sprite at 19

	
	ld	de,DATAPERS1	; Character data
	ld	bc,3800h+32*6	; Cogo el patron 30
	call	SndSprPat	; Put Pattern of 2nd spr
	
	ld	hl,SpriteAttrib+19*4	
	ld	de,1c00h+20*16	; spritecolor	
	ld	bc,1e00h+20*4	; spriteatt => y el sprite 19 (2º personaje)
	ld	a,6*4		; Number of pattern
	call	SndSprAtt
	call	PutSlotRam	
	ret
	
	call	PutSlotRam
	ret


	
;;; de -> Pointer to data
;;; bc -> Pointer to vram pattern

;;; HAY UN ERROR EN EL PARCHEO
	
SndSprPat:
	push	ix
	ld	ixl,e
	ld	ixh,d
	push	bc	
	ld	hl,13h
	add	hl,de
	ld	a,(hl)
	or	a
	jr	nz,.nowar
	ld	hl,warspr
	jr	.endc

.nowar:	
	cp	8
	jr	nz,.noval
	ld	hl,valspr
	jr	.endc
	
.noval:	cp	10h
	jr	nz,.nowiz
	ld	hl,wizspr
	jr	.endc

.nowiz:	ld	hl,elfspr


.endc:				; hl=ram pattern table
	
	ld	d,0
	bit	6,(ix+0Eh)
	jr	z,.15		;[8630h]

	inc	d
	bit	7,(ix+0Eh)
	jr	z,.15		;[8630h]
	inc	d

.15:	ld	a,(ix+0Dh)
        bit     0,(ix+0Eh)      
	jr	z,.16		;[863Bh]
	ld	a,4		; Ni puta idea de por que ...

.16:	rrca
	rrca
	rrca
        and     0E0h            
	ld	e,a
	add	hl,de		; hl=animation absolute address in ram
	
	call	PutPatternPage
	pop	de
	call	SetPtrVram

	ld	bc,2098h
	otir
	
	call	PutSpritePage
	pop	ix
	ret
	
color:		db 0
	
	
;;; de -> colour address
;;; bc -> attribute address
		
SndSprAtt:
	push	af
	push	hl			
	push	bc	
	call	SetPtrVram	; Put colour address

	ld	a,1
	or	60h
	ld	bc,1098h
.spplc:	out	(c),a		; Colour of character
	djnz	.spplc

.t:	pop	de	; Recovery attribute adress
	call	SetPtrVram
	pop	hl
	ld	bc,298h
	otir
	pop	af
	out	(98h),a				
	ret





	
		
SpriteColorLT:	db 2		
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
	
		
		
	
	
RelocableCodeEnd: db 0	
	
;;; Fin de codigo conflictivo

	forg	InitScr-LdAddress
	org	InitScr
	jp	InitScrP
		
		
	
	
		
	forg 0b45bh-LdAddress
	org 0b45bh

;Nombre: VectorInt
;Objetivo: Sirve como vector de interrupcion al programa

VectorInt:
	jp	VecIntP
RefreshScrD:	db 0
	
