/;
 TNI Logo module v1.0 by GuyveR800
 (c) The New Image 2006
 RLE decompression routine and vertical charscroll help by BiFi
\;



section code	

InitialWait:	equ	27

%macro ralign %n
  %if $ & (#1-1)
    %res8 #1 - ($ & (#1-1))
  %endif
%endmacro

%macro VDP %n
        out     [99h],a
        ld      a,#1+128
        out     [99h],a
%endmacro

%macro SetVRAM %n,w
        ld      a,#1 >> 14
        out     [99h],a
        ld      a,14+128
        out     [99h],a
        ld      a,#1 & FFh
        out     [99h],a
        ld      a,(#1 >> 8) & 3Fh + 64
        out     [99h],a
%endmacro

%macro SetVRAM %n,r
        ld      a,#1 >> 14
        out     [99h],a
        ld      a,14+128
        out     [99h],a
        ld      a,#1 & FFh
        out     [99h],a
        ld      a,(#1 >> 8) & 3Fh
        out     [99h],a
%endmacro



StartLogo:		
	ld      a,[FCC1h]
        ld      hl,002Dh
        call    000Ch
        cp      3
        jr      c,.Z80
	ld	a,[FCB1h]	; disable pause key
	res	1,a
	out	[A7h],a
.Z80:

	
	ld	hl,FrameCtr_sh
	ld	de,FrameCtr
	ld	bc,FadeInPtr-FrameCtr+2	
	ldir

	ld	hl,BG_sh
	ld	de,BG
	ld	bc,f1-BG_sh
	ldir

	ld	hl,LogoPal_sh
	ld	de,LogoPal
	ld	bc,32
	ldir

	call	InstallInt
	
        ld      hl,NewFD9A		; setup interrupt hooks
        ld      de,FD9Ah
        ld      bc,3
        ldir
        ld      hl,NewFD9F
        ld      de,FD9Fh
        ld      bc,3
        ldir

        xor	a			; Backdrop
        VDP     7
        xor	a
        VDP     16			; Write Palette
        ld      bc,209Ah
        ld      hl,LogoPal
        otir

        ld      a,00000100b     ; screen 4, 16x16 sprites, line int disabled
        VDP     0
        ld      a,00100010b	; disable screen, vblank int enabled
        VDP     1
        ld      a,00001000b     ; sprites enabled
        VDP     8
	ld	a,[FFE8h]	; 212 lines
	or	128
	VDP	9

	ld	a,00011111b	; sc5 page 0 / name table 7C00h
	VDP	2
	
	ld	a,00001000b	; single pattern table at 4000h
	VDP	4
	ld	a,00001000b	; sprite pattern table at 4000h
	VDP	6

        ld      a,10011111b     ; single color table at 6000h
        VDP     3
        ld      a,00000001b
        VDP     10

        ld      a,01100111b     ; sprite color/attribute table at 3000h
        VDP     5
        ld      a,00000000b
        VDP     11

	ld	a,128
	ld	[LogoScroll],a
	ld	[R#23Val],a
	VDP	23

        SetVRAM	0,w
        ld      hl,TNILogo
        call	UnRLEV

	SetVRAM	6000h,w		; setup bg color table
	ld	a,16
	ld	b,0
.bgc1:	out	[98h],a
	djnz	.bgc1
	ld	b,224
.bgc2:	out	[98h],a
	djnz	.bgc2
	
	SetVRAM	3000h,w		; setup sprite color/attribute table
	ld	a,1
	ld	b,0
.ctab1:	out	[98h],a	
	djnz	.ctab1
.ctab2:	out	[98h],a	
	djnz	.ctab2
	ld	hl,Sprites
	ld	bc,8198h
	otir

	SetVRAM	3400h,w		; setup sprite color/attribute table
	ld	a,15
	ld	b,0
.ctab3:	out	[98h],a	
	djnz	.ctab3
.ctab4:	out	[98h],a	
	djnz	.ctab4
	ld	hl,Sprites2
	ld	bc,7198h
	otir
	
	SetVRAM	7C00h,w		; setup name table
	ld	b,14
	xor	a
.loop:	push	af
	push	bc
	call	DrawBGLine
	pop	bc
	pop	af
	inc	a
	cp	5
	jr	c,.nowrap
	sub	5
.nowrap:
	djnz	.loop

	SetVRAM	7E00h,w
	ld	b,16
	ld	a,4
.loop2:	push	af
	push	bc
	call	DrawBGLine
	pop	bc
	pop	af
	inc	a
	cp	5
	jr	c,.nowrap2
	sub	5
.nowrap2:
	djnz	.loop2

	SetVRAM	4000h,w		; upload patterns
	ld	hl,BG
	ld	bc,0098h
	otir
	otir

	ld	hl,7DC0h	; BG update settings
	ld	[BGAddress],hl
	ld	a,3
	ld	[BGNewLine],a

	in	a,[99h]		; clear pending interrupts
        ei

Main:	ld      hl,FrameCtr
        ld      a,[hl]
.wait:  halt
        cp      [hl]
        jp      z,.wait

	ld	a,[FrameCtr]
	cp	InitialWait+96
	jr	nc,.scroll
	cp	InitialWait
	jp	nc,.noscroll

.scroll:
	ld	hl,BG+1		; vertical scroll
	ld	de,BG
	ld	b,5
.loop:	push	bc
	push	de
	push	hl
	ld	a,[de]

	ld	bc,15
	ldir
	ld	bc,10*8
	add	hl,bc
	ldi
	inc	bc
	ex	de,hl
	add	hl,bc
	ex	de,hl

	ld	bc,15
	ldir
	ld	bc,10*8
	add	hl,bc
	ldi
	inc	bc
	ex	de,hl
	add	hl,bc
	ex	de,hl

	ld	bc,7
	ldir
	ld	[de],a

	pop	hl
	pop	de
	ld	bc,16
	add	hl,bc
	ex	de,hl
	add	hl,bc
	ex	de,hl
	pop	bc
	djnz	.loop

.noscroll:
	ld	ix,BG			; horizontal scroll
	ld	de,10*8
	ld	b,16
.loop1:	ld	a,[ix+0]
	add	a,a
	rl	[ix+64]
	rl	[ix+48]
	rl	[ix+32]
	rl	[ix+16]
	rl	[ix+0]
	inc	ix
	djnz	.loop1
	add	ix,de
	ld	b,16
.loop2:	ld	a,[ix+0]
	add	a,a
	rl	[ix+64]
	rl	[ix+48]
	rl	[ix+32]
	rl	[ix+16]
	rl	[ix+0]
	inc	ix
	djnz	.loop2
	add	ix,de
	ld	b,8
.loop3:	ld	a,[ix+0]
	add	a,a
	rl	[ix+64]
	rl	[ix+48]
	rl	[ix+32]
	rl	[ix+16]
	rl	[ix+0]
	inc	ix
	djnz	.loop3

	ld	a,[FrameCtr]
	cp	20+1
	jr	nc,.nofadein
	and	3
	call	z,FadeIn
.nofadein:
	ld	a,[FrameCtr]
	cp	249-7
	jr	c,.nofade
	and	1
	call	z,FadeOut
.nofade:

	ld	a,[FrameCtr]
	inc	a
	jp	nz,Main

	di
        xor	a		; disable lineints
        VDP     0
	call	DeinstallInt

        ei
        ret

DrawBGNewLine:
	ld	hl,[BGAddress]
	ld	a,h
	rlca
	rlca
	and	3
        out     [99h],a
        ld      a,14+128
        out     [99h],a
        ld      a,l
        out     [99h],a
        ld      a,h
        and	3Fh
        or	40h
        out     [99h],a
	ld	bc,32
        add	hl,bc
        ld	[BGAddress],hl

	ld	a,[BGNewLIne]
	inc	a
	cp	5
	jr	c,.nowrap
	sub	5
.nowrap:
	ld	[BGNewLine],a
DrawBGLine:
	ld	l,a
	add	a,a
	add	a,a
	add	a,l
	add	a,Map & 255
	ld	l,a
	adc	a,Map >> 8
	sub	l
	ld	h,a

	ld	de,-5
	ld	c,98h
	ld	a,6
.loop:	ld	b,5	; 5 columns
	otir
	add	hl,de
	dec	a
	jr	nz,.loop
	outi
	outi
	ret

FadeIn:	ld	hl,[FadeInPtr]
	ld	de,LogoPal
	ldi
	inc	hl
	inc	de
	ldi
	dec	hl
	dec	hl
	ld	[FadeInPtr],hl
	ret

FadeOut:
	ld	hl,LogoPal
	ld	b,16
.loop:	ld	a,[hl]
	and	11110000b
	jr	z,.skipR
	sub	16
.skipR:	ld	c,a
	ld	a,[hl]
	and	00001111b
	jr	z,.skipB
	dec	a
.skipB:	or	c
	ld	[hl],a
	inc	hl
	ld	a,[hl]
	or	a
	jr	z,.skipG
	dec	a
	ld	[hl],a
.skipG:	inc	hl
	djnz	.loop
	ret

;**********************
;* Interrupt routines *
;**********************

InstallInt:
        di
        ld      a,[0038h]
        ld      hl,[0038h+1]
        ld      [OldRST38],a
        ld      [OldRST38+1],hl
        ld      a,C3h           ; jp
        ld      hl,RST38
        ld      [0038h],a
        ld      [0038h+1],hl

        ld      hl,FD9Ah                ; save FD9A & FD9F
        ld      de,OldFD9A
        ld      bc,10
        ldir
        ret

DeinstallInt:
        di
        ld      a,[OldRST38]
        ld      hl,[OldRST38+1]
        ld      [0038h],a
        ld      [0038h+1],hl

        ld      hl,OldFD9A              ; restore FD9A & FD9F
        ld      de,FD9Ah
        ld      bc,10
        ldir
        ret

RST38:  push    af
        call    FD9Ah
        in      a,[99h]
        rlca
        call    c,FD9Fh
        pop     af
        ei      
        ret

VblankInterrupt:
	push	af
	push	bc
	push	de
	push	hl

        ld      a,00010100b     ; screen 4 & enable line ints
        VDP     0
        ld      a,01100010b	; enable screen
        VDP     1

	ld	a,[FrameCtr]
	cp	InitialWait	; start hw scrolling after X interrupts
	jr	c,.noscroll

	ld	hl,LogoScroll
	ld	a,[R#23Val]
	cp	224
	jr	z,.noscroll
	inc	a
	ld	[R#23Val],a
	VDP	23
	dec	[hl]
.noscroll:

	SetVRAM	4000h,w		; draw pattern table
	ld	hl,BG
	ld	bc,0098h
	otir
	ld	b,16
	otir

        xor	a
        VDP     16			; Write Palette
        ld      bc,209Ah
        ld      hl,LogoPal
        otir

	SetVRAM	4000h+64*8,w	; copy-align sprite patterns
	ld	hl,BG+6*8
	ld	bc,2098h
	otir
	ld	hl,BG+18*8
	ld	b,20h
	otir
	ld	hl,BG+30*8
	ld	b,20h	
	otir

        ld      a,01100111b     ; sprite color/attribute table at 3000h
        VDP     5

	ld	hl,LogoScroll
	ld	a,[R#23Val]
	add	a,[hl]
	sub	2
	VDP	19

	ld	hl,LineInterruptV
	ld	[FD9Ah+1],hl

	ld	a,[FrameCtr]
	cp	InitialWait		; draw new lines when hardware scrolling
	jr	c,.nonewdraw
	cp	InitialWait+96
	jr	nc,.nonewdraw

	ld	a,[FrameCtr]		; only draw every 8 frames
	and	7
	call	z,DrawBGNewLine
.nonewdraw:

	ld	hl,FrameCtr
	inc	[hl]

	pop	hl
	pop	de
	pop	bc
	pop	af
	ret

LineInterruptV:
        ld      a,1
        out     [99h],a
        ld      a,15+128
        out     [99h],a
        in      a,[99h]
        rrca
        jp      nc,.endint      ; no VDP interrupt

	ld	a,[R#23Val]
	cp	130
	jr	c,.endint
        ld      a,00010110b     ; screen 5 & enable line ints
        VDP     0

	ld	a,[R#23Val]
	add	a,128-2
	VDP	19

	ld	a,LineInterrupt128 & 255
	ld	[FD9Ah+1],a
	ld	a,LineInterrupt128 >> 8
	ld	[FD9Ah+2],a

.endint:
        xor	a
        out     [99h],a
        ld      a,15+128
        out     [99h],a
	ret
	
LineInterrupt128:
        ld      a,1
        out     [99h],a
        ld      a,15+128
        out     [99h],a
        in      a,[99h]
        rrca
        jp      nc,.endint      ; no VDP interrupt

        ld      a,00010100b     ; screen 4
        VDP     0

	ld	a,[FrameCtr]
	cp	InitialWait+96
	jr	c,.endint

	ld      a,01101111b     ; sprite color/attribute table at 3400h
	VDP     5

.endint:
        xor	a
        out     [99h],a
        ld      a,15+128
        out     [99h],a
	ret

NewFD9F:	jp	VblankInterrupt
NewFD9A:        jp      LineInterruptV

; decompress to vram pattern
;
; $00     = unused
; $80     = end of stream
; $01-$7F = literal string length	(string follows)
; $81-$FF = RLE repeat count		(byte follows)
;
; In : HL = Source stream

UnRLEV:		ld	c,98h
.loop:		ld	a,[hl]
		cp	80h
		ret	z
		inc	hl
		jr	nc,.rle
		ld	b,a
		otir
		jr	.loop

.rle:		and	127
		ld	b,a
		ld	a,[hl]
		inc	hl
.rle.loop:	out	[c],a
		djnz	.rle.loop
		jr	.loop

%macro RGB %n,%n,%n
%def16 #2*256+#1*16+#3
%endmacro

FadeInPal:	%def8	0,0,1,2,3,4,5
LogoPal_sh:
        RGB 0,0,0
        RGB 0,0,0
        RGB 3,0,0
        RGB 0,0,0
        RGB 4,0,0
        RGB 2,2,2
        RGB 5,1,0
        RGB 3,3,3
        RGB 6,2,0
        RGB 4,4,4
        RGB 7,3,1
        RGB 5,5,5
        RGB 7,5,2
        RGB 6,6,6
        RGB 7,6,4
        RGB 7,7,7

BG_sh:
; row 1
%def8	11110000b,11110000b,11110000b,11110000b,11111111b,11111111b,11111111b,11111111b	; t
%def8	11110000b,11110000b,11110000b,11110000b,11111111b,11111111b,11111111b,01111111b
%def8	00001111b,00001111b,00001111b,00001111b,10001111b,11001111b,00001111b,10001111b	; n (left)
%def8	00001111b,00001111b,00001111b,00001111b,11111111b,11111111b,11111111b,11111111b
%def8	11111110b,11111111b,11111111b,11111111b,00001111b,00001111b,00001111b,00001111b	; n (right)
%def8	00001111b,00001111b,00001111b,00001111b,00001111b,00001111b,00001111b,00001111b
%def8	00000110b,00001111b,00001111b,00000110b,00000000b,00001111b,00001111b,00001111b	; i
%def8	00001111b,00001111b,00001111b,00001111b,11111111b,11111111b,11111111b,11111111b
%def8	0,0,0,0,0,0,0,0	; space
%def8	0,0,0,0,0,0,0,0

%def8	0,0,0,0,0,0,0,0	; padding
%def8	0,0,0,0,0,0,0,0

; row 2
%def8	0,0,0,0,11111110b,11111111b,11111111b,11111111b	; n (right high)
%def8	00001111b,00001111b,00001111b,00001111b,00001111b,00001111b,00001111b,00001111b
%def8	0,0,0,0,00000110b,00001111b,00001111b,00000110b	; i (high)
%def8	00000000b,00001111b,00001111b,00001111b,00001111b,00001111b,00001111b,00001111b
%def8	0,0,0,0,0,0,0,0	; space
%def8	0,0,0,0,0,0,0,0
%def8	0,0,0,0,11110000b,11110000b,11110000b,11110000b	; t (high)
%def8	11111111b,11111111b,11111111b,11111111b,11110000b,11110000b,11110000b,11110000b
%def8	0,0,0,0,00001111b,00001111b,00001111b,00001111b	; n (left high)
%def8	10001111b,11001111b,00001111b,10001111b,00001111b,00001111b,00001111b,00001111b

%def8	0,0,0,0,0,0,0,0	; padding
%def8	0,0,0,0,0,0,0,0

; row 3
%def8	00001111b,00001111b,00001111b,00001111b,0,0,0,0	; n (right low)
%def8	0,0,0,0,0,0,0,0
%def8	11111111b,11111111b,11111111b,11111111b,0,0,0,0	; i (low)
%def8	0,0,0,0,0,0,0,0
%def8	0,0,0,0,0,0,0,0	; space
%def8	0,0,0,0,0,0,0,0
%def8	11111111b,11111111b,11111111b,01111111b,0,0,0,0	; t (low)
%def8	0,0,0,0,0,0,0,0
%def8	11111111b,11111111b,11111111b,11111111b,0,0,0,0 ; n (left low)
%def8	0,0,0,0,0,0,0,0

%def8	0,0,0,0,0,0,0,0	; padding
%def8	0,0,0,0,0,0,0,0

; The New Image

		
%def8	11111000b
%def8	00100000b
%def8	00100000b
%def8	00100000b
%def8	00100000b
%def8	00100000b
%def8	00100000b
%def8	00000000b

%def8	00000000b
%def8	00000000b
%def8	00000000b
%def8	00000000b
%def8	00000000b
%def8	00000000b
%def8	00000000b
%def8	00000000b

%def8	10000000b
%def8	10000000b
%def8	11110000b
%def8	10001000b
%def8	10001000b
%def8	10001000b
%def8	10001000b
%def8	00000000b

%def8	00000000b
%def8	00000000b
%def8	00000000b
%def8	00000000b
%def8	00000000b
%def8	00000000b
%def8	00000000b
%def8	00000000b

%def8	00000000b
%def8	00000000b
%def8	01110000b
%def8	10001000b
%def8	11111000b
%def8	10000000b
%def8	01110000b
%def8	00000000b

%def8	00000000b
%def8	11110000b
%def8	10001000b
%def8	10001000b
%def8	11110000b
%def8	10000000b
%def8	10000000b
%def8	10000000b

%def8	00000000b
%def8	00000000b
%def8	00000000b
%def8	00000000b
%def8	00000000b
%def8	00000000b
%def8	00000000b
%def8	00000000b

%def8	00000000b
%def8	00000000b
%def8	00000000b
%def8	10110000b
%def8	11001000b
%def8	10000000b
%def8	10000000b
%def8	10000000b

%def8	10001000b
%def8	11001000b
%def8	11001000b
%def8	10101000b
%def8	10011000b
%def8	10011000b
%def8	10001000b
%def8	00000000b

%def8	00000000b
%def8	00000000b
%def8	00000000b
%def8	01110000b
%def8	10001000b
%def8	11111000b
%def8	10000000b
%def8	01110000b

%def8	00000000b
%def8	00000000b
%def8	01110000b
%def8	10001000b
%def8	11111000b
%def8	10000000b
%def8	01110000b
%def8	00000000b

%def8	00000000b
%def8	00000000b
%def8	00000000b
%def8	01111000b
%def8	10000000b
%def8	11110000b
%def8	00001000b
%def8	11110000b

%def8	00000000b
%def8	00000000b
%def8	10001000b
%def8	10101000b
%def8	10101000b
%def8	10101000b
%def8	01010000b
%def8	00000000b

%def8	00000000b
%def8	00000000b
%def8	00000000b
%def8	01110000b
%def8	10001000b
%def8	11111000b
%def8	10000000b
%def8	01110000b

%def8	00000000b
%def8	00000000b
%def8	00000000b
%def8	00000000b
%def8	00000000b
%def8	00000000b
%def8	00000000b
%def8	00000000b

%def8	00000000b
%def8	00000000b
%def8	00000000b
%def8	10110000b
%def8	11001000b
%def8	10001000b
%def8	10001000b
%def8	10001000b

%def8	01110000b
%def8	00100000b
%def8	00100000b
%def8	00100000b
%def8	00100000b
%def8	00100000b
%def8	01110000b
%def8	00000000b

%def8	00000000b
%def8	01000000b
%def8	01000000b
%def8	11110000b
%def8	01000000b
%def8	01000000b
%def8	01001000b
%def8	00110000b

%def8	00000000b
%def8	00000000b
%def8	11010000b
%def8	10101000b
%def8	10101000b
%def8	10101000b
%def8	10101000b
%def8	00000000b

%def8	00000000b
%def8	00000000b
%def8	00000000b
%def8	01111000b
%def8	10000000b
%def8	11110000b
%def8	00001000b
%def8	11110000b

%def8	00000000b
%def8	00000000b
%def8	01110000b
%def8	00001000b
%def8	01111000b
%def8	10001000b
%def8	01111000b
%def8	00000000b

%def8	00000000b
%def8	00000000b
%def8	00000000b
%def8	00100000b
%def8	00000000b
%def8	00000000b
%def8	00100000b
%def8	00000000b

%def8	00000000b
%def8	00000000b
%def8	01101000b
%def8	10011000b
%def8	10011000b
%def8	01101000b
%def8	00001000b
%def8	01110000b

%def8	00000000b
%def8	00000000b
%def8	00000000b
%def8	00000000b
%def8	00000000b
%def8	00000000b
%def8	00000000b
%def8	00000000b

%def8	00000000b
%def8	00000000b
%def8	01110000b
%def8	10001000b
%def8	11111000b
%def8	10000000b
%def8	01110000b
%def8	00000000b

%def8	00000000b
%def8	00000000b
%def8	00000000b
%def8	00000000b
%def8	00000000b
%def8	00000000b
%def8	00000000b
%def8	00000000b

%def8	00000000b
%def8	00000000b
%def8	00000000b
%def8	00000000b
%def8	00000000b
%def8	00000000b
%def8	00000000b
%def8	00000000b

%def8	00000000b
%def8	00000000b
%def8	00000000b
%def8	00000000b
%def8	00000000b
%def8	00000000b
%def8	00000000b
%def8	00000000b

f1:		

Map:
%def8	 0, 2, 4, 6, 8
%def8	 1, 3, 5, 7, 9
%def8	12,14,16,18,20
%def8	13,15,17,19,21
%def8	24,26,28,30,32

Sprites:
%def8	255,  0, 0,0
%def8	255, 16, 4,0
%def8	255,224,64,0
%def8	255,240, 0,0

%def8	 15,  0,12,0
%def8	 15, 16,16,0
%def8	 15,224,68,0
%def8	 15,240,12,0

%def8	 31,  0,24,0
%def8	 31, 16,28,0
%def8	 31,224,72,0
%def8	 31,240,24,0

%def8	 39,  0, 0,0
%def8	 39, 16, 4,0
%def8	 39,224,64,0
%def8	 39,240, 0,0

%def8	 55,  0,12,0
%def8	 55, 16,16,0
%def8	 55,224,68,0
%def8	 55,240,12,0

%def8	 71,  0,24,0
%def8	 71, 16,28,0
%def8	 71,224,72,0
%def8	 71,240,24,0

%def8	 79,  0, 0,0
%def8	 79, 16, 4,0
%def8	 79,224,64,0
%def8	 79,240, 0,0

%def8	216

Sprites2:
%def8	103, 77, 36,0
%def8	103, 93, 40,0
%def8	103,109, 44,0
%def8	103,125, 48,0
%def8	103,141, 52,0
%def8	103,157, 56,0
%def8	103,173, 60,0

%def8	216

TNILogo:        %incbin "tnilogo.rle"

FrameCtr_sh:	db	0
FadeInPtr_sh:	dw	FadeInPal



section rdata

FrameCtr:	rb	1
FadeInPtr:	rw	1		
OldRST38:	rb	3
OldFD9A:	rb	5
OldFD9F:	rb	5
R#23Val:	rb	1
LogoScroll:	rb	1
BGAddress:	rw	1
BGNewLine:	rb	1

LogoPal:	rb	32
BG:		rb	f1-BG_sh

	
section code