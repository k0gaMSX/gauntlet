;+-------------------------------+
;|         gauntlet.3            |
;|  Dizassembled by ZD ver 3.47  |
;+-------------------------------+
	.Z80
bios	macro	adr
	db	0F7h,80h
	dw	adr
	endm
;
;
	.phase	83D0h
;	Offset in file  : 7
;	End address     : 0CA20h
;	Application type: BASIC BLOAD
;
;
synchr	macro	char
	rst	8
	db	char
	endm
;
h.TIMI	equ	0FD9Fh
;
;::===============================::
;||      Program entry point      ||
;::===============================::
_MAIN:	ld	b,80h		;'Ä'
.0:	push	bc
	call	h.TIMI		;[0FD9Fh]
	pop	bc
	djnz	.0		;[83D2h]
	di
	in	a,(0A8h)	;PSLOT register
	ld	b,a
	rrca
	rrca
	rrca
	rrca
	or	b
	out	(0A8h),a	;PSLOT register
	ld	a,(0FFFFh)
	cpl
	and	0F0h		;''
	ld	c,a
	rrca
	rrca
	rrca
	rrca
	or	c
	ld	(0FFFFh),a
	xor	a
	ld	(0DFFFh),a
	ld	(0E000h),sp
	jp	.1		;[8400h]
;::===============================::
;||   No execution path to here   ||
;::===============================::
	nop
	nop
.1:	jp	.2		;[0B8E1h]
;
B8403:	db	1
;::===============================::
;||      Indexed entry point      ||
;::===============================::
T8404:	call	m,0C03Fh
	inc	bc
	nop
	dec	bc
	ld	d,12h
	ld	(bc),a
	inc	e
	ld	c,0Ch
	rlca
	rla
	dec	d
	dec	c
	ld	b,12h
	ld	a,(bc)
	inc	d
	ld	bc,809h
	ld	a,(bc)
	ld	(bc),a
	ld	b,4
	dec	b
;
T8420:	db	0
B8421:	db	0
T8422:	db	0
T8423:	db	0
T8424:	db	0,0,0
B8427:	db	0
T8428:	db	0,0
B842A:	db	0
B842B:	db	0C0h		;'¿'
B842C:	db	0
T842D:	db	0,0
B842F:	db	9
T8430:	db	0,0,0
B8433:	db	0
B8434:	db	80h		;'Ä'
B8435:	db	0
T8436:	db	0
T8437:	db	0,0,0,0,0,0,0,0,0
T8440:	db	0
B8441:	db	0
T8442:	db	0
T8443:	db	0,0,0,0
B8447:	db	0
T8448:	db	0,0
B844A:	db	0
T844B:	db	'¿'
B844C:	db	0
T844D:	db	0,0
B844F:	db	5
T8450:	db	0,0,0
B8453:	db	8
;::===============================::
;||      Indexed entry point      ||
;::===============================::
T8454:	add	a,b
;
B8455:	db	0
T8456:	db	0
T8457:	db	0,0,0,0,0,0,0,0,0,6,2,0,4,2,6,4,0,6,0,1,4,9,10h,19h,'$'
	db	'1@Qdy',0A9h,'ƒ·˛',0,0,0,0
B847D:	db	0
B847E:	db	0
ROWTABLE:  db      0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
W8489:	dw	0
T848B:	db	0
B848C:	db	0
B848D:	db	0
B848E:	db	0
T848F:	db	0,0
B8491:	db	0
W8492:	dw	0
B8493	equ	$-1
W8494:	db	0,0
B8496:	db	0
B8497:	db	0
T8498:	db	0
B8499:	db	0
W849A:	dw	0
W849C:	dw	0
B849E:	db	0
B849F:	db	0
T84A0:	db	'&'
B84A1:	db	0
B84A2:	db	0
B84A3:	db	0
T84A4:	db	0,0
W84A6:	dw	0
B84A8:	db	0
W84A9:	db	0,0
T84AB:	db	0
B84AC:	db	0
W84AD:	dw	0
T84AF:	db	0,0,0
B84B2:	db	0
B84B3:	db	10h
W84B4:	dw	0
.4	equ	$-1
B84B6:	nop
	nop
B84B8:	nop
B84B9:	nop
B84BA:	inc	b
B84BB:	nop
	nop
B84BD:	or	h
	dec	b
	add	hl,de
B84C0:	nop
B84C1:	nop
B84C2:	nop
	nop
	nop
B84C5:	nop
B84C6:	nop
;
B84C7:	db	0
B84C8:	nop
B84C9:	nop
	nop
	nop
B84CC:	nop
	nop
	nop
	nop
	nop
	nop
	nop
W84D3:	inc	hl
	ret	nc
B84D5:	ld	bc,0
W84D7	equ	$-1
	nop
B84D9:	nop
B84DA:	nop
W84DB:	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	jp	SB4E1		;[0B4E1h]
;::===============================::
;||   No execution path to here   ||
;::===============================::
	nop
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S8504:	call	S98E3		;[98E3h]
	call	SA27D		;[0A27Dh]
	call	SB4F8		;[0B4F8h]
	call	S8673		;[8673h]
	call	SA2D9		;[0A2D9h]
	call	SAA93		;[0AA93h]
	call	S9017		;[9017h]
	bit	6,(iy-1)
	call	nz,S8F1E	;[8F1Eh]
	call	SB709		;[0B709h]
	call	S9A47		;[9A47h]
	call	S9AB4		;[9AB4h]
	call	S9825		;[9825h]
	call	SAFFE		;[0AFFEh]
	call	SA8C1		;[0A8C1h]
	call	S972C		;[972Ch]
	call	S8DB8		;[8DB8h]
	call	SA32E		;[0A32Eh]
	ld	a,(B84A1)	;[84A1h]
	or	a
	jr	z,.6		;[8545h]
	dec	a
	ld	(B84A1),a	;[84A1h]
.6:	call	S8555		;[8555h]
	call	SA083		;[0A083h]
	call	S864B		;[864Bh]
	bit	7,(iy-2)
	jr	z,S8504		;[8504h]
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S8555:	call	S85ED		;[85EDh]
	call	S8589		;[8589h]
	call	S8589		;[8589h]
	call	S8589		;[8589h]
	ld	a,(B8491)	;[8491h]
	rra
	ret	c
	ld	b,30h		;'0'
	and	3
	dec	a
	jr	z,.8		;[8575h]
	ld	b,38h		;'8'
	sub	2
	jr	z,.8		;[8575h]
	ld	b,28h		;'('
.8:	ld	a,b
	ld	(B85BD),a	;[85BDh]
	ld	de,0C8h
	ld	b,20h		;' '
	call	S85BB		;[85BBh]
	ld	de,1A0h
	ld	b,40h		;'@'
	jp	S85BB		;[85BBh]
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S8589:	ld	a,(B84D9)	;[84D9h]
	inc	a
	cp	6
	jr	nz,.9		;[85ABh]
	ld	a,(B84DA)	;[84DAh]
	add	a,8
	and	18h
	ld	(B84DA),a	;[84DAh]
	cp	10h
	jr	c,.10		;[85A5h]
	sub	10h
	jr	z,.10		;[85A5h]
	ld	a,10h
.10:	add	a,28h		;'('
	ld	(B85BD),a	;[85BDh]
	sub	a
.9:	ld	(B84D9),a	;[84D9h]
	ld	b,20h		;' '
	ld	de,2E0h
	jr	z,S85BB		;[85BBh]
	add	a,2
	ld	d,a
	ld	e,0
	ld	b,e
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S85BB:	ld	hl,2800h
B85BD	equ	$-1
	add	hl,de
	push	hl
	ld	c,98h
	push	bc
	call	SB43F		;[0B43Fh]
	pop	bc
	ld	a,b
.11:	outi
	jp	nz,.11		;[85C8h]
	ld	b,a
	push	bc
	set	3,d
	call	SB43F		;[0B43Fh]
	res	3,d
	pop	bc
	pop	hl
	push	hl
	ld	a,b
.12:	outi
	jp	nz,.12		;[85DAh]
	ld	c,a
	or	a
	jr	nz,.13		;[85E4h]
	inc	b
.13:	ld	hl,TC000	;[0C000h]
	add	hl,de
	ex	de,hl
	pop	hl
	ldir
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S85ED:	ld	ix,T8420	;[8420h]
	ld	de,3800h
	call	S85FE		;[85FEh]
	ld	ix,T8440	;[8440h]
	ld	de,3820h
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S85FE:	bit	7,(ix+0Bh)
	ret	nz
	ld	a,(ix+13h)
	srl	a
	add	a,10h
	ld	h,a
	call	SB43F		;[0B43Fh]
	ld	l,0
	ld	d,l
	bit	6,(ix+0Bh)
	jr	z,.14		;[8622h]
	ld	a,(ix+16h)
	cp	7
	jr	nc,.14		;[8622h]
	ld	d,3
	jr	.15		;[8630h]
.14:	bit	6,(ix+0Eh)
	jr	z,.15		;[8630h]
	inc	d
	bit	7,(ix+0Eh)
	jr	z,.15		;[8630h]
	inc	d
.15:	ld	a,(ix+0Dh)
	bit	0,(ix+0Eh)
	jr	z,.16		;[863Bh]
	ld	a,4
.16:	rrca
	rrca
	rrca
	and	0E0h		;'‡'
	ld	e,a
	add	hl,de
	ld	bc,2098h
.17:	outi
	jp	nz,.17		;[8645h]
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S864B:	bit	6,(iy-1)
	ret	nz
	bit	5,(iy+4)
	ret	nz
	ld	(iy+56h),0
        call    S8665           ;
.18:    call    SCANJOY           ;[0B40Bh]
        bit     5,(iy+4)        TECLA P (PAUSE)
	jr	nz,.18		;[865Ch]
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S8665:  call    SCANJOY           ;[0B40Bh]
        bit     5,(iy+4)        ;TECLA P (PAUSE)
	jr	z,S8665		;[8665h]
	ld	(iy+56h),1
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S8673:	ld	a,(T848B)	;[848Bh]
	add	a,a
	ld	hy,(iy+0Dh)
	srl	h
	srl	h
	srl	h
	rra
	srl	h
	rra
	scf
	rr	h
	rra
	ld	l,a
	ld	a,h
	sub	4
	cp	80h		;'Ä'
	jp	nz,.19		;[8692h]
	ld	h,a
.19:	ld	(W84D7),hl	;[84D7h]
	ld	de,0D023h
	ld	c,0Ah
	ld	a,(B848C)	;[848Ch]
	and	2
	jr	z,.20		;[86A5h]
	ld	de,0D045h
	inc	c
.20:	ld	a,(T848B)	;[848Bh]
	and	2
	ld	a,10h
	jr	z,.21		;[86B1h]
	inc	de
	ld	a,11h
.21:	ld	(B86BD),a	;[86BDh]
	ld	(W84D3),de	;[84D3h]
	ld	ix,0D023h
.26:	ld	b,10h
B86BD	equ	$-1
	ld	(W8709),ix	;[8709h]
	ld	a,l
	ex	af,af'
.24:	ld	a,(hl)
	or	a
	jr	z,.22		;[86E8h]
	cp	30h		;'0'
	call	z,SB059		;[0B059h]
	exx
	dec	a
	add	a,a
	ld	l,a
	ld	h,20h		;' '
	add	hl,hl
	ld	a,(hl)
	inc	l
	ld	(ix),a
	ld	a,(hl)
	inc	l
	ld	(ix+1),a
	ld	a,(hl)
	inc	l
	ld	(ix+22h),a
	ld	a,(hl)
	ld	(ix+23h),a
	exx
.22:	inc	l
	ld	a,l
	and	1Fh
	jr	nz,.23		;[86F2h]
	ld	a,l
	sub	20h		;' '
	ld	l,a
.23:	inc	ix
	inc	ix
	djnz	.24		;[86C4h]
	ex	af,af'
	add	a,20h		;' '
	ld	l,a
	jr	nc,.25		;[8707h]
	inc	h
	ld	a,h
	sub	4
	cp	80h		;'Ä'
	jr	nz,.25		;[8707h]
	ld	h,a
.25:	ld	ix,0
W8709	equ	$-2
	ld	de,44h
	add	ix,de
	dec	c
	jr	nz,.26		;[86BCh]
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S8714:	ex	af,af'
	ld	a,c
	add	a,3
	sub	(iy+0Ch)
	and	7Fh		;''
	cp	44h		;'D'
	ret	nc
	cp	3
	jr	c,.27		;[8727h]
	sub	43h		;'C'
	ret	nc
.27:	ld	a,b
	add	a,3
	sub	(iy+0Dh)
	and	7Fh		;''
	cp	44h		;'D'
	ret	nc
	cp	3
	jr	c,B8739		;[8739h]
	sub	2Bh		;'+'
	ret	nc
B8739:	nop
W873A:	nop
	nop
	call	SB4B4		;[0B4B4h]
	push	hl
	pop	ix
	ex	af,af'
	dec	a
	ld	l,a
	ld	h,10h
	add	hl,hl
	add	hl,hl
	ld	a,(hl)
	inc	l
	ld	(ix),a
	ld	a,(hl)
	inc	l
	ld	(ix+1),a
	ld	a,(hl)
	inc	l
	ld	(ix+22h),a
	ld	a,(hl)
	ld	(ix+23h),a
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S875D:	ld	a,0B8h		;'∏'
	ld	(B8B18),a	;[8B18h]
	ld	c,a
	ld	a,7
	call	S88F2		;[88F2h]
	inc	a
	ld	c,0
	call	S88F2		;[88F2h]
	inc	a
	call	S88F2		;[88F2h]
	inc	a
	call	S88F2		;[88F2h]
	ld	hl,W8B08	;[8B08h]
	ld	de,T8B09	;[8B09h]
	ld	bc,10h
	sub	a
	ld	(hl),a
	ldir
	ld	(B8B40),a	;[8B40h]
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S8787:	push	bc
	push	de
	push	hl
	push	ix
	push	af
	ld	hl,B8B40	;[8B40h]
	bit	1,(hl)
	jr	z,.29		;[8799h]
	ld	(B8B0D),a	;[8B0Dh]
	jr	.30		;[87A1h]
.29:	bit	0,(hl)
	jr	z,.30		;[87A1h]
	pop	af
	jp	.31		;[8831h]
.30:	ld	d,a
	ld	ix,T8B0A	;[8B0Ah]
	ld	b,3
	ld	l,9
	ld	h,l
.33:	ld	a,(ix+3)
	cp	d
	jr	z,.32		;[87FDh]
	inc	ix
	inc	ix
	inc	ix
	inc	ix
	sla	l
	djnz	.33		;[87ABh]
	ld	l,h
	ld	a,(B8B17)	;[8B17h]
	ld	ix,T8B0A	;[8B0Ah]
	ld	b,3
.34:	rrca
	jr	nc,.32		;[87FDh]
	inc	ix
	inc	ix
	inc	ix
	inc	ix
	sla	l
	djnz	.34		;[87C7h]
	ld	l,h
	ld	e,l
	ld	ix,T8B0A	;[8B0Ah]
	ld	b,3
	ld	d,0
.36:	ld	a,(ix+2)
	cp	d
	jr	c,.35		;[87ECh]
	ld	d,a
	ld	e,l
	ld	(W8B08),ix	;[8B08h]
.35:	sla	l
	inc	ix
	inc	ix
	inc	ix
	inc	ix
	djnz	.36		;[87E0h]
	ld	ix,(W8B08)	;[8B08h]
	ld	l,e
.32:	ld	a,l
	cpl
	ld	e,a
	ld	a,(B8B17)	;[8B17h]
	and	e
	ld	(B8B17),a	;[8B17h]
	or	l
	ld	e,a
	pop	af
	and	a
	jr	nz,.37		;[8813h]
	ld	d,a
	ld	a,r
	and	1
	add	a,d
.37:	ld	(ix+3),a
	add	a,a
	ld	l,a
	ld	h,0
	ld	bc,73DAh
	add	hl,bc
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	add	hl,bc
	ld	(ix),lx
	ld	(ix+1),hx
	ld	(ix+2),0
	ld	a,e
	ld	(B8B17),a	;[8B17h]
.31:	pop	ix
	pop	hl
	pop	de
	pop	bc
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S8837:	push	de
	push	ix
	push	iy
	call	S8963		;[8963h]
	ld	iy,T8B16	;[8B16h]
	ld	a,(iy+1)
	and	7
	ld	a,0B8h		;'∏'
	ld	(iy+2),a
	jr	z,.38		;[8883h]
	ld	ix,T8B0A	;[8B0Ah]
	ld	b,3
.41:	rrc	(iy+2)
	rrc	(iy+1)
	jr	nc,.39		;[886Ah]
	bit	2,(iy+1)
	push	bc
	jr	z,.40		;[8869h]
	call	S8891		;[8891h]
.40:	pop	bc
.39:	inc	ix
	inc	ix
	inc	ix
	inc	ix
	djnz	.41		;[8855h]
	ld	a,(iy+1)
	rlca
	rlca
	rlca
	ld	(iy+1),a
	ld	a,(iy+2)
	rlca
	rlca
	rlca
.38:	and	0B8h		;'∏'
	ld	c,a
	ld	a,7
	call	S88F2		;[88F2h]
	pop	iy
	pop	ix
	pop	de
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S8891:	ld	lx,(ix)
	ld	hx,(ix+1)
	ld	a,(hl)
	and	a
	jr	nz,.42		;[88AAh]
	res	7,(iy+1)
	ld	a,3
	sub	b
	add	a,8
	ld	c,0
	call	S88F2		;[88F2h]
	ret
.42:	inc	hl
	ld	e,a
	and	0F0h		;''
	rrca
	rrca
	rrca
	rrca
	ld	c,a
	ld	a,3
	sub	b
	add	a,8
	call	S88F2		;[88F2h]
	ld	a,e
	and	0Fh
	add	a,a
	ld	c,a
	jr	z,.43		;[88C6h]
	res	2,(iy+2)
.43:	ld	a,6
	call	S88F2		;[88F2h]
	ld	a,(hl)
	push	hl
	inc	a
	ld	h,0
	ld	l,a
	jr	z,.44		;[88D7h]
	res	7,(iy+2)
.44:	add	hl,hl
	add	hl,hl
	ld	c,l
	ld	a,3
	sub	b
	add	a,a
	call	S88F2		;[88F2h]
	ld	c,h
	inc	a
	call	S88F2		;[88F2h]
	pop	hl
	inc	hl
	ld	(ix),lx
	ld	(ix+1),hx
	inc	(ix+2)
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S88F2:	push	hl
	push	de
	ld	e,c
        ld      hl,WRTPSG        ;[0B3EFh]
        call    WRTPSG           ;[0B3EFh]
	pop	de
	pop	hl
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S88FE:	ld	a,8
	ld	(B8B41),a	;[8B41h]
	ld	(B8B42),a	;[8B42h]
	ld	a,1
	ld	bc,5AAh
	ld	de,5C8h
	ld	hl,5E4h
	jr	.45		;[891Eh]
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S8913:	ld	a,2
	ld	bc,436h
	ld	de,440h
	ld	hl,46Eh
.45:	ld	(B8B40),a	;[8B40h]
	ld	(T8B19),bc	;[8B19h]
	ld	(T8B26),de	;[8B26h]
	ld	(T8B33),hl	;[8B33h]
	ld	a,1
	ld	(B8B22),a	;[8B22h]
	ld	(B8B2F),a	;[8B2Fh]
	ld	(B8B3C),a	;[8B3Ch]
	dec	a
	ld	(B8B43),a	;[8B43h]
	ld	(B8B1B),a	;[8B1Bh]
	ld	(B8B28),a	;[8B28h]
	ld	(B8B35),a	;[8B35h]
	ld	(B8B25),a	;[8B25h]
	ld	(B8B32),a	;[8B32h]
	ld	(B8B3F),a	;[8B3Fh]
	ld	a,7
	ld	c,38h
	call	S88F2		;[88F2h]
	ld	c,0
	inc	a
	call	S88F2		;[88F2h]
	inc	a
	call	S88F2		;[88F2h]
	inc	a
	call	S88F2		;[88F2h]
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S8963:	ld	a,(B8B40)	;[8B40h]
	and	a
	ret	z
	ld	ix,B8B40	;[8B40h]
	dec	(ix+1)
	jr	z,.46		;[8976h]
	call	S8AC6		;[8AC6h]
	jr	.47		;[8991h]
.46:	ld	a,(ix+2)
	ld	(ix+1),a
	ld	ix,T8B19	;[8B19h]
	call	S89E2		;[89E2h]
T8981	equ	$-2
	ld	ix,T8B26	;[8B26h]
	call	S89E2		;[89E2h]
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S898A:	ld	ix,T8B33	;[8B33h]
	call	S89E2		;[89E2h]
.47:	ld	ix,T8B23	;[8B23h]
	sub	a
	ld	c,(ix)
	call	S88F2		;[88F2h]
	inc	a
	ld	c,(ix+1)
	call	S88F2		;[88F2h]
	ld	a,8
	ld	c,(ix+2)
	call	S88F2		;[88F2h]
	ld	ix,T8B30	;[8B30h]
	ld	a,2
	ld	c,(ix)
	call	S88F2		;[88F2h]
	inc	a
	ld	c,(ix+1)
	call	S88F2		;[88F2h]
	ld	a,9
	ld	c,(ix+2)
	call	S88F2		;[88F2h]
	ld	ix,T8B3D	;[8B3Dh]
	ld	a,4
	ld	c,(ix)
	call	S88F2		;[88F2h]
	inc	a
	ld	c,(ix+1)
	call	S88F2		;[88F2h]
	ld	a,0Ah
	ld	c,(ix+2)
	call	S88F2		;[88F2h]
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S89E2:	dec	(ix+9)
	ret	nz
	ld	a,(ix+3)
	and	a
	jr	z,.48		;[89F4h]
	dec	(ix+3)
	ld	(ix+9),0FFh	;
	ret
.48:	ld	lx,(ix)
	ld	hx,(ix+1)
.64:	ld	a,(hl)
	inc	hl
	ld	c,(hl)
	inc	hl
	and	a
	jp	m,.49		;[8AA6h]
	jr	nz,.50		;[8A12h]
	ld	(ix+9),c
	ld	(ix+0Ch),0
	ld	(ix+2),0
	jp	S8A9F		;[8A9Fh]
.50:	cp	19h
	jr	nz,.52		;[8A2Dh]
	ld	(ix+9),0
	dec	c
	ld	(ix+3),c
	ld	(ix+0Ch),0
	ld	(ix+9),0FFh	;
	ld	(ix+2),0
	jp	S8A9F		;[8A9Fh]
.52:	cp	1Eh
	jr	nz,.54		;[8A3Fh]
	sub	a
	ld	(B8B40),a	;[8B40h]
	ld	(B8B25),a	;[8B25h]
	ld	(B8B32),a	;[8B32h]
	ld	(B8B3F),a	;[8B3Fh]
	ret
.54:	cp	11h
	jr	nz,.55		;[8A4Fh]
	ld	(ix+4),lx
	ld	(ix+5),hx
	set	7,(ix+8)
	jr	.64		;[89FAh]
.55:	cp	10h
	jr	nz,.57		;[8A6Dh]
	bit	7,(ix+8)
	jr	z,.58		;[8A60h]
	res	7,(ix+8)
	ld	(ix+6),c
.58:	dec	(ix+6)
	jr	z,.64		;[89FAh]
	ld	lx,(ix+4)
	ld	hx,(ix+5)
	jr	.64		;[89FAh]
.57:	cp	2
	jr	nz,.60		;[8A7Fh]
	ld	a,c
	rrca
	rrca
	rrca
	rrca
	and	0Fh
	ld	(ix+7),a
	ld	(ix+2),1
.60:	cp	1Dh
	jr	nz,.61		;[8A91h]
	ld	a,(B8B42)	;[8B42h]
	cp	5
	jr	z,.62		;[8A8Bh]
	dec	a
.62:	ld	(B8B41),a	;[8B41h]
	ld	(B8B42),a	;[8B42h]
.61:	cp	1Bh
	jr	nz,.63		;[8A9Ch]
	ld	a,(B8B43)	;[8B43h]
	add	a,c
	ld	(B8B43),a	;[8B43h]
.63:	jp	.64		;[89FAh]
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S8A9F:	ld	(ix),lx
	ld	(ix+1),hx
	ret
.49:	call	S8A9F		;[8A9Fh]
	add	a,a
	ld	hl,376h
	call	S8AC1		;[8AC1h]
	ld	a,(hl)
	ld	(ix+0Ah),a
	inc	hl
	ld	a,(hl)
	ld	(ix+0Bh),a
	ld	(ix+2),1
	ld	(ix+9),c
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S8AC1:	add	a,l
	ld	l,a
	ret	nc
	inc	h
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S8AC6:	ld	d,0
	ld	ix,T8B19	;[8B19h]
	call	S8ADA		;[8ADAh]
	ld	ix,T8B26	;[8B26h]
	call	S8ADA		;[8ADAh]
	ld	ix,T8B33	;[8B33h]
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S8ADA:	ld	a,(ix+2)
	and	a
	ret	z
	ld	e,a
	ld	a,(ix+7)
	add	a,a
	ld	hl,328h
	call	S8AC1		;[8AC1h]
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	add	hl,de
	ld	c,(hl)
	ld	a,(B8B43)	;[8B43h]
	add	a,c
	ld	c,a
	and	0Fh
	ld	(ix+0Ch),a
	inc	(ix+2)
	bit	4,c
	ret	z
	sub	a
	ld	(ix+2),a
	ld	(ix+0Ch),a
	ret
;
W8B08:	dw	0
T8B09	equ	$-1
T8B0A:	db	0,0,0
B8B0D:	db	0
T8B0E:	db	0,0,0,0,0,0,0,0
T8B16:	db	0
B8B17:	db	0
B8B18:	db	0BFh		;'ø'
T8B19:	db	0,0
B8B1B:	db	0
T8B1C:	db	0,0,0,0,0,0
B8B22:	db	0
T8B23:	db	0,0
B8B25:	db	0
T8B26:	db	0,0
B8B28:	db	0
T8B29:	db	0,0,0,0,0,0
B8B2F:	db	0
T8B30:	db	0,0
B8B32:	db	0
T8B33:	db	0,0
B8B35:	db	0
T8B36:	db	0,0,0,0,0,0
B8B3C:	db	0
T8B3D:	db	0,0
B8B3F:	db	0
B8B40:	db	0
B8B41:	db	0
B8B42:	db	0
B8B43:	db	0
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S8B44:	ld	a,(B84C6)	;[84C6h]
	or	a
	jp	z,.72		;[8C0Ch]
	ld	ix,7F2Bh
	ld	b,a
.71:	push	bc
	push	ix
	ld	c,(ix+7)
	sla	c
	sla	c
	ld	hl,T8DB2	;[8DB2h]
	ld	a,(ix+3)
	call	S8BFC		;[8BFCh]
	ld	a,(ix+4)
	call	S8BFC		;[8BFCh]
	ld	a,(ix+5)
	call	S8BFC		;[8BFCh]
	ld	a,(ix)
	call	S8C09		;[8C09h]
	ld	a,(ix+1)
	call	S8C09		;[8C09h]
	ld	a,(ix+2)
	call	S8C09		;[8C09h]
	ld	a,(ix+6)
	rrca
	rrca
	rrca
	inc	a
	ld	b,a
	call	S8CB4		;[8CB4h]
	ld	(W8BDB),ix	;[8BDBh]
	ld	e,38h		;'8'
.70:	push	ix
	ld	hl,T8DB2	;[8DB2h]
	ld	b,3
.68:	ld	a,(hl)
	and	0C0h		;'¿'
	ld	c,a
	ld	a,(ix)
	and	0C0h		;'¿'
	cp	c
	jr	c,.66		;[8BDAh]
	jr	nz,.67		;[8BBBh]
	inc	ix
	inc	hl
	djnz	.68		;[8B99h]
	ld	b,3
.69:	ld	a,(ix)
	cp	(hl)
	jr	c,.66		;[8BDAh]
	jr	nz,.67		;[8BBBh]
	inc	ix
	inc	hl
	djnz	.69		;[8BAEh]
.67:	pop	ix
	ld	bc,6
	add	ix,bc
	ld	a,e
	sub	6
	ld	e,a
	jr	nc,.70		;[8B92h]
.74:	pop	ix
	ld	bc,8
	add	ix,bc
	pop	bc
	dec	b
	jp	nz,.71		;[8B50h]
	ld	(iy+47h),0
	jr	.72		;[8C0Ch]
.66:	ld	hl,0
W8BDB	equ	$-2
	ld	bc,35h
	add	hl,bc
	push	hl
	ld	bc,6
	add	hl,bc
	ex	(sp),hl
	ld	c,e
	ld	a,c
	ld	b,0
	pop	de
	or	a
	jr	z,.73		;[8BF1h]
	lddr
.73:	pop	de
	ld	hl,T8DB2	;[8DB2h]
	ld	bc,6
	ldir
	jr	.74		;[8BC8h]
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S8BFC:	sub	40h		;'@'
	jr	nc,.75		;[8C01h]
	sub	a
.75:	sla	c
	rla
	sla	c
	rla
	rrca
	rrca
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S8C09:	ld	(hl),a
	inc	hl
	ret
.72:	ld	de,158h
	ld	hl,50h
	ld	b,0
	call	SB5DC		;[0B5DCh]
	ld	a,0F8h		;'¯'
	ld	b,(iy+4Ch)
	inc	b
	ld	(iy+4Ch),b
	res	2,(iy+4Ch)
	call	S8CB4		;[8CB4h]
	call	SB8C4		;[0B8C4h]
	push	bc
	push	ix
	push	hl
	pop	ix
	ld	de,100h
	call	S8EA0		;[8EA0h]
	pop	ix
	pop	bc
	ld	b,c
	ld	de,2000h
	call	SB5D9		;[0B5D9h]
	ld	de,438h
	sub	a
.76:	push	af
	call	S8C4F		;[8C4Fh]
	pop	af
	inc	a
	cp	0Ah
	jr	nz,.76		;[8C44h]
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S8C4F:	push	de
	exx
	add	a,1
	daa
	ld	e,0
	call	S8C98		;[8C98h]
	ld	a,80h		;'Ä'
	call	SB6EB		;[0B6EBh]
	ld	a,40h		;'@'
	call	SB6EB		;[0B6EBh]
	ld	bc,300h
.77:	ld	a,(ix)
	rla
	rl	c
	rla
	rl	c
	ld	a,(ix)
	inc	ix
	and	3Fh		;'?'
	add	a,40h		;'@'
	call	SB6EB		;[0B6EBh]
	djnz	.77		;[8C66h]
	ld	a,40h		;'@'
	call	SB6EB		;[0B6EBh]
	ld	e,0
	ld	a,c
	call	S8CA1		;[8CA1h]
T8C86	equ	$-2
	ld	b,3
.78:	ld	a,(ix)
	call	S8C98		;[8C98h]
	inc	ix
	djnz	.78		;[8C8Ah]
	exx
	pop	de
	inc	d
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S8C98:	push	af
	rrca
	rrca
	rrca
	rrca
	call	S8CA1		;[8CA1h]
	pop	af
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S8CA1:	and	0Fh
	jr	nz,.79		;[8CADh]
	bit	0,e
	jr	nz,.81		;[8CAFh]
	ld	a,10h
	jr	.81		;[8CAFh]
.79:	ld	e,1
.81:	add	a,30h		;'0'
	jp	SB6EB		;[0B6EBh]
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S8CB4:	ld	ix,T8C86	;[8C86h]
	ld	de,3Ch
.82:	add	ix,de
	add	a,8
	djnz	.82		;[8CBBh]
	ret
;::===============================::
;||   No execution path to here   ||
;::===============================::
	ld	(bc),a
	add	hl,bc
	inc	c
	ld	bc,0
	ld	(bc),a
	add	hl,bc
	inc	c
	ld	bc,0
	ld	(bc),a
	add	hl,bc
	inc	c
	ld	bc,0
	ld	(bc),a
	add	hl,bc
	inc	c
	ld	bc,0
	ld	(bc),a
	add	hl,bc
	inc	c
	ld	bc,0
	ld	(bc),a
	add	hl,bc
	inc	c
	ld	bc,0
	ld	(bc),a
	add	hl,bc
	inc	c
	ld	bc,0
	ld	(bc),a
	add	hl,bc
	inc	c
	ld	bc,0
	ld	(bc),a
	add	hl,bc
	inc	c
	ld	bc,0
	ld	(bc),a
	add	hl,bc
	inc	c
	ld	bc,0
	ld	(bc),a
	rrca
	ld	(bc),a
	ld	bc,0
	ld	(bc),a
	rrca
	ld	(bc),a
	ld	bc,0
	ld	(bc),a
	rrca
	ld	(bc),a
	ld	bc,0
	ld	(bc),a
	rrca
	ld	(bc),a
	ld	bc,0
	ld	(bc),a
	rrca
	ld	(bc),a
	ld	bc,0
	ld	(bc),a
	rrca
	ld	(bc),a
	ld	bc,0
	ld	(bc),a
	rrca
	ld	(bc),a
	ld	bc,0
	ld	(bc),a
	rrca
	ld	(bc),a
	ld	bc,0
	ld	(bc),a
	rrca
	ld	(bc),a
	ld	bc,0
	ld	(bc),a
	rrca
	ld	(bc),a
	ld	bc,0
	dec	bc
	dec	b
	ld	d,1
	nop
	nop
	dec	bc
	dec	b
	ld	d,1
	nop
	nop
	dec	bc
	dec	b
	ld	d,1
	nop
	nop
	dec	bc
	dec	b
	ld	d,1
	nop
	nop
	dec	bc
	dec	b
	ld	d,1
	nop
	nop
	dec	bc
	dec	b
	ld	d,1
	nop
	nop
	dec	bc
	dec	b
	ld	d,1
	nop
	nop
	dec	bc
	dec	b
	ld	d,1
	nop
	nop
	dec	bc
	dec	b
	ld	d,1
	nop
	nop
	dec	bc
	dec	b
	ld	d,1
	nop
	nop
	ld	bc,1012h
	ld	bc,0
	ld	bc,1012h
	ld	bc,0
	ld	bc,1012h
	ld	bc,0
	ld	bc,1012h
	ld	bc,0
	ld	bc,1012h
	ld	bc,0
	ld	bc,1012h
	ld	bc,0
	ld	bc,1012h
	ld	bc,0
	ld	bc,1012h
	ld	bc,0
	ld	bc,1012h
	ld	bc,0
	ld	bc,1012h
	ld	bc,0
;
T8DB2:	db	0,0,0,0,0,0
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S8DB8:	db	'˝À',0FFh,'v(',13h,'˝À˛~(',0Dh,':4',84h,'˝',0A6h,'’',17h
	db	'8',4,'˝À:ˆ:',0B9h,84h,0B7h,'»',8,'Õ',90h,0B5h,'›*',0B4h
	db	84h,8,'À',7Fh,' DÊ? ',19h,'Õ]',87h,'›! ',84h,11h,0,7
	db	'Õ@',8Eh,'›!@',84h,11h,0,0Ah,'Õ@',8Eh,18h,'2Ÿ',1,0B1h
	db	'D',11h,'mD',1Fh,'8'
;::===============================::
;||      Indexed entry point      ||
;::===============================::
T8E09:	inc	h
	ld	de,4474h
	rra
	jr	c,.88		;[8E2Eh]
	ld	de,4481h
	rra
	jr	c,.88		;[8E2Eh]
	ld	de,448Eh
	rra
	jr	c,.88		;[8E2Eh]
	ld	de,4499h
	rra
	jr	c,.88		;[8E2Eh]
	ld	de,44A4h
	jr	.88		;[8E2Eh]
.84:	exx
	ld	bc,44C0h
	ld	de,44CFh
.88:	exx
	call	S8E81		;[8E81h]
.86:	set	2,(iy-2)
	ld	(iy+3Ah),0
	call	SA257		;[0A257h]
	jp	SB546		;[0B546h]
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S8E40:	bit	7,(ix+14h)
	ret	nz
	ld	a,(ix+0Ch)
	ld	c,a
	bit	6,(ix+0Bh)
	jr	nz,.90		;[8E50h]
	sub	a
.90:	push	de
	ld	d,a
	ld	e,0
	call	SB841		;[0B841h]
	ld	a,d
	pop	de
	push	af
	call	SB8C1		;[0B8C1h]
	push	hl
	pop	ix
	push	de
	call	S8EA0		;[8EA0h]
	ld	ix,44DEh
	pop	de
	inc	d
	pop	af
	ld	c,a
	rrca
	rrca
	rrca
	rrca
	and	0Fh
	add	a,30h		;'0'
	ld	(ix+1),a
	ld	a,c
	and	0Fh
	add	a,30h		;'0'
	ld	(ix+2),a
	jr	S8EA0		;[8EA0h]
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S8E81:	call	SB8C1		;[0B8C1h]
	push	hl
	pop	ix
	ld	de,700h
	call	S8EA0		;[8EA0h]
	exx
	push	bc
	exx
	pop	ix
	ld	de,900h
	call	S8EA0		;[8EA0h]
	exx
	push	de
	exx
	pop	ix
	ld	de,0B00h
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S8EA0:	ex	de,hl
	ld	b,(ix)
	ld	a,20h		;' '
	sub	b
	srl	a
	add	a,a
	add	a,a
	add	a,a
	ld	l,a
	ex	de,hl
.91:	inc	ix
	ld	a,(ix)
	push	bc
	exx
	call	SB6EB		;[0B6EBh]
	exx
	pop	bc
	djnz	.91		;[8EAEh]
	inc	ix
	ret
;::===============================::
;||   No execution path to here   ||
;::===============================::
	inc	d
	ld	a,d
	and	7
	ret	nz
	ld	a,e
	add	a,20h		;' '
	ld	e,a
	ret	c
	ld	a,d
	sub	8
	ld	d,a
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S8ECE:	ld	c,a
	cp	0Ah
	jr	c,.92		;[8EE1h]
	cp	64h		;'d'
	jr	c,.93		;[8EDCh]
	ld	b,64h		;'d'
	call	S8EE3		;[8EE3h]
.93:	ld	b,0Ah
	call	S8EE3		;[8EE3h]
.92:	ld	b,1
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S8EE3:	ld	l,0
	ld	a,c
.95:	sub	b
	jr	c,.94		;[8EEDh]
	ld	c,a
	inc	l
	jr	.95		;[8EE6h]
.94:	ld	a,l
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S8EEE:	and	0Fh
	push	de
	call	S8EFA		;[8EFAh]
	pop	de
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S8EF5:	ld	a,e
	add	a,10h
	ld	e,a
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S8EFA:	push	bc
	push	de
	exx
	pop	de
	exx
	add	a,a
	add	a,a
	ld	c,a
	call	S8F16		;[8F16h]
	call	S8F15		;[8F15h]
	inc	d
	push	de
	exx
	pop	de
	exx
	call	S8F15		;[8F15h]
	call	S8F15		;[8F15h]
	pop	bc
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S8F15:	inc	c
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S8F16:	ld	a,c
	exx
	ld	bc,800h
	jp	.96		;[0B6F1h]
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S8F1E:	ld	a,(B8B40)	;[8B40h]
	or	a
	jr	nz,.97		;[8F27h]
	call	S8913		;[8913h]
.97:	ld	a,(B842B)	;[842Bh]
	and	(iy-34h)
	and	40h		;'@'
	jr	nz,.98		;[8F43h]
	dec	(iy+38h)
	jr	nz,.98		;[8F43h]
	ld	(iy+38h),0Ch
	ld	a,(B84B6)	;[84B6h]
	sub	1
	daa
	ld	(B84B6),a	;[84B6h]
.98:	exx
	ld	de,50AFh
	exx
	ld	hl,0D330h
	ld	(hl),1
	inc	l
	ld	(hl),70h	;'p'
	inc	l
	ld	a,(B84B6)	;[84B6h]
	ld	c,a
	rrca
	rrca
	rrca
	rrca
	and	0Fh
	add	a,2Ch		;','
	add	a,a
	add	a,a
	ld	(hl),a
	inc	l
	ld	(hl),0Fh
	inc	l
	ld	(hl),1
	inc	l
	ld	(hl),80h	;'Ä'
	inc	l
	ld	a,c
	and	0Fh
	add	a,2Ch		;','
	add	a,a
	add	a,a
	ld	(hl),a
	inc	l
	ld	(hl),0Fh
	ld	a,c
	or	a
	ret	nz
	set	3,(iy-2)
	set	7,(iy-2)
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S8F81:	bit	4,(iy-2)
	jr	z,.99		;[8F91h]
	ld	de,200h
	ld	ix,450Bh
	call	S8EA0		;[8EA0h]
.99:	ld	a,(B847E)	;[847Eh]
	and	30h		;'0'
	jr	z,.100		;[8FB6h]
	ld	ix,451Ch
	ld	de,1100h
	call	S8EA0		;[8EA0h]
	ld	de,1000h
	ld	ix,452Bh
	bit	4,(iy-1)
	jr	nz,.101		;[8FB3h]
	ld	ix,453Ah
.101:	call	S8EA0		;[8EA0h]
.100:	bit	6,(iy-1)
	jr	nz,.102		;[9001h]
	ld	de,830h
	ld	ix,T8FF9	;[8FF9h]
	ld	c,8
.103:	ld	a,(ix)
	or	a
	push	ix
	call	nz,S8EEE	;[8EEEh]
	call	z,S8EF5		;[8EF5h]
	pop	ix
	inc	ix
	dec	c
	jr	nz,.103		;[8FC5h]
	ld	a,(B8403)	;[8403h]
	call	S8ECE		;[8ECEh]
.104:	set	5,(iy-2)
	call	S88FE		;[88FEh]
	set	2,(iy-2)
	call	SA257		;[0A257h]
	res	5,(iy-2)
	ld	a,0Ah
	ld	(B8B41),a	;[8B41h]
	ld	(B8B42),a	;[8B42h]
	ret
;
T8FF9:	db	0Ah,0Bh,0Ch,0Bh,0Ah,0
T8FFF:	db	0Dh,0
.102:	ld	de,800h
	ld	ix,44EBh
	call	S8EA0		;[8EA0h]
	ld	de,0A00h
	ld	ix,44FCh
	call	S8EA0		;[8EA0h]
	jr	.104		;[8FDEh]
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S9017:	call	S94C2		;[94C2h]
	bit	3,(iy-1)
	jr	z,.105		;[9051h]
	bit	0,(iy-1)
	jr	nz,.105		;[9051h]
	ld	ix,(W84A6)	;[84A6h]
	ld	b,0Ah
	ld	de,0
	ld	c,(iy+23h)
.106:	ld	a,e
	add	a,c
	daa
	ld	e,a
	ld	a,d
	adc	a,0
	daa
	ld	d,a
	djnz	.106		;[9032h]
	call	SB841		;[0B841h]
	ld	a,(iy+33h)
	or	a
	jr	z,.105		;[9051h]
	ld	b,a
	ld	e,0
	ld	d,(iy+34h)
.107:	call	SB841		;[0B841h]
	djnz	.107		;[904Ch]
.105:	res	0,(iy-1)
	call	S9093		;[9093h]
	call	S9327		;[9327h]
	ld	a,(B84A8)	;[84A8h]
	or	a
	ret	z
	ld	b,a
	ld	ix,5B20h
.110:	push	bc
	call	S90AD		;[90ADh]
	jr	c,.108		;[908Ah]
	ld	hl,(W84A9)	;[84A9h]
	dec	l
	ld	a,(hl)
	ld	(ix+3),a
	dec	l
	ld	a,(hl)
	ld	(ix+2),a
	dec	l
	ld	a,(hl)
	ld	(ix+1),a
	dec	l
	ld	a,(hl)
	ld	(ix),a
	ld	(W84A9),hl	;[84A9h]
	dec	(iy+29h)
	jr	.109		;[908Fh]
.108:	ld	de,4
	add	ix,de
.109:	pop	bc
	djnz	.110		;[9065h]
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S9093:	ld	ix,T8430	;[8430h]
	call	S90AD		;[90ADh]
	jr	c,.111		;[90A0h]
	ld	(ix+2),0FFh	;
.111:	ld	ix,T8450	;[8450h]
	call	S90AD		;[90ADh]
	ret	c
	ld	(ix+2),0FFh	;
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S90AD:	ld	a,(ix+2)
	cp	20h		;' '
	jr	nz,.112		;[90BEh]
	ld	a,0FFh		;
	ld	(ix+2),a
	bit	7,(ix+3)
	ret	nz
.112:	bit	7,(ix+3)
	jr	nz,.113		;[9106h]
	bit	4,(ix-9)
	jr	z,.114		;[9100h]
	inc	a
	jr	nz,.114		;[9100h]
	bit	6,(ix+4)
	jr	nz,.114		;[9100h]
	ld	a,(ix-2)
	and	3
	jr	nz,.114		;[9100h]
	bit	6,(ix-5)
	jr	nz,.114		;[9100h]
	ld	(iy+39h),0
	ld	a,(ix-10h)
	ld	(ix),a
	ld	a,(ix-0Fh)
	ld	(ix+1),a
	ld	a,(ix+3)
	add	a,(ix-3)
	or	80h		;'Ä'
	ld	(ix+2),a
	ld	a,4
	call	S8787		;[8787h]
.114:	ld	a,(ix+2)
	inc	a
	scf
	ret	z
.113:	bit	6,(ix+3)
	jr	z,.115		;[9149h]
	ld	a,(ix+2)
	ld	e,a
	rrca
	and	3
	bit	0,e
	jr	z,.116		;[911Eh]
	bit	0,(ix+3)
	jr	nz,.116		;[911Eh]
	inc	a
.116:	bit	3,e
	jr	z,.117		;[9124h]
	neg
.117:	add	a,(ix)
	ld	c,a
	ld	a,e
	rlca
	rlca
	rlca
	and	3
	bit	4,e
	jr	z,.118		;[9139h]
	bit	0,(ix+3)
	jr	nz,.118		;[9139h]
	inc	a
.118:	bit	7,e
	jr	z,.119		;[913Fh]
	neg
.119:	add	a,(ix+1)
	ld	b,a
	ld	a,1
	ex	af,af'
	jp	.120		;[916Fh]
.115:	ld	a,2
	bit	7,(ix+3)
	jr	nz,.121		;[9158h]
	bit	4,(ix+4)
	jr	z,.121		;[9158h]
	inc	a
.121:	ex	af,af'
	ld	hl,43BAh
	ld	a,(ix+2)
	and	7
	add	a,a
	add	a,l
	ld	l,a
	ld	a,(hl)
	add	a,(ix)
	ld	c,a
	inc	l
	ld	a,(hl)
	add	a,(ix+1)
	ld	b,a
.120:	and	a
	bit	6,(ix+3)
	call	nz,S9411	;[9411h]
	ld	e,0Bh
	bit	7,(ix+3)
	jr	nz,.122		;[9182h]
	ld	e,(ix-1)
.122:	res	7,c
	res	7,b
	ld	(ix),c
	ld	(ix+1),b
	jp	c,.123		;[91FAh]
	push	de
	call	S9298		;[9298h]
	pop	de
	jr	nc,.124		;[919Ch]
	res	1,b
	res	1,c
	jr	.130		;[91F0h]
.124:	bit	7,(ix+3)
	jr	z,.126		;[91A8h]
	bit	6,(ix+3)
	jr	nz,.127		;[91B2h]
.126:	bit	7,(ix+2)
	res	7,(ix+2)
	jr	nz,.123		;[91FAh]
.127:	push	de
	call	S924D		;[924Dh]
	pop	de
	jr	nc,.128		;[91E9h]
	dec	l
	dec	l
	dec	l
	ld	c,(hl)
	inc	l
	ld	b,(hl)
	inc	l
	ld	a,(hl)
	cp	0A0h		;'†'
	call	c,S944A		;[944Ah]
	bit	7,(ix+3)
	jr	nz,.130		;[91F0h]
	and	0E0h		;'‡'
	ld	e,10h
	jr	z,.129		;[91E4h]
	ld	e,5
	cp	0A0h		;'†'
	jr	nz,.129		;[91E4h]
	ld	e,1
	call	SB4E1		;[0B4E1h]
	and	70h		;'p'
	add	a,10h
	ld	(B84B3),a	;[84B3h]
.129:	call	S94A0		;[94A0h]
	jr	.130		;[91F0h]
.128:	push	de
	call	S936B		;[936Bh]
	pop	de
	jr	nc,.123		;[91FAh]
.130:	ld	(ix+2),20h	;' '
	ld	e,0Ah
	res	6,(ix+3)
.123:	ld	a,b
	sub	(iy+0Dh)
	call	SAC36		;[0AC36h]
	cp	23h		;'#'
	ret	nc
	add	a,a
	add	a,a
	ld	(B9247),a	;[9247h]
	ld	a,c
	sub	(iy+0Ch)
	call	SAC36		;[0AC36h]
	cp	3Dh		;'='
	ret	nc
.131:	add	a,a
	add	a,a
	ld	(B9244),a	;[9244h]
	ld	a,(ix+2)
	cp	20h		;' '
	jr	z,.132		;[9224h]
	ex	af,af'
	dec	a
	jp	nz,.121		;[9158h]
.132:	ld	a,(ix+2)
	bit	6,(ix+3)
	call	nz,S9403	;[9403h]
	cp	8
	jr	nc,.133		;[9237h]
	ld	a,(B8491)	;[8491h]
	and	7
.133:	ld	hl,(W84DB)	;[84DBh]
	dec	l
	ld	(hl),e
	dec	l
	add	a,8
	add	a,a
	add	a,a
	ld	(hl),a
	dec	l
	ld	(hl),0
B9244	equ	$-1
	dec	l
	ld	(hl),0
B9247	equ	$-1
	ld	(W84DB),hl	;[84DBh]
	scf
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S924D:	ld	d,b
	push	de
	ld	de,4
	ld	hl,5C00h
	dec	c
	dec	c
	res	7,c
	ld	a,b
	sub	2
	and	7Fh		;''
	ld	(B9285),a	;[9285h]
	ld	a,(B8496)	;[8496h]
	or	a
	jr	z,.134		;[9272h]
	ld	b,a
.136:	ld	a,(hl)
	sub	c
	and	78h		;'x'
	jr	z,.135		;[9279h]
.138:	add	hl,de
	djnz	.136		;[9268h]
	and	a
.134:	pop	de
	inc	c
	inc	c
	res	7,c
	ld	b,d
	ret
.135:	ld	a,(hl)
	sub	c
	and	7Fh		;''
	cp	5
	jr	nc,.138		;[926Eh]
	inc	l
	ld	a,(hl)
	dec	l
	sub	0
B9285	equ	$-1
	and	7Fh		;''
	cp	5
	jr	nc,.138		;[926Eh]
	inc	l
	inc	l
	inc	l
	bit	3,(hl)
	jr	z,.134		;[9272h]
	dec	l
	dec	l
	dec	l
	jr	.138		;[926Eh]
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S9298:	push	bc
	bit	0,(ix+2)
	jr	z,.139		;[92B3h]
	ld	a,(ix+2)
	and	7
	dec	a
	cp	3
	jr	nc,.140		;[92ABh]
	inc	c
	inc	c
.140:	sub	2
	cp	3
	jr	nc,.139		;[92B3h]
	inc	b
	inc	b
.139:	call	SAD6C		;[0AD6Ch]
	ld	a,(hl)
	and	7Fh		;''
	jr	nz,.141		;[92BDh]
	pop	bc
	ret
.141:	pop	de
	cp	14h
	jr	z,.146		;[930Ch]
	cp	16h
	jr	z,.143		;[9310h]
	cp	18h
	ret	c
	ret	z
	cp	1Fh
	jr	c,.143		;[9310h]
	ret	z
	cp	2Fh		;'/'
	ret	z
	cp	30h		;'0'
	ret	z
	cp	32h		;'2'
	ret	z
	cp	36h		;'6'
	ret	nc
	cp	20h		;' '
	ret	c
	cp	2Fh		;'/'
	jr	nc,.144		;[92FDh]
	ld	e,0Ah
	call	S94A0		;[94A0h]
	ld	de,43A3h
	call	S9479		;[9479h]
	srl	a
	jr	nc,.145		;[92F8h]
	bit	0,(iy+12h)
	jr	nz,.145		;[92F8h]
	inc	a
.145:	call	SA5D3		;[0A5D3h]
	scf
	ret
.144:	cp	31h		;'1'
	jr	z,.146		;[930Ch]
T9300	equ	$-1
	cp	33h		;'3'
	ret	c
	cp	36h		;'6'
	ret	nc
	inc	(hl)
	ld	a,(hl)
	cp	36h		;'6'
	ret	c
.146:	ld	(hl),0
	ccf
	ret
.143:	set	0,(iy-1)
	ld	(iy+24h),0
	ld	(iy+25h),1
	ld	(iy+26h),1
	ld	a,5
	call	S8787		;[8787h]
	jr	.146		;[930Ch]
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S9327:	ld	de,(W84A9)	;[84A9h]
	ld	a,(B8491)	;[8491h]
	and	7
	add	a,a
	add	a,a
	add	a,a
	add	a,90h		;'ê'
	ld	l,a
	ld	h,5Bh		;'['
	ld	b,2
.150:	ld	a,(iy+29h)
	cp	10h
	jr	z,.147		;[9366h]
	ld	a,(hl)
	inc	a
	jr	nz,.148		;[934Ah]
	inc	l
	inc	l
	inc	l
	jr	.149		;[9363h]
.148:	inc	(iy+29h)
	inc	l
	ld	a,(hl)
	inc	a
	ld	(de),a
	inc	e
	inc	l
	ld	a,(hl)
	inc	a
	ld	(de),a
	inc	e
	inc	l
	ld	a,(hl)
	and	7
	or	90h		;'ê'
	ld	(de),a
	inc	e
	ld	a,80h		;'Ä'
	ld	(de),a
	inc	e
.149:	inc	l
	djnz	.150		;[933Ah]
.147:	ld	(W84A9),de	;[84A9h]
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S936B:	bit	6,(iy-54h)
	jr	nz,.151		;[9397h]
	ld	a,(T8420)	;[8420h]
	add	a,2
	sub	c
	and	7Fh		;''
	cp	5
	jr	nc,.151		;[9397h]
	ld	a,(B8421)	;[8421h]
	add	a,2
	sub	b
	and	7Fh		;''
	cp	5
	jr	nc,.151		;[9397h]
	call	S93F0		;[93F0h]
	push	ix
	ld	ix,T8420	;[8420h]
	ld	hl,T8423	;[8423h]
	jr	.152		;[93BEh]
.151:	bit	6,(iy-34h)
	ret	nz
	ld	a,(T8440)	;[8440h]
	add	a,2
	sub	c
	and	7Fh		;''
	cp	5
	ret	nc
	ld	a,(B8441)	;[8441h]
	add	a,2
	sub	b
	and	7Fh		;''
	cp	5
	ret	nc
	call	S93F0		;[93F0h]
	push	ix
	ld	ix,T8440	;[8440h]
	ld	hl,T8443	;[8443h]
.152:	jr	nz,.153		;[93D8h]
	bit	4,(iy-1)
	jr	z,.154		;[93D0h]
	set	6,(ix+14h)
	ld	(ix+1Dh),1Eh
	jr	.153		;[93D8h]
.154:	bit	5,(iy-1)
	jr	z,.153		;[93D8h]
	ld	d,5
.153:	ld	a,d
	or	a
	jr	z,.155		;[93E7h]
	set	0,(ix+0Bh)
	call	SB883		;[0B883h]
	ld	(iy+39h),0
.155:	pop	ix
	ld	a,8
	call	S8787		;[8787h]
	scf
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S93F0:	ld	d,0
	bit	7,(ix+3)
	ret	z
	ld	d,9
	bit	6,(ix+3)
	jr	z,.156		;[9401h]
	ld	d,2
.156:	inc	d
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S9403:	ld	e,0Ah
	ld	a,(ix+3)
	rlca
	rlca
	rlca
	rlca
	and	3
	add	a,21h		;'!'
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S9411:	ld	a,(ix+3)
	dec	a
	ld	e,a
	and	0Fh
	cp	0Fh
	jr	nz,.157		;[9427h]
	res	6,(ix+3)
	ld	(ix+2),20h	;' '
	inc	b
	scf
	ret
.157:	bit	0,e
.158:	jr	z,.159		;[9441h]
	cp	5
	ld	a,e
	jr	c,.160		;[9439h]
	cp	0E0h		;'‡'
	jr	nc,.162		;[9440h]
	dec	b
	add	a,10h
	jr	.162		;[9440h]
.160:	cp	0CFh		;'œ'
	jr	c,.162		;[9440h]
	inc	b
	sub	10h
.162:	ld	e,a
.159:	ld	(ix+3),e
	and	0Fh
	cp	3
	ccf
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S944A:	push	af
	ld	a,8
	bit	7,(ix+3)
	ld	de,43A2h
	call	z,S9479		;[9479h]
	ld	e,a
	rra
	ld	a,0
	jr	nc,.163		;[9465h]
	bit	0,(iy+12h)
	jr	z,.163		;[9465h]
	ld	a,8
.163:	add	a,e
	and	18h
	ld	e,a
	ld	a,(hl)
	and	18h
	sub	e
	jr	nc,.164		;[9474h]
	call	SA554		;[0A554h]
	jr	.165		;[9477h]
.164:	ld	a,(hl)
	sub	e
	ld	(hl),a
.165:	pop	af
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S9479:	ld	a,(ix+2)
	and	0F8h		;'¯'
	cp	(iy-4Ch)
	jr	nz,.166		;[948Eh]
	ld	a,(B8435)	;[8435h]
	and	3
	bit	3,(iy-4Bh)
	jr	.167		;[9497h]
.166:	ld	a,(B8455)	;[8455h]
	and	3
	bit	3,(iy-2Bh)
.167:	jr	z,.168		;[949Bh]
	add	a,2
.168:	add	a,a
	add	a,e
	ld	e,a
	ld	a,(de)
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S94A0:	ld	a,(ix-0Ah)
	add	a,e
	daa
	ld	(ix-0Ah),a
	ld	a,(ix-0Bh)
	adc	a,0
	daa
	ld	(ix-0Bh),a
	ld	a,(ix-0Ch)
	adc	a,0
	daa
	ld	(ix-0Ch),a
	call	c,SB85F		;[0B85Fh]
	set	1,(ix-5)
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S94C2:	ld	b,48h		;'H'
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S94C4:	ld	hl,0D330h
.169:	ld	(hl),0F0h	;''
	inc	l
	djnz	.169		;[94C7h]
	ld	(W84DB),hl	;[84DBh]
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S94D0:	call	SB4E1		;[0B4E1h]
	and	0Fh
	cp	0Bh
	jr	nc,S94D0	;[94D0h]
	add	a,0
	daa
	add	a,20h		;' '
	daa
	ld	(iy+37h),a
	ld	(iy+38h),0Ch
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S94E7:	res	6,(iy-1)
	res	3,(iy-2)
	ld	a,(B8403)	;[8403h]
	cp	8
	jr	nc,.171		;[9514h]
	ld	hl,600h
	call	S958E		;[958Eh]
	bit	7,(iy+4Dh)
	jr	nz,.172		;[950Bh]
	ld	(iy+4Eh),80h	;'Ä'
	call	S956C		;[956Ch]
	ld	a,1
.172:	ld	e,80h		;'Ä'
	ld	b,a
.173:	rlc	e
	djnz	.173		;[950Eh]
	jr	.174		;[9555h]
.171:	ld	hl,640h
	call	S958E		;[958Eh]
	dec	(iy+3Bh)
	jr	nz,.175		;[9530h]
	call	SB4E1		;[0B4E1h]
	and	3
	add	a,4
	ld	(B84BA),a	;[84BAh]
	set	6,(iy-1)
	call	S94D0		;[94D0h]
.175:	call	SB4E1		;[0B4E1h]
	ld	(B84C7),a	;[84C7h]
	ld	a,(B84CC)	;[84CCh]
	and	7Fh		;''
	jr	z,S956C		;[956Ch]
	bit	6,(iy-1)
	jr	nz,.176		;[954Fh]
	ld	e,1
	bit	0,a
	jr	nz,.177		;[9551h]
	ld	e,2
	bit	1,a
	jr	nz,.177		;[9551h]
.176:	ld	e,4
.177:	xor	e
	ld	(B84CC),a	;[84CCh]
.174:	ld	ix,TC800	;[0C800h]
.179:	rr	e
	ret	c
	ld	c,(ix)
	ld	b,0
	bit	7,(ix+2)
	jr	z,.178		;[9568h]
	inc	b
.178:	add	ix,bc
	jr	.179		;[9559h]
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S956C:	call	S95AF		;[95AFh]
	ld	a,(iy+4Eh)
	call	S95DD		;[95DDh]
	ld	hl,T95FD	;[95FDh]
	call	6EC6h
	ld	b,80h		;'Ä'
.180:	push	bc
	call	h.TIMI		;[0FD9Fh]
	pop	bc
	djnz	.180		;[957Dh]
	call	S95CD		;[95CDh]
        ld      iy,ROWTABLE        ;[847Fh]
        jp      0D000h          ;LOAD STAGE
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S958E:	ld	de,28E8h
	ld	bc,18h
	call	S95AC		;[95ACh]
	ld	de,2A88h
	ld	c,8
	call	S95AC		;[95ACh]
	ld	de,20E8h
	ld	c,18h
	call	S95AC		;[95ACh]
	ld	de,2288h
	ld	c,8
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S95AC:	ldir
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S95AF:	pop	hl
	di
	ld	(0DFFDh),sp
	ld	sp,(0E000h)
	in	a,(0A8h)	;PSLOT register
	ld	d,a
	and	0F0h		;''
	out	(0A8h),a	;PSLOT register
	ld	a,(0FFFFh)
	cpl
	ld	e,a
	and	0F0h		;''
	ld	(0FFFFh),a
	ei
	push	de
	jp	(hl)
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S95CD:	pop	hl
	pop	de
	di
	ld	a,d
	out	(0A8h),a	;PSLOT register
	ld	a,e
	ld	(0FFFFh),a
	ld	sp,(0DFFDh)
	ei
	jp	(hl)
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S95DD:	cp	80h		;'Ä'
	ld	hl,3030h
	jr	z,.182		;[95F9h]
	ld	hl,(W9602)	;[9602h]
	inc	h
	ld	a,h
	cp	3Ah		;':'
	jr	nz,.183		;[95F0h]
	ld	h,30h		;'0'
	inc	l
.183:	ld	de,3133h
	rst	20h
	jr	nz,.182		;[95F9h]
	ld	hl,3130h
.182:	ld	(W9602),hl	;[9602h]
	ret
;
T95FD:	db	'"MAZE'
W9602:	dw	3030h
T9604:	db	'"',0
.205:	ld	de,1430h
	ld	c,(iy+49h)
	ld	a,lx
	and	20h		;' '
	jr	nz,.186		;[9618h]
	ld	de,14B8h
	ld	c,(iy+4Ah)
.186:	ld	a,c
	ld	(B9665),a	;[9665h]
	bit	7,(ix+0Eh)
.185	equ	$-3
	jr	z,.187		;[966Dh]
	push	de
	ld	hl,0FFD0h
	add	hl,de
	ex	de,hl
	exx
	call	SB6C1		;[0B6C1h]
	exx
	pop	de
	exx
	ld	b,3
.188:	ld	a,41h		;'A'
	call	SB6EB		;[0B6EBh]
.184	equ	$-2
	djnz	.188		;[9631h]
	ld	(ix+0Eh),2
	ld	(ix+19h),0
	call	S9719		;[9719h]
	ld	a,(ix+4)
	ld	(hl),a
	inc	hl
	ld	a,(ix+5)
	ld	(hl),a
	inc	hl
	ld	a,(ix+6)
	ld	(hl),a
	inc	hl
	ld	(ix+17h),lx
	ld	(ix+18h),hx
	ld	bc,341h
.189:	ld	(hl),c
	inc	hl
	djnz	.189		;[965Bh]
	ld	a,(ix+13h)
	ld	(hl),a
	inc	hl
	ld	(hl),0
B9665	equ	$-1
;::===============================::
;||      Indexed entry point      ||
;::===============================::
T9666:	ld	a,(B8497)	;[8497h]
	ld	(ix+1Ah),a
	ret
.187:	exx
	ld	a,(B8497)	;[8497h]
	sub	(ix+1Ah)
	cp	8
	jr	nc,.190		;[9682h]
	ld	a,(ix+7)
	and	20h		;' '
	ld	(ix+7),a
	jr	.191		;[9688h]
.190:	ld	a,(B8497)	;[8497h]
	ld	(ix+1Ah),a
.191:	ld	c,0
	ld	a,(ix+19h)
	bit	2,(ix+7)
	jr	z,.192		;[9698h]
	or	a
	jr	z,.192		;[9698h]
	inc	c
	dec	a
.192:	bit	3,(ix+7)
	jr	z,.193		;[96A4h]
	cp	2
	jr	z,.193		;[96A4h]
	inc	c
	inc	a
.193:	push	af
	ld	a,(ix+17h)
	add	a,(ix+19h)
	ld	l,a
	ld	hx,(ix+18h)
	exx
	set	5,d
	set	0,d
	call	SB44E		;[0B44Eh]
	res	0,d
	in	a,(98h)		;VRAM access
	ld	c,a
	exx
	ld	a,c
	exx
	or	a
	jr	nz,.194		;[96C8h]
	ld	a,c
	rrca
	rrca
	rrca
	rrca
	ld	c,a
.194:	ld	a,(ix+19h)
	add	a,a
	add	a,a
	add	a,a
	add	a,e
	ld	e,a
	call	SB43F		;[0B43Fh]
	res	5,d
	ld	a,c
	ld	c,8
.195:	out	(98h),a		;VRAM access
	dec	c
	jr	nz,.195		;[96D8h]
	exx
	ld	a,(hl)
	cp	20h		;' '
	jr	nz,.196		;[96E5h]
	ld	a,40h		;'@'
.196:	bit	0,(ix+7)
	jr	z,.197		;[96F2h]
	inc	a
	cp	5Bh		;'['
	jr	nz,.197		;[96F2h]
	ld	a,40h		;'@'
.197:	bit	1,(ix+7)
	jr	z,.198		;[96FFh]
	dec	a
	cp	3Fh		;'?'
	jr	nz,.198		;[96FFh]
	ld	a,5Ah		;'Z'
.198:	cp	40h		;'@'
	jr	nz,.199		;[9705h]
	ld	a,20h		;' '
.199:	ld	(hl),a
	call	SB6EB		;[0B6EBh]
	pop	af
	ld	(ix+19h),a
	bit	5,(ix+7)
	ret	z
	ld	(ix+0Eh),0
	jp	S980C		;[980Ch]
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S9719:	ld	hl,7F2Bh
	ld	a,(iy+47h)
	inc	(iy+47h)
	or	a
	ret	z
	ld	b,a
	ld	de,8
.201:	add	hl,de
	djnz	.201		;[9728h]
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S972C:	ld	ix,T8420	;[8420h]
	call	S9737		;[9737h]
	ld	ix,T8440	;[8440h]
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S9737:	bit	7,(ix+14h)
	ret	nz
	ld	a,(ix+2)
	or	(ix+3)
	ret	nz
	dec	(ix+2)
	call	S9AB4		;[9AB4h]
	inc	(ix+2)
	ld	(ix+0Eh),80h	;'Ä'
	ld	a,(ix+0Bh)
	or	0C3h		;'√'
	ld	(ix+0Bh),a
	set	7,(ix+14h)
	ld	a,(ix)
	and	7Ch		;'|'
	ld	c,a
	ld	a,(ix+1)
	and	7Ch		;'|'
	ld	b,a
	call	SB13B		;[0B13Bh]
	call	SAD6C		;[0AD6Ch]
	ld	c,22h
	ld	a,(ix+8)
	dec	a
	jp	m,.202		;[9795h]
	ld	c,1Fh
	jr	z,.202		;[9795h]
	ld	c,32h
	ld	de,5BE8h
	ld	a,(B84C0)	;[84C0h]
	ld	b,a
	add	a,a
	add	a,b
	add	a,e
	ld	e,a
	ex	de,hl
	ld	(hl),e
	inc	l
	ld	(hl),d
	inc	l
	ld	a,(ix+8)
	ld	(hl),a
	ex	de,hl
	inc	(iy+41h)
.202:	ld	(hl),c
	ld	a,0Fh
	call	S8787		;[8787h]
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S979C:  call    SCANJOY           ;[0B40Bh]
        bit     0,(iy+8)        ;BARRA ESPACIADORA  old: FD CB 08 46
      ; bit     7,(iy+7)        ;ENTER              new: FD CB 07 78
	jr	nz,.203		;[97A9h]
	set	5,(iy-58h)
.203:   ld      a,(iy+8)        ;CURSORES           old: FD 7E 08
        cpl                                         old: 2F
      ; bit     1,(iy+6)        ;CTRL               new: FD CB 06 48
        and     0F0h            ;CURSORES           old: E6 F0
      ; nop                                         new: 00 00
      ; nop
        jr      z,.204          ;[97B5h] si no se pulsa salta a .204
	set	5,(iy-38h)
.204:	ld	ix,T8420	;[8420h]
	call	S97C0		;[97C0h]
	ld	ix,T8440	;[8440h]
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S97C0:	bit	7,(ix+14h)
	ret	z
	ld	a,(ix+0Eh)
	or	a
	jp	nz,.205		;[9606h]
	bit	4,(ix+7)
	ret	z
	res	7,(ix+14h)
	call	S99C1		;[99C1h]
	jr	nc,.206		;[97EEh]
	ld	a,(B8403)	;[8403h]
	dec	a
	jr	z,.206		;[97EEh]
	set	7,(ix+14h)
	ld	(ix+0Eh),0
	ld	a,0Dh
.207:	call	S8787		;[8787h]
	ret
.206:	sub	a
	ld	(ix+3),a
	ld	(ix+4),a
	ld	(ix+5),a
	ld	(ix+6),a
	ld	(ix+8),a
	ld	(ix+9),a
	ld	(ix+0Ah),a
	ld	(ix+10h),0FFh	;
	ld	(ix+2),20h	;' '
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S980C:	ld	a,(ix+14h)
	and	80h		;'Ä'
	ld	(ix+14h),a
	ld	a,lx
	and	20h		;' '
	exx
	ld	de,1400h
	jp	nz,.209		;[0B602h]
	ld	de,1488h
	jp	.209		;[0B602h]
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S9825:	bit	3,(iy-2)
	jr	nz,.210		;[9848h]
	ld	a,(B842B)	;[842Bh]
	and	(iy-34h)
	rla
	jr	nc,.211		;[984Dh]
	bit	6,(iy-1)
	jr	nz,.210		;[9848h]
	ld	a,(B842C)	;[842Ch]
	cp	(iy-33h)
	jr	nc,.212		;[9845h]
	ld	a,(B844C)	;[844Ch]
.212:	ld	(B8403),a	;[8403h]
.210:	set	7,(iy-2)
	ret
.211:	ld	ix,T8420	;[8420h]
	call	S9858		;[9858h]
	ld	ix,T8440	;[8440h]
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S9858:	bit	6,(ix+0Bh)
	ret	z
	bit	7,(ix+0Bh)
	ret	nz
	ld	c,(ix)
	ld	b,(ix+1)
	call	SAD6C		;[0AD6Ch]
	ld	a,(hl)
	cp	36h		;'6'
	jr	c,.213		;[9878h]
	call	S98CB		;[98CBh]
	call	S98DD		;[98DDh]
	jr	.218		;[98B5h]
.213:	ld	a,c
	and	3
	jr	z,.215		;[988Dh]
	call	S9D58		;[9D58h]
	ld	a,(hl)
	cp	36h		;'6'
	jr	c,.215		;[988Dh]
	call	S98D1		;[98D1h]
	call	S98DD		;[98DDh]
	jr	.218		;[98B5h]
.215:	ld	a,b
	and	3
	jr	z,.218		;[98B5h]
	call	S9D68		;[9D68h]
	ld	a,(hl)
	cp	36h		;'6'
	jr	c,.217		;[98A2h]
	call	S98D1		;[98D1h]
	call	S98D7		;[98D7h]
	jr	.218		;[98B5h]
.217:	ld	a,c
	and	3
	jr	z,.218		;[98B5h]
	call	S9D7C		;[9D7Ch]
	ld	a,(hl)
	cp	36h		;'6'
	jr	c,.218		;[98B5h]
	call	S98CB		;[98CBh]
	call	S98D7		;[98D7h]
.218:	ld	(ix),c
	ld	(ix+1),b
	inc	(ix+0Dh)
	res	3,(ix+0Dh)
	dec	(ix+16h)
	ret	nz
	set	7,(ix+0Bh)
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S98CB:	ld	a,c
	and	3
	ret	z
	dec	c
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S98D1:	ld	a,c
	and	3
	ret	z
	inc	c
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S98D7:	ld	a,b
	and	3
	ret	z
	inc	b
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S98DD:	ld	a,b
	and	3
	ret	z
	dec	b
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S98E3:	call	S98E6		;[98E6h]
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S98E6:	bit	3,(iy+1Fh)
	jr	z,.219		;[991Ch]
	res	3,(iy+1Fh)
	ld	a,(B849E)	;[849Eh]
.221:	ld	hl,(W849A)	;[849Ah]
	call	S995D		;[995Dh]
	jr	z,.220		;[990Ch]
	bit	2,(iy+1Fh)
	jr	z,.219		;[991Ch]
	res	2,(iy+1Fh)
	ld	a,(B849E)	;[849Eh]
	xor	2
	jr	.221		;[98F3h]
.220:	ld	(W849A),hl	;[849Ah]
	ld	(hl),0
	ld	a,(B849E)	;[849Eh]
	and	0F0h		;''
	or	c
	or	8
	ld	(B849E),a	;[849Eh]
.219:	bit	7,(iy+1Fh)
	ret	z
	res	7,(iy+1Fh)
	ld	a,(B849E)	;[849Eh]
.223:	rrca
	rrca
	rrca
	rrca
	ld	hl,(W849C)	;[849Ch]
	call	S995D		;[995Dh]
	jr	z,.222		;[9944h]
	bit	6,(iy+1Fh)
	ret	z
	res	6,(iy+1Fh)
	ld	a,(B849E)	;[849Eh]
	xor	20h		;' '
	jr	.223		;[9928h]
.222:	ld	(W849C),hl	;[849Ch]
	ld	(hl),0
	rrc	c
	rrc	c
	rrc	c
	rrc	c
	ld	a,(B849E)	;[849Eh]
	and	0Fh
	or	c
	or	80h		;'Ä'
	ld	(B849E),a	;[849Eh]
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S995D:	ld	(hl),0
	and	3
	ld	c,a
	jr	nz,.224		;[9979h]
	push	hl
	ld	c,3
	call	S9D7C		;[9D7Ch]
	call	S99BB		;[99BBh]
	jr	z,.225		;[99B8h]
	pop	hl
	ld	c,0
	call	S9D43		;[9D43h]
	call	S99BB		;[99BBh]
	ret
.224:	dec	a
	jr	nz,.226		;[998Fh]
	push	hl
	dec	c
	call	S9D43		;[9D43h]
	call	S99BB		;[99BBh]
	jr	z,.225		;[99B8h]
	pop	hl
	inc	c
	call	S9D58		;[9D58h]
	call	S99BB		;[99BBh]
	ret
.226:	dec	a
	jr	nz,.227		;[99A5h]
	push	hl
	dec	c
	call	S9D58		;[9D58h]
	call	S99BB		;[99BBh]
	jr	z,.225		;[99B8h]
	pop	hl
	inc	c
	call	S9D68		;[9D68h]
	call	S99BB		;[99BBh]
	ret
.227:	push	hl
	dec	c
	call	S9D68		;[9D68h]
	call	S99BB		;[99BBh]
	jr	z,.225		;[99B8h]
	pop	hl
	inc	c
	call	S9D7C		;[9D7Ch]
	call	S99BB		;[99BBh]
	ret
.225:	pop	af
	sub	a
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S99BB:	ld	a,(hl)
	sub	11h
	ret	z
	dec	a
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S99C1:	bit	7,(ix+14h)
	ret	nz
	ld	a,(B8403)	;[8403h]
	bit	6,(iy-1)
	jr	z,.228		;[99D0h]
	sub	a
.228:	ld	(ix+0Ch),a
	ld	(ix+0Dh),0FFh	;
	ld	(ix+0Eh),1
	call	SAA6E		;[0AA6Eh]
	push	ix
	ld	a,lx
	and	20h		;' '
	ld	ix,T8420	;[8420h]
	jr	z,.229		;[99EEh]
	ld	ix,T8440	;[8440h]
.229:	ld	a,(ix)
	and	7Ch		;'|'
	ld	c,a
	ld	a,(ix+1)
	and	7Ch		;'|'
	ld	b,a
	pop	ix
	ld	a,b
	or	c
	jr	nz,.230		;[9A04h]
	ld	bc,(W8492)	;[8492h]
.230:	call	SAD6C		;[0AD6Ch]
	ld	a,80h		;'Ä'
	ld	(BB1E5),a	;[0B1E5h]
	call	SB1E3		;[0B1E3h]
	ex	af,af'
	rla
	jr	c,S9A2D		;[9A2Dh]
	push	hl
	call	SB1B6		;[0B1B6h]
	pop	hl
	ex	af,af'
	and	55h		;'U'
	scf
	jr	z,.232		;[9A41h]
	ld	e,a
	and	4
	jr	nz,.233		;[9A24h]
	ld	a,e
.233:	call	SB215		;[0B215h]
	call	S9D90		;[9D90h]
	call	SB13B		;[0B13Bh]
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S9A2D:	ld	(ix),c
	ld	(ix+1),b
	bit	7,(ix+14h)
	jr	nz,.232		;[9A41h]
	ld	a,(ix+0Bh)
	and	3Fh		;'?'
	ld	(ix+0Bh),a
.232:	ld	a,36h		;'6'
	ld	(BB1E5),a	;[0B1E5h]
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S9A47:	bit	6,(iy-1)
	ret	nz
	ld	a,(B84B8)	;[84B8h]
	bit	0,(iy-2)
	jr	z,.234		;[9A87h]
	bit	1,(iy-2)
	ret	nz
	cp	8Ch		;'å'
	ret	c
	ld	hl,8000h
.237:	ld	a,(hl)
	and	7Fh		;''
	jr	z,.235		;[9A73h]
	cp	11h
	jr	c,.236		;[9A71h]
	cp	33h		;'3'
	jr	c,.235		;[9A73h]
	cp	36h		;'6'
	jr	nc,.235		;[9A73h]
.236:	ld	(hl),36h	;'6'
.235:	inc	hl
	ld	a,h
	cp	84h		;'Ñ'
	jr	nz,.237		;[9A60h]
	set	1,(iy-2)
	ld	(iy+39h),0
	ld	a,10h
	call	S8787		;[8787h]
	ret
.234:	cp	17h
	ret	c
	set	0,(iy-2)
	ld	hl,8000h
.240:	ld	a,(hl)
	cp	11h
	jr	c,.238		;[9AA4h]
	cp	13h
	jr	c,.239		;[9AA2h]
	cp	1Fh
	jr	z,.239		;[9AA2h]
	cp	32h		;'2'
	jr	nz,.238		;[9AA4h]
.239:	ld	(hl),0
.238:	inc	hl
	ld	a,h
	cp	84h		;'Ñ'
	jr	nz,.240		;[9A91h]
	ld	(iy+39h),0
	ld	a,0Eh
	call	S8787		;[8787h]
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S9AB4:	bit	7,(iy-4Bh)
	jr	nz,.241		;[9AC6h]
	ld	a,(B8433)	;[8433h]
	ld	b,(iy-5Dh)
	ld	hl,0D37Fh
	call	S9AD4		;[9AD4h]
.241:	bit	7,(iy-2Bh)
	ret	nz
	ld	a,(B8453)	;[8453h]
	ld	b,(iy-3Dh)
	ld	hl,0D37Bh
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S9AD4:	ld	e,8
	sub	8
	jr	c,.242		;[9AE8h]
	ld	e,4
	sub	8
	jr	c,.242		;[9AE8h]
	ld	e,0Ah
	sub	8
	jr	c,.242		;[9AE8h]
	ld	e,2
.242:	ld	a,b
	cp	2
	jr	nc,.243		;[9AF4h]
	bit	4,(iy+18h)
	jr	z,.243		;[9AF4h]
	inc	e
.243:	ld	(hl),e
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S9AF6:	bit	0,(ix+1)
	jr	z,.244		;[9B00h]
	set	5,(iy-1)
.244:	bit	1,(ix+1)
	jr	z,.245		;[9B0Ah]
	set	4,(iy-1)
.245:	call	S9DE4		;[9DE4h]
	bit	7,(ix+1)
	jr	nz,.246		;[9B20h]
	ld	a,97h		;'ó'
	ld	(BB502),a	;[0B502h]
	ld	hl,423Eh
	ld	(WB50D),hl	;[0B50Dh]
	jr	.247		;[9B29h]
.246:	sub	a
	ld	(BB502),a	;[0B502h]
	ld	l,a
	ld	h,a
	ld	(WB50D),hl	;[0B50Dh]
.247:	bit	6,(ix+1)
	jr	nz,.248		;[9B3Ch]
	ld	a,97h		;'ó'
	ld	(BB528),a	;[0B528h]
	ld	hl,5C3Eh
	ld	(WB533),hl	;[0B533h]
	jr	.249		;[9B45h]
.248:	sub	a
	ld	(BB528),a	;[0B528h]
	ld	l,a
	ld	h,a
	ld	(WB533),hl	;[0B533h]
.249:	ld	hl,8000h
	ld	de,8001h
	ld	bc,3FFh
	ld	(hl),0
	ldir
	ld	hl,5C00h
	ld	(W8494),hl	;[8494h]
	ld	(iy+17h),0
	ld	hl,5B20h
	ld	(W84A9),hl	;[84A9h]
	ld	(iy+29h),0
	ld	c,(ix+3)
	push	ix
	pop	de
	inc	de
	inc	de
	inc	de
	inc	de
	call	S9BF1		;[9BF1h]
	push	de
	ld	a,(ix+1)
	ld	de,43E2h
	ld	c,3
	rla
	jr	c,.250		;[9B80h]
	inc	c
.250:	call	S9BF1		;[9BF1h]
	pop	de
	ld	a,(ix+2)
	push	af
	ld	hl,8000h
	ld	a,(ix+3)
	add	a,4
	ld	c,a
	ld	a,(ix)
	sub	c
	ld	c,a
	jr	nc,.251		;[9B9Ch]
	res	7,(ix+2)
.251:	ld	a,(de)
	cp	80h		;'Ä'
	jr	c,.252		;[9BD3h]
	and	7Fh		;''
	inc	a
	ld	b,a
.253:	inc	hl
	djnz	.253		;[9BA5h]
.258:	inc	de
	dec	c
	jr	nz,.251		;[9B9Ch]
	bit	7,(ix+2)
	res	7,(ix+2)
	jr	nz,.251		;[9B9Ch]
	pop	af
	ld	(ix+2),a
	bit	2,(ix+1)
	call	nz,S9ECF	;[9ECFh]
	call	S9F27		;[9F27h]
	call	S9E7E		;[9E7Eh]
	ld	a,(B8403)	;[8403h]
	cp	8
	ret	c
	call	S9FB2		;[9FB2h]
	jp	.254		;[0A015h]
.252:	cp	13h
	jr	c,.255		;[9BE0h]
	exx
	ld	c,a
	exx
	call	S9C8B		;[9C8Bh]
	inc	hl
	jr	.258		;[9BA8h]
.255:	inc	a
	ld	b,a
.257:	call	S9C8B		;[9C8Bh]
	inc	hl
	djnz	.257		;[9BE2h]
	jr	.258		;[9BA8h]
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S9BEA:	ld	a,(hl)
	and	7Fh		;''
	ret	z
	cp	11h
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S9BF1:	ld	a,c
	or	a
	ret	z
.262:	ld	a,(de)
	ld	b,a
	ld	a,c
	dec	a
	jr	z,.259		;[9C39h]
	call	S9D87		;[9D87h]
	jr	nz,.259		;[9C39h]
	ld	a,3
	cp	c
	jr	nz,.260		;[9C0Bh]
	inc	de
	call	S9D87		;[9D87h]
	dec	de
	jr	z,.259		;[9C39h]
.260:	inc	de
	call	S9D87		;[9D87h]
	jr	nz,.261		;[9C1Ah]
	inc	de
	call	S9D87		;[9D87h]
	dec	de
	dec	de
	jr	nz,.259		;[9C39h]
	inc	de
.261:	ld	a,(de)
	dec	c
	and	1Fh
	ld	l,a
	ld	h,4
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	ld	a,b
	and	1Fh
	add	a,l
	ld	l,a
	ld	a,b
	exx
	and	0E0h		;'‡'
	ld	b,a
	exx
	call	S9C70		;[9C70h]
.265:	inc	de
	dec	c
	jr	nz,.262		;[9BF4h]
	ret
.259:	push	de
	ld	a,b
	exx
	ld	hl,43D2h
	rra
	rra
	rra
	rra
	and	0Eh
	ld	e,a
	ld	d,0
	add	hl,de
	ld	a,b
	cp	0C0h		;'¿'
	jr	nc,.263		;[9C5Ah]
	cp	20h		;' '
	jr	z,.263		;[9C5Ah]
	bit	2,e
	ld	b,80h		;'Ä'
	jr	nz,.263		;[9C5Ah]
	ld	b,40h		;'@'
.263:	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	push	de
	exx
	pop	de
	ld	a,b
	and	1Fh
	inc	a
.264:	ex	af,af'
	add	hl,de
	call	S9C70		;[9C70h]
	ex	af,af'
	dec	a
	jr	nz,.264		;[9C64h]
	pop	de
	jr	.265		;[9C34h]
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S9C70:	exx
	ld	a,b
	exx
	cp	0C0h		;'¿'
	jp	nc,.266		;[9CE5h]
	exx
	ld	c,11h
	exx
	cp	80h		;'Ä'
	jr	z,S9C8B		;[9C8Bh]
	exx
	inc	c
	exx
	cp	40h		;'@'
	jr	z,S9C8B		;[9C8Bh]
	exx
	ld	c,36h
	exx
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S9C8B:	push	bc
	push	hl
	call	S9DA5		;[9DA5h]
	pop	hl
	pop	bc
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S9C92:	call	S9BEA		;[9BEAh]
	push	af
	exx
	ld	a,c
	exx
	cp	3Fh		;'?'
	jr	c,.267		;[9C9Eh]
	sub	a
.267:	ld	(hl),a
	pop	af
	ret	nc
	push	hl
	call	S9D43		;[9D43h]
	call	S9BEA		;[9BEAh]
	jr	nc,.268		;[9CAFh]
	res	2,(hl)
	call	S9CDE		;[9CDEh]
.268:	pop	hl
	push	hl
	call	S9D58		;[9D58h]
	call	S9BEA		;[9BEAh]
	jr	nc,.269		;[9CBEh]
	res	3,(hl)
	call	S9CDE		;[9CDEh]
.269:	pop	hl
	push	hl
	call	S9D68		;[9D68h]
	call	S9BEA		;[9BEAh]
	jr	nc,.270		;[9CCDh]
	res	0,(hl)
	call	S9CDE		;[9CDEh]
.270:	pop	hl
	push	hl
	call	S9D7C		;[9D7Ch]
	call	S9BEA		;[9BEAh]
	jr	nc,.271		;[9CDCh]
	res	1,(hl)
	call	S9CDE		;[9CDEh]
.271:	pop	hl
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S9CDE:	ld	a,(hl)
	and	7Fh		;''
	ret	nz
	set	4,(hl)
	ret
.266:	ld	b,0
	push	hl
	call	S9D43		;[9D43h]
	call	S9D2F		;[9D2Fh]
	jr	nc,.272		;[9CF4h]
	set	2,(hl)
	set	0,b
.272:	pop	hl
	push	hl
	call	S9D58		;[9D58h]
	call	S9D2F		;[9D2Fh]
	jr	nc,.273		;[9D02h]
	set	3,(hl)
	set	1,b
.273:	pop	hl
	push	hl
	call	S9D68		;[9D68h]
	call	S9D2F		;[9D2Fh]
	jr	nc,.274		;[9D10h]
	set	2,b
	set	0,(hl)
.274:	pop	hl
	push	hl
	call	S9D7C		;[9D7Ch]
	call	S9D2F		;[9D2Fh]
	jr	nc,.275		;[9D1Eh]
	set	3,b
	set	1,(hl)
.275:	pop	hl
	ld	a,b
	or	a
	jr	nz,.276		;[9D25h]
	ld	a,10h
.276:	ld	(hl),a
	exx
	ld	a,b
	cp	0C0h		;'¿'
	exx
	ret	nz
	set	7,(hl)
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S9D2F:	ld	a,(hl)
	and	7Fh		;''
	ret	z
	cp	10h
	ret	c
	ret	nz
	ld	a,(hl)
	and	80h		;'Ä'
	ld	(hl),a
	scf
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S9D3D:	ld	a,b
	sub	4
	and	7Fh		;''
	ld	b,a
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S9D43:	ld	a,l
	sub	20h		;' '
	ld	l,a
	ret	nc
	dec	h
	ld	a,h
	cp	7Fh		;''
	ret	nz
	ld	a,h
	add	a,4
	ld	h,a
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S9D52:	ld	a,c
	add	a,4
	and	7Fh		;''
	ld	c,a
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S9D58:	inc	l
	ld	a,l
	and	1Fh
	ret	nz
	ld	a,l
	sub	20h		;' '
	ld	l,a
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S9D62:	ld	a,b
	add	a,4
	and	7Fh		;''
	ld	b,a
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S9D68:	ld	a,l
	add	a,20h		;' '
	ld	l,a
	ret	nc
	inc	h
	ld	a,h
	sub	4
	cp	80h		;'Ä'
	ret	nz
	ld	h,a
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S9D76:	ld	a,c
	sub	4
	and	7Fh		;''
	ld	c,a
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S9D7C:	dec	l
	ld	a,l
	cpl
	and	1Fh
	ret	nz
	ld	a,l
	add	a,20h		;' '
	ld	l,a
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S9D87:	ex	de,hl
	ld	a,(hl)
	inc	hl
	xor	(hl)
	dec	hl
	ex	de,hl
	and	0E0h		;'‡'
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S9D90:	call	S9D96		;[9D96h]
	ld	c,b
	ld	b,a
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S9D96:	ld	a,l
	and	1Fh
	add	a,a
	add	a,a
	ld	b,a
	add	hl,hl
	add	hl,hl
	add	hl,hl
	ld	a,h
	and	1Fh
	add	a,a
	add	a,a
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S9DA5:	exx
	ld	a,c
	exx
	cp	3Fh		;'?'
	jr	nz,.277		;[9DB7h]
	call	S9D96		;[9D96h]
	ld	(B8493),a	;[8493h]
	ld	a,b
	ld	(W8492),a	;[8492h]
	ret
.277:	cp	40h		;'@'
	ret	c
	call	S9D96		;[9D96h]
	ld	hl,(W8494)	;[8494h]
	ld	(hl),b
	inc	hl
	ld	(hl),a
	inc	hl
	exx
	ld	a,c
	exx
	and	3
	ld	b,a
	exx
	ld	a,c
	exx
	rra
	and	1Ch
	or	b
	add	a,a
	add	a,a
	add	a,a
	ld	(hl),a
	inc	hl
	call	SB4E1		;[0B4E1h]
	and	0C0h		;'¿'
	ld	(hl),a
	inc	hl
	ld	(W8494),hl	;[8494h]
	inc	(iy+17h)
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S9DE4:	ld	a,(ix+2)
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
	ld	e,0C0h		;'¿'
.279:	ld	hl,0EE0h
	add	hl,de
	push	de
	ld	de,2808h
	ld	bc,60h
	ldir
	ld	a,(ix+2)
	and	38h		;'8'
	rrca
	rrca
	rrca
	ld	e,a
	ld	d,0
	ld	hl,T9E76	;[9E76h]
	add	hl,de
	ld	a,(hl)
	and	0F0h		;''
	ld	(B9E6D),a	;[9E6Dh]
	rrca
	rrca
	rrca
	rrca
	ld	(B9E5C),a	;[9E5Ch]
	ld	a,(hl)
	and	0Fh
	ld	(B9E58),a	;[9E58h]
	rrca
	rrca
	rrca
	rrca
	ld	(B9E69),a	;[9E69h]
	ld	c,(hl)
	pop	de
	ld	hl,680h
	add	hl,de
	ld	de,2008h
	ld	b,60h		;'`'
	call	S9E4B		;[9E4Bh]
	ld	hl,7A0h
	ld	de,2200h
	ld	b,58h		;'X'
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S9E4B:	ld	c,0
	ld	a,(hl)
	and	0Fh
	jr	z,.280		;[9E5Eh]
	cp	7
	ld	a,c
	jr	z,.281		;[9E5Bh]
	or	0
B9E58	equ	$-1
	jr	.282		;[9E5Dh]
.281:	or	0
B9E5C	equ	$-1
.282:	ld	c,a
.280:	ld	a,(hl)
	and	0F0h		;''
	jr	z,.283		;[9E6Fh]
	cp	70h		;'p'
	ld	a,c
	jr	z,.284		;[9E6Ch]
	or	0
B9E69	equ	$-1
	jr	.285		;[9E6Eh]
.284:	or	0
B9E6D	equ	$-1
.285:	ld	c,a
.283:	ld	a,c
	ld	(de),a
	inc	hl
	inc	de
	djnz	S9E4B		;[9E4Bh]
	ret
;::===============================::
;||      Indexed entry point      ||
;::===============================::
T9E76:	and	(hl)
	inc	a
	ld	(hl),h
	push	de
	xor	c
	cp	0A6h		;'¶'
	xor	c
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S9E7E:	ld	hl,5B60h
	ld	de,5B61h
	ld	bc,2Fh
	ld	(hl),0
	ldir
	ld	hl,5C00h
	push	hl
	pop	ix
	ld	a,(iy+17h)
	or	a
	ret	z
	ld	b,a
.287:	ld	a,(ix+2)
	and	0E0h		;'‡'
	cp	0A0h		;'†'
	jr	nz,.286		;[9EC4h]
	ld	a,(ix)
	ld	c,(hl)
	ld	(ix),c
	ld	(hl),a
	inc	l
	ld	a,(ix+1)
	ld	c,(hl)
	ld	(ix+1),c
	ld	(hl),a
	inc	l
	ld	a,(ix+2)
	ld	c,(hl)
	ld	(ix+2),c
	ld	(hl),a
	inc	l
	ld	a,(ix+3)
	ld	c,(hl)
	ld	(ix+3),c
	ld	(hl),a
	inc	l
.286:	inc	ix
	inc	ix
	inc	ix
	inc	ix
	djnz	.287		;[9E97h]
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S9ECF:	ld	hl,8000h
	ld	b,0
.289:	ld	a,(hl)
	cp	36h		;'6'
	jr	nz,.288		;[9EDAh]
	inc	b
.288:	inc	hl
	ld	a,h
	cp	84h		;'Ñ'
	jr	nz,.289		;[9ED4h]
.290:	call	SB4E1		;[0B4E1h]
	and	3Fh		;'?'
	cp	b
	jr	nc,.290		;[9EE0h]
	inc	a
	ld	c,a
	ld	hl,7FFFh
.291:	inc	hl
	ld	a,(hl)
	cp	36h		;'6'
	jr	nz,.291		;[9EEDh]
	ld	a,b
	sub	c
	jr	z,.292		;[9EF9h]
	ld	(hl),0
.292:	djnz	.291		;[9EEDh]
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S9EFC:	call	SB4E1		;[0B4E1h]
	and	7
	cp	6
	jr	nc,S9EFC	;[9EFCh]
	add	a,19h
	ld	c,a
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S9F09:	call	SB4E1		;[0B4E1h]
	ld	l,a
	call	SB4E1		;[0B4E1h]
	and	3
	or	80h		;'Ä'
	ld	h,a
	ld	a,(hl)
	or	a
	jr	nz,S9F09	;[9F09h]
	push	bc
	push	hl
	call	S9D90		;[9D90h]
	call	SA87E		;[0A87Eh]
	pop	hl
	pop	bc
	jr	c,S9F09		;[9F09h]
	ld	(hl),c
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S9F27:	ld	a,(B8403)	;[8403h]
	cp	8
	ret	c
	ld	a,(B84BD)	;[84BDh]
	bit	6,(iy-1)
	jr	z,.295		;[9F38h]
	srl	a
.295:	ld	c,a
	call	SB4E1		;[0B4E1h]
	cp	c
	jr	c,.296		;[9F4Ch]
	call	S9EFC		;[9EFCh]
	call	S9F09		;[9F09h]
	set	4,(iy-2)
	call	S9F79		;[9F79h]
.296:	bit	6,(iy-1)
	ret	nz
.297:	call	SB4E1		;[0B4E1h]
	and	0Fh
	jr	z,.297		;[9F51h]
	cp	(iy+3Fh)
	jr	nc,.297		;[9F51h]
	ld	b,a
	ld	c,14h
.300:	push	bc
	call	SB4E1		;[0B4E1h]
	cp	(iy+40h)
	jr	nc,.298		;[9F6Dh]
	ld	c,31h
	jr	.299		;[9F72h]
.301	equ	$-1
.298:	and	3
	jr	nz,.299		;[9F72h]
	inc	c
.299:	call	S9F09		;[9F09h]
	pop	bc
	djnz	.300		;[9F60h]
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S9F79:	ld	a,c
	sub	19h
	rlca
	push	af
	rlca
	rlca
	rlca
	add	a,80h		;'Ä'
	ld	l,a
	ld	h,0Eh
	ld	de,2970h
	ld	bc,10h
	ldir
	pop	af
	ld	c,a
	ld	hl,T9FA6	;[9FA6h]
	add	hl,bc
	ld	de,2170h
	ld	a,(hl)
	inc	hl
	ld	b,4
	call	S9FA1		;[9FA1h]
	ld	a,(hl)
	ld	b,0Ch
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S9FA1:	ld	(de),a
	inc	de
	djnz	S9FA1		;[9FA1h]
	ret
;::===============================::
;||      Indexed entry point      ||
;::===============================::
T9FA6:	and	b
	sub	b
	sub	b
	ret	nc
	jr	nz,.301		;[9F6Ch]
	sub	b
	add	a,b
	or	b
	ret	po
	ld	d,b
	ld	b,b
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
S9FB2:	bit	1,(iy+48h)
	ret	z
	ld	hl,8000h
	ld	b,20h		;' '
.304:	push	bc
	push	hl
	ld	b,10h
.302:	ld	a,(hl)
	call	SA066		;[0A066h]
	ld	e,a
	ld	d,l
	ld	a,l
	xor	1Fh
	ld	l,a
	ld	a,(hl)
	call	SA066		;[0A066h]
	ld	(hl),e
	ld	l,d
	ld	(hl),a
	inc	l
	djnz	.302		;[9FC0h]
	ld	b,20h		;' '
	ld	a,(hl)
.303:	ld	c,a
	call	S9D58		;[9D58h]
	ld	a,(hl)
	ld	(hl),c
	djnz	.303		;[9FD7h]
	pop	hl
	call	S9D68		;[9D68h]
	pop	bc
	djnz	.304		;[9FBCh]
	ld	de,7Fh
.309:	ld	hl,W8492	;[8492h]
	ld	a,(hl)
	xor	e
	inc	a
	and	7Ch		;'|'
	ld	(hl),a
	inc	l
	ld	a,(hl)
	xor	d
	inc	a
	and	7Ch		;'|'
	ld	(hl),a
	ld	hl,5C00h
	ld	a,(iy+17h)
	or	a
;::===============================::
;||      Indexed entry point      ||
;::===============================::
TA000:	ret	z
	ld	b,a
.305:	ld	a,(hl)
	xor	e
	inc	a
	and	7Ch		;'|'
	ld	(hl),a
	inc	hl
	ld	a,(hl)
	xor	d
	inc	a
	and	7Ch		;'|'
	ld	(hl),a
	inc	hl
	inc	hl
	inc	hl
	djnz	.305		;[0A002h]
	ret
.254:	bit	0,(iy+48h)
	ret	z
	ld	hl,8000h
	ld	b,20h		;' '
.308:	push	bc
	push	hl
	ld	b,10h
.306:	ld	a,(hl)
	call	SA054		;[0A054h]
	ld	e,a
	push	hl
	ld	a,l
	xor	0E0h		;'‡'
	ld	l,a
	ld	a,h
	xor	3
	ld	h,a
	ld	a,(hl)
	call	SA054		;[0A054h]
	ld	(hl),e
	pop	hl
	ld	(hl),a
	call	S9D68		;[9D68h]
	djnz	.306		;[0A023h]
	ld	b,20h		;' '
	ld	a,(hl)
.307:	ld	c,a
	call	S9D68		;[9D68h]
	ld	a,(hl)
	ld	(hl),c
	djnz	.307		;[0A040h]
	pop	hl
	call	S9D58		;[9D58h]
	pop	bc
	djnz	.308		;[0A01Fh]
	ld	de,7F00h
	jr	.309		;[9FE9h]
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SA054:	call	SA079		;[0A079h]
	ret	nc
	ld	c,a
	and	8Ah		;'ä'
	bit	2,c
	jr	z,.310		;[0A060h]
	inc	a
.310:	bit	0,c
	ret	z
	or	4
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SA066:	call	SA079		;[0A079h]
	ret	nc
	ld	c,a
	and	85h		;'Ö'
	bit	3,c
	jr	z,.311		;[0A073h]
	or	2
.311:	bit	1,c
	ret	z
	or	8
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SA079:	cp	7Fh		;''
	jr	nc,.312		;[0A080h]
	cp	10h
	ret
.312:	cp	90h		;'ê'
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SA083:	inc	(iy+12h)
	sub	a
	bit	3,(iy-1)
	jr	z,.313		;[0A08Fh]
	ld	a,0Fh
.313:	call	SB4A6		;[0B4A6h]
	ld	hl,(W84D3)	;[84D3h]
	ld	de,220h
	add	hl,de
	ld	b,66h		;'f'
.314:	rlc	(hl)
	rlc	(hl)
	rlc	(hl)
	inc	hl
	djnz	.314		;[0A09Bh]
	sub	a
	ld	(B84D5),a	;[84D5h]
	call	SB468		;[0B468h]
	ld	de,1800h
	call	SB43F		;[0B43Fh]
	ld	hl,(W84D3)	;[84D3h]
	ld	bc,98h
	halt
	ld	a,1
	ld	(B84D5),a	;[84D5h]
.315:	outi
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
	jp	nz,.315		;[0A0BDh]
	ld	de,1000h
	call	SB43F		;[0B43Fh]
	ld	hl,(W84D3)	;[84D3h]
	ld	de,220h
	add	hl,de
	ex	de,hl
	ld	a,3
	ld	b,0
.317:	ex	af,af'
.316:	ld	a,(de)
	and	7
	or	0C0h		;'¿'
	ld	h,a
	ld	a,(de)
	and	0F8h		;'¯'
	ld	l,a
	inc	de
	outi
	outi
	outi
	outi
	outi
	outi
	outi
	outi
	jp	nz,.316		;[0A115h]
	inc	de
	inc	de
	ex	af,af'
	dec	a
	jp	nz,.317		;[0A114h]
	ld	de,1B00h
	call	SB43F		;[0B43Fh]
	ld	hl,0D330h
	ld	b,48h		;'H'
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
	outi
	outi
	jp	nz,.318		;[0A147h]
	ld	b,8
.319:	outi
	jp	nz,.319		;[0A170h]
	ld	de,1900h
	call	SB43F		;[0B43Fh]
	ld	hl,(W84D3)	;[84D3h]
	ld	de,110h
	add	hl,de
	ld	bc,98h
.320:	outi
	bit	0,a
	outi
	bit	0,a
	outi
	bit	0,a
	outi
	bit	0,a
	outi
	bit	0,a
	outi
	bit	0,a
	outi
	bit	0,a
	outi
	bit	0,a
	outi
	bit	0,a
	outi
	bit	0,a
	outi
	bit	0,a
	outi
	bit	0,a
	outi
	bit	0,a
	outi
	bit	0,a
	outi
	bit	0,a
	outi
	bit	0,a
	outi
	bit	0,a
	outi
	bit	0,a
	outi
	bit	0,a
	outi
	bit	0,a
	outi
	bit	0,a
	outi
	bit	0,a
	outi
	bit	0,a
	outi
	bit	0,a
	outi
	bit	0,a
	outi
	bit	0,a
	outi
	bit	0,a
	outi
	bit	0,a
	outi
	bit	0,a
	outi
	bit	0,a
	outi
	bit	0,a
	outi
	inc	hl
	inc	hl
	jp	nz,.320		;[0A185h]
	ld	de,3000h
	call	SB43F		;[0B43Fh]
	ld	hl,(W84D3)	;[84D3h]
	ld	de,220h
	add	hl,de
	ex	de,hl
	ld	a,3
	ld	b,0
.322:	ex	af,af'
.321:	ld	a,(de)
	and	7
	or	20h		;' '
	ld	h,a
	ld	a,(de)
	and	0F8h		;'¯'
	ld	l,a
	inc	de
	outi
	bit	0,a
	outi
	bit	0,a
	outi
	bit	0,a
	outi
	bit	0,a
	outi
	bit	0,a
	outi
	bit	0,a
	outi
	bit	0,a
	outi
	jp	nz,.321		;[0A21Bh]
	inc	de
	inc	de
	ex	af,af'
	dec	a
	jp	nz,.322		;[0A21Ah]
	ld	a,(0F3E0h)
	ld	b,a
	ld	a,1
	call	SB4A9		;[0B4A9h]
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SA257:	bit	2,(iy-2)
	jp	z,SB483		;[0B483h]
	res	2,(iy-2)
	ld	b,82h		;'Ç'
	bit	5,(iy-2)
	jr	nz,.324		;[0A271h]
	ld	a,10h
	call	S8787		;[8787h]
	ld	b,32h		;'2'
.324:	push	bc
	call	S979C		;[979Ch]
	halt
	halt
	pop	bc
	djnz	.324		;[0A271h]
	jp	SB483		;[0B483h]
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SA27D:	call	S979C		;[979Ch]
	res	3,(iy-1)
	bit	0,(iy-1)
	jr	z,.326		;[0A28Eh]
	set	3,(iy-1)
.326:	bit	3,(iy-51h)
	jr	nz,.327		;[0A2B1h]
	bit	3,(iy-31h)
	call	nz,SAA05	;[0AA05h]
	ld	ix,T8420	;[8420h]
	ld	hl,B84C1	;[84C1h]
	call	SA3F0		;[0A3F0h]
	ld	ix,T8440	;[8440h]
	ld	hl,B84C2	;[84C2h]
	call	SA3F0		;[0A3F0h]
	jr	.328		;[0A2CFh]
.327:	call	SA9F4		;[0A9F4h]
	ld	ix,T8440	;[8440h]
	ld	hl,B84C2	;[84C2h]
	call	SA3F0		;[0A3F0h]
	bit	3,(iy-31h)
	call	SAA05		;[0AA05h]
	ld	ix,T8420	;[8420h]
	ld	hl,B84C1	;[84C1h]
	call	SA3F0		;[0A3F0h]
.328:	ld	hl,5BD0h
	ld	(W84AD),hl	;[84ADh]
	ld	(iy+2Dh),0
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SA2D9:	ld	hl,(T8420)	;[8420h]
	bit	7,(iy-54h)
	jr	z,.329		;[0A2EAh]
	ld	hl,(T8440)	;[8440h]
	bit	7,(iy-34h)
	ret	nz
.329:	inc	h
	inc	h
	inc	l
	inc	l
	ld	c,h
	ld	a,l
	bit	7,(iy-34h)
	jr	nz,.330		;[0A303h]
	ld	de,(T8440)	;[8440h]
	inc	e
	inc	e
	inc	d
	inc	d
	add	hl,de
	srl	h
	srl	l
.330:	res	0,l
	res	0,h
	sub	l
	jr	nc,.331		;[0A30Ch]
	neg
.331:	and	7Fh		;''
	cp	21h		;'!'
	jr	c,.332		;[0A316h]
	ld	a,l
	xor	40h		;'@'
	ld	l,a
.332:	res	7,l
	ld	a,c
	sub	h
	jr	nc,.333		;[0A31Eh]
	neg
.333:	and	7Fh		;''
	cp	21h		;'!'
	jr	c,.334		;[0A328h]
	ld	a,h
	xor	40h		;'@'
	ld	h,a
.334:	res	7,h
	ld	(B848D),hl	;[848Dh]
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SA32E:	ld	ix,T8420	;[8420h]
	ld	hl,0D37Ch
	ld	b,0
	call	SA343		;[0A343h]
	ld	ix,T8440	;[8440h]
	ld	hl,0D378h
	ld	b,4
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SA343:	bit	7,(ix+0Bh)
	jp	nz,.335		;[0A3D2h]
	bit	6,(ix+0Bh)
	jr	nz,.336		;[0A38Ch]
	bit	0,(ix+0Eh)
	jr	nz,.336		;[0A38Ch]
	bit	0,(iy+12h)
	jr	z,.337		;[0A370h]
	ld	a,(ix+0Ah)
	or	a
	jr	z,.337		;[0A370h]
	dec	a
	ld	(ix+0Ah),a
	cp	32h		;'2'
	jr	nc,.335		;[0A3D2h]
	bit	1,(iy+12h)
	jr	nz,.335		;[0A3D2h]
.337:	bit	6,(ix+14h)
	jr	nz,.336		;[0A38Ch]
	bit	4,(ix+0Eh)
	jr	nz,.336		;[0A38Ch]
	ld	a,(ix+7)
	and	0Fh
	jr	z,.336		;[0A38Ch]
	add	a,4Ah		;'J'
	ld	e,a
	ld	d,43h		;'C'
	ld	a,(de)
	ld	(ix+0Dh),a
.336:	res	4,(ix+0Eh)
	bit	2,(ix+0Eh)
	jr	nz,.335		;[0A3D2h]
	ld	a,(ix+1)
	sub	(iy+0Dh)
	and	7Eh		;'~'
	add	a,a
	add	a,a
	ld	(hl),a
	ld	e,a
	inc	l
	ld	a,(ix)
	sub	(iy+0Ch)
	and	7Eh		;'~'
	add	a,a
	add	a,a
	ld	(hl),a
	ld	d,a
	inc	l
	ld	(hl),b
	bit	0,(ix+0Eh)
	ret	z
	inc	l
	ld	a,(ix+0Dh)
	cp	2
	jr	nc,.338		;[0A3C0h]
	ld	(hl),0
.338:	add	a,36h		;'6'
	add	a,a
	add	a,a
	ld	b,a
	ld	a,l
	sub	0Bh
	ld	l,a
	ld	(hl),e
	inc	l
	ld	(hl),d
	inc	l
	ld	(hl),b
	inc	l
	ld	(hl),0Eh
	ret
.335:	inc	l
	inc	l
	inc	l
	ld	(hl),c
	ret
.341:	inc	(ix+0Dh)
	jr	z,.339		;[0A3EBh]
	ld	a,(ix+0Dh)
	cp	6
	ret	nz
	ld	(ix+0Dh),4
	res	0,(ix+0Eh)
	ret
.339:	ld	a,3
	jp	S8787		;[8787h]
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SA3F0:	ld	a,(hl)
	or	a
	jr	z,.340		;[0A407h]
	bit	2,(ix+0Bh)
	jr	nz,.340		;[0A407h]
	dec	(hl)
	call	SA730		;[0A730h]
	jr	nc,.340		;[0A407h]
	set	2,(ix+0Bh)
	inc	(ix+8)
.340:	bit	6,(ix+0Bh)
	ret	nz
	bit	0,(ix+0Eh)
	jr	nz,.341		;[0A3D7h]
	bit	1,(ix+0Eh)
	jp	nz,.342		;[0B095h]
	bit	6,(ix+14h)
	jr	z,.343		;[0A427h]
	dec	(ix+1Dh)
	ret	nz
	res	6,(ix+14h)
.343:	ld	(ix+1Dh),0
	bit	5,(ix+7)
	jr	z,.346		;[0A491h]
	ld	a,(B84A1)	;[84A1h]
	or	a
	jr	nz,.346		;[0A491h]
	bit	3,(iy-1)
	jr	nz,.346		;[0A491h]
	ld	a,(ix+9)
	or	a
	jr	nz,.345		;[0A44Ah]
	ld	a,0Dh
	call	S8787		;[8787h]
	jr	.346		;[0A491h]
.345:	bit	5,(ix+0Bh)
	jr	nz,.346		;[0A491h]
	dec	(ix+9)
	set	5,(ix+0Bh)
	ld	a,(ix+15h)
	rrca
	rrca
	and	0Ch
	bit	2,(ix+14h)
	jr	z,.347		;[0A466h]
	add	a,4
.347:	ld	hl,435Ah
	add	a,l
	ld	l,a
	ld	a,(hl)
	ld	(B84A3),a	;[84A3h]
	inc	hl
	ld	a,(hl)
	ld	(iy+25h),a
	inc	hl
	ld	a,(hl)
	ld	(iy+26h),a
	ld	(W84A6),ix	;[84A6h]
	set	3,(iy-1)
	sub	a
	ld	(B84A2),a	;[84A2h]
	ld	(B84B2),a	;[84B2h]
	ld	(iy+22h),5
	ld	a,5
	call	S8787		;[8787h]
.346:	ld	a,(ix+7)
	bit	4,a
	jr	z,.348		;[0A49Fh]
	bit	4,(ix+0Eh)
	jr	nz,.348		;[0A49Fh]
	sub	a
.348:	and	0Fh
	ret	z
	ld	e,a
	ld	c,(ix)
	ld	b,(ix+1)
	call	SAD6C		;[0AD6Ch]
	ld	a,e
	and	3
	jr	z,.349		;[0A4C1h]
	cp	3
	jr	z,.349		;[0A4C1h]
	rra
	call	c,SA7BD		;[0A7BDh]
	bit	1,e
	call	nz,SA794	;[0A794h]
	call	SAD6C		;[0AD6Ch]
.349:	ld	a,(ix+1Dh)
	cp	36h		;'6'
	jr	z,.352		;[0A4EBh]
	push	af
	ld	(ix+1Dh),0
	ld	a,e
	and	0Ch
	cp	0Ch
	jr	z,.351		;[0A4E7h]
	bit	2,e
	call	nz,SA76B	;[0A76Bh]
	bit	3,e
	call	nz,SA742	;[0A742h]
	ld	a,(ix+1Dh)
	or	a
	jr	z,.351		;[0A4E7h]
	pop	af
	jr	.352		;[0A4EBh]
.351:	pop	af
	ld	(ix+1Dh),a
.352:	ld	a,e
	or	a
	jr	z,.353		;[0A503h]
	bit	0,(iy+12h)
	jr	z,.353		;[0A503h]
	bit	4,(ix+0Eh)
	jr	nz,.353		;[0A503h]
	ld	a,(ix+0Eh)
	add	a,40h		;'@'
	ld	(ix+0Eh),a
.353:	call	SA87E		;[0A87Eh]
	jr	nc,.354		;[0A529h]
	inc	l
	inc	l
	ld	a,(hl)
	ld	e,a
	and	0E0h		;'‡'
	jr	z,.355		;[0A53Ah]
	cp	0A0h		;'†'
	ret	z
	ld	a,(iy+12h)
	and	3
	ret	nz
	ld	a,e
	sub	8
	ld	(hl),a
	cpl
	and	18h
	call	z,SA554		;[0A554h]
	ld	de,25h
	jp	SB841		;[0B841h]
.354:	call	SA9C3		;[0A9C3h]
	ret	c
	ld	a,(ix+1Dh)
	or	a
	jr	nz,.356		;[0A570h]
	ld	(ix),c
	ld	(ix+1),b
	ret
.355:	ld	d,(ix+18h)
	bit	3,(hl)
	jr	nz,.357		;[0A54Bh]
	ld	d,(ix+19h)
	bit	4,(hl)
	jr	nz,.357		;[0A54Bh]
	ld	d,(ix+17h)
.357:	push	hl
	call	SB86D		;[0B86Dh]
	pop	hl
	sub	a
	call	S8787		;[8787h]
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SA554:	inc	l
	ld	de,(W8494)	;[8494h]
	dec	de
	ld	a,(de)
	ld	(hl),a
	dec	l
	dec	e
	ld	a,(de)
	ld	(hl),a
	dec	l
	dec	e
	ld	a,(de)
	ld	(hl),a
	dec	l
	dec	e
	ld	a,(de)
	ld	(hl),a
	ld	(W8494),de	;[8494h]
	dec	(iy+17h)
	ret
.356:	ld	lx,(ix+1Eh)
	ld	hx,(ix+1Fh)
	cp	13h
	jr	c,.358		;[0A5E7h]
	cp	20h		;' '
	jp	c,.359		;[0A657h]
	cp	2Fh		;'/'
	jr	c,.360		;[0A5C8h]
	jp	z,.361		;[0A70Fh]
	cp	30h		;'0'
	jr	z,.362		;[0A5C3h]
	cp	32h		;'2'
	jr	c,.363		;[0A609h]
	jp	z,.364		;[0A6E8h]
	sub	36h		;'6'
	ret	c
	ld	(ix),c
	ld	(ix+1),b
.512:	set	6,(ix+0Bh)
	ld	(ix+0Eh),0
	ld	(ix+0Dh),0
	ld	(ix+16h),18h
.365	equ	$-2
	bit	6,(iy-1)
	jr	nz,.368		;[0A5BDh]
	or	a
	jr	z,.367		;[0A5BAh]
	add	a,a
	add	a,a
	ld	(ix+0Ch),a
	jr	.368		;[0A5BDh]
.367:	inc	(ix+0Ch)
.368:	ld	a,6
	call	S8787		;[8787h]
	ret
.362:	set	1,(ix+0Eh)
	ret
.360:	bit	0,(iy+12h)
	ret	z
	ld	de,43AEh
	call	SA863		;[0A863h]
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SA5D3:	ld	e,a
	ld	a,(hl)
	sub	1Dh
.369:	sub	3
	cp	3
	jr	nc,.369		;[0A5D7h]
	cp	e
	jr	c,.370		;[0A5E4h]
	ld	a,(hl)
	sub	e
	ld	(hl),a
	ret
.370:	ld	(hl),0
	ret
.358:	ld	a,(B849E)	;[849Eh]
	and	88h		;'à'
	ret	nz
	bit	3,(ix+0Bh)
	ret	nz
	dec	(ix+8)
	set	3,(ix+0Bh)
	ld	(W849A),hl	;[849Ah]
	ld	(W849C),hl	;[849Ch]
	ld	(iy+1Fh),0FDh	;'˝'
	ld	a,0Eh
	call	S8787		;[8787h]
	ret
.363:	set	7,(iy+3Ah)
	ld	(W84B4),ix	;[84B4h]
	ld	a,(ix+14h)
	and	3Fh		;'?'
	jr	nz,.371		;[0A633h]
	ld	a,(ix+9)
	or	a
	jr	z,.372		;[0A62Bh]
	bit	5,(ix+0Bh)
	jr	nz,.372		;[0A62Bh]
	dec	(ix+9)
	set	5,(ix+0Bh)
.372:	call	SA6D6		;[0A6D6h]
	ld	d,99h		;'ô'
	jp	SB86D		;[0B86Dh]
.371:	call	SB4E1		;[0B4E1h]
	and	7
	cp	6
	jr	nc,.371		;[0A633h]
	inc	a
	ld	b,a
	ld	e,40h		;'@'
.373:	rlc	e
	djnz	.373		;[0A640h]
.374:	rlc	e
	ld	a,(ix+14h)
	and	e
	jr	z,.374		;[0A644h]
	xor	(ix+14h)
	ld	(ix+14h),a
	call	SB63C		;[0B63Ch]
	jr	SA6D6		;[0A6D6h]
.359:	cp	13h
	jr	nz,.375		;[0A66Ch]
	bit	6,(iy-1)
	jr	z,SA6D6		;[0A6D6h]
	ld	a,(ix+0Ch)
	add	a,1
	daa
	ld	(ix+0Ch),a
	jr	SA6D6		;[0A6D6h]
.375:	cp	16h
	jr	nc,.376		;[0A678h]
	ld	de,100h
	call	SB823		;[0B823h]
	jr	SA6D6		;[0A6D6h]
.376:	cp	18h
	jr	nc,.377		;[0A68Eh]
.383:	call	SA730		;[0A730h]
	ret	nc
	bit	4,(ix+0Bh)
	ret	nz
	inc	(ix+9)
	set	4,(ix+0Bh)
	jr	SA6D6		;[0A6D6h]
.377:	jr	nz,.378		;[0A69Bh]
	ld	(ix+0Ah),8Ch	;'å'
	ld	a,4
	call	S8787		;[8787h]
	jr	.379		;[0A6E1h]
.378:	cp	1Fh
	jr	nz,.380		;[0A6B6h]
	call	SA730		;[0A730h]
	ret	nc
	bit	2,(ix+0Bh)
	ret	nz
	inc	(ix+8)
	set	2,(ix+0Bh)
	ld	a,7
	call	S8787		;[8787h]
	jr	.381		;[0A6DBh]
.380:	ld	e,80h		;'Ä'
	sub	18h
.382:	rlc	e
	dec	a
	jr	nz,.382		;[0A6BAh]
	ld	a,e
	and	(ix+14h)
	jr	nz,.383		;[0A67Ch]
	ld	a,e
	ld	(iy+3Ah),a
	ld	(W84B4),ix	;[84B4h]
	or	(ix+14h)
	ld	(ix+14h),a
	call	SB63C		;[0B63Ch]
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SA6D6:	ld	a,11h
	call	S8787		;[8787h]
.381:	ld	de,100h
	call	SB841		;[0B841h]
.379:	ld	(hl),0
	ld	(iy+39h),0
	ret
.364:	ex	de,hl
	ld	hl,5BE8h
	ld	b,(iy+41h)
.386:	ld	a,(hl)
	inc	l
	cp	e
	jr	nz,.384		;[0A6F8h]
	ld	a,(hl)
	cp	d
	jr	z,.385		;[0A6FCh]
.384:	inc	l
	inc	l
	djnz	.386		;[0A6EFh]
.385:	inc	l
	ld	a,lx
	and	20h		;' '
	ld	a,(hl)
	ex	de,hl
	jr	z,.387		;[0A70Ah]
	ld	(B84C1),a	;[84C1h]
	jr	SA6D6		;[0A6D6h]
.387:	ld	(B84C2),a	;[84C2h]
	jr	SA6D6		;[0A6D6h]
.361:	ld	a,9
	call	S8787		;[8787h]
	push	bc
	exx
	ld	c,0
	exx
	ld	hl,8000h
.389:	ld	a,(hl)
	cp	2Fh		;'/'
	jr	nz,.388		;[0A723h]
	ld	(hl),0
.388:	cp	80h		;'Ä'
	call	nc,S9C92	;[9C92h]
	inc	hl
	ld	a,h
	cp	84h		;'Ñ'
	jr	nz,.389		;[0A71Ch]
	pop	bc
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SA730:	ld	a,(ix+8)
	add	a,(ix+9)
	bit	1,(ix+14h)
	jr	nz,.390		;[0A73Fh]
	cp	0Ah
	ret
.390:	cp	0Fh
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SA742:	inc	c
	inc	c
	res	7,c
	call	SA823		;[0A823h]
	jr	c,.391		;[0A760h]
	bit	1,c
	ret	z
	call	S9D58		;[9D58h]
	call	SA7E6		;[0A7E6h]
	jr	c,.391		;[0A760h]
	bit	1,b
	ret	z
	call	S9D68		;[9D68h]
	call	SA7E6		;[0A7E6h]
	ret	nc
.391:	dec	c
	dec	c
	res	7,c
	ld	(ix+1Dh),0
	res	3,e
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SA76B:	dec	c
	dec	c
	res	7,c
	call	SA823		;[0A823h]
	jr	c,.392		;[0A789h]
	bit	1,c
	ret	z
	call	S9D7C		;[9D7Ch]
	call	SA7E6		;[0A7E6h]
	jr	c,.392		;[0A789h]
	bit	1,b
	ret	z
	call	S9D68		;[9D68h]
	call	SA7E6		;[0A7E6h]
	ret	nc
.392:	inc	c
	inc	c
	res	7,c
	ld	(ix+1Dh),0
	res	2,e
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SA794:	inc	b
	inc	b
	res	7,b
	call	SA843		;[0A843h]
	jr	c,.393		;[0A7B2h]
	bit	1,b
	ret	z
	call	S9D68		;[9D68h]
	call	SA7E6		;[0A7E6h]
	jr	c,.393		;[0A7B2h]
	bit	1,c
	ret	z
	call	S9D58		;[9D58h]
	call	SA7E6		;[0A7E6h]
	ret	nc
.393:	dec	b
	dec	b
	res	7,b
	ld	(ix+1Dh),0
	res	1,e
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SA7BD:	dec	b
	dec	b
	res	7,b
	call	SA843		;[0A843h]
	jr	c,.394		;[0A7DBh]
	bit	1,b
	ret	z
	call	S9D43		;[9D43h]
	call	SA7E6		;[0A7E6h]
	jr	c,.394		;[0A7DBh]
	bit	1,c
	ret	z
	call	S9D58		;[9D58h]
	call	SA7E6		;[0A7E6h]
	ret	nc
.394:	inc	b
	inc	b
	res	7,b
	ld	(ix+1Dh),0
	res	0,e
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SA7E6:	ld	a,(hl)
	and	7Fh		;''
	ret	z
	cp	11h
	ret	c
	cp	13h
	jr	nc,.395		;[0A7FBh]
	ld	a,(ix+8)
	sub	1
	ret	c
	ld	a,12h
	jr	.396		;[0A818h]
.395:	cp	20h		;' '
	jr	c,.396		;[0A818h]
	cp	2Fh		;'/'
	jr	nc,.397		;[0A811h]
	bit	5,(ix+14h)
	jr	nz,.396		;[0A818h]
	bit	3,(ix+15h)
	jr	nz,.396		;[0A818h]
	scf
	ret
.397:	cp	33h		;'3'
	jr	c,.396		;[0A818h]
	cp	36h		;'6'
	ret	c
.396:	ld	(ix+1Eh),lx
	ld	(ix+1Fh),hx
	ld	(ix+1Dh),a
	and	a
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SA823:	ld	a,lx
	and	20h		;' '
	jr	nz,.398		;[0A839h]
	bit	7,(iy-54h)
	ret	nz
	ld	a,(T8420)	;[8420h]
.399:	sub	c
	call	SAC46		;[0AC46h]
	cp	3Dh		;'='
	ccf
	ret
.398:	bit	7,(iy-34h)
	ret	nz
	ld	a,(T8440)	;[8440h]
	jr	.399		;[0A831h]
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SA843:	ld	a,lx
	and	20h		;' '
	jr	nz,.400		;[0A859h]
	bit	7,(iy-54h)
	ret	nz
	ld	a,(B8421)	;[8421h]
.401:	sub	b
	call	SAC46		;[0AC46h]
	cp	23h		;'#'
	ccf
	ret
.400:	bit	7,(iy-34h)
	ret	nz
	ld	a,(B8441)	;[8441h]
	jr	.401		;[0A851h]
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SA863:	ld	a,(ix+15h)
	rra
	and	6
	bit	5,(ix+14h)
	jr	z,.402		;[0A871h]
	add	a,4
.402:	add	a,e
	ld	e,a
	ld	a,(de)
	srl	a
	ret	nc
	bit	1,(iy+12h)
	ret	z
	inc	a
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SA87E:	ld	d,b
	push	de
	ld	de,4
	ld	hl,5C00h
	dec	c
	dec	c
	dec	c
	res	7,c
	ld	a,b
	sub	3
	and	7Fh		;''
	ld	(BA8B8),a	;[0A8B8h]
	ld	a,(B8496)	;[8496h]
	or	a
	jr	z,.407		;[0A8A4h]
	ld	b,a
.405:	ld	a,(hl)
	sub	c
	and	78h		;'x'
	jr	z,.404		;[0A8ACh]
.406:	add	hl,de
	djnz	.405		;[0A89Ah]
	and	a
.407:	pop	de
	ld	b,d
	inc	c
	inc	c
	inc	c
	res	7,c
	ret
.404:	ld	a,(hl)
	sub	c
	and	7Fh		;''
	cp	7
	jr	z,.406		;[0A8A0h]
	inc	l
	ld	a,(hl)
	dec	l
	sub	0
BA8B8	equ	$-1
	jr	c,.406		;[0A8A0h]
	cp	7
	jr	nc,.406		;[0A8A0h]
	jr	.407		;[0A8A4h]
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SA8C1:	exx
	ld	de,433Ch
	exx
	ld	hl,(W84D7)	;[84D7h]
	ld	a,(T848B)	;[848Bh]
	and	3
	ld	a,11h
	jr	nz,.408		;[0A8D3h]
	dec	a
.408:	ld	(BA8E1),a	;[0A8E1h]
	ld	c,0Bh
	ld	a,(B848C)	;[848Ch]
	and	3
	jr	nz,.409		;[0A8E0h]
	dec	c
.409:	ld	b,0
BA8E1	equ	$-1
	push	hl
.416:	ld	a,(hl)
	sub	20h		;' '
	jr	c,.414		;[0A950h]
	cp	0Fh
	jr	nc,.414		;[0A950h]
	ex	af,af'
	bit	3,(iy-1)
	jr	z,.411		;[0A90Ah]
	ld	a,(hl)
	sub	1Dh
.412:	sub	3
	cp	3
	jr	nc,.412		;[0A8F6h]
	cp	(iy+24h)
	jr	nc,.413		;[0A905h]
	ld	(hl),0
	jr	.414		;[0A950h]
.413:	ld	a,(hl)
	sub	(iy+24h)
	ld	(hl),a
.411:	ld	a,(B8496)	;[8496h]
	cp	0C0h		;'¿'
	jr	nc,.414		;[0A950h]
	rra
	rra
	rra
	and	0Fh
	neg
	add	a,(iy+21h)
	ld	e,a
	call	SB4E1		;[0B4E1h]
	cp	e
	ld	e,a
	jr	nc,.414		;[0A950h]
	push	bc
	push	hl
	call	SA95D		;[0A95Dh]
	jr	nz,.415		;[0A94Eh]
	call	S9D96		;[9D96h]
	ld	c,b
	ld	b,a
	call	SA87E		;[0A87Eh]
	jr	c,.415		;[0A94Eh]
	call	SA98B		;[0A98Bh]
	jr	c,.415		;[0A94Eh]
	ld	hl,(W8494)	;[8494h]
	ld	(hl),c
	inc	l
	ld	(hl),b
	inc	l
	call	SA981		;[0A981h]
	ld	(hl),a
	inc	l
	ld	(hl),4
	inc	hl
	inc	(iy+17h)
	ld	(W8494),hl	;[8494h]
.415:	pop	hl
	pop	bc
.414:	call	S9D58		;[9D58h]
	djnz	.416		;[0A8E3h]
	pop	hl
	call	S9D68		;[9D68h]
	dec	c
	jr	nz,.409		;[0A8E0h]
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SA95D:	ld	a,e
	and	7
	ld	e,a
	add	a,18h
	exx
	ld	l,a
	ld	h,84h		;'Ñ'
	ld	a,(hl)
	exx
	ld	d,a
	rrc	d
	call	c,S9D43		;[9D43h]
	rrc	d
	call	c,S9D68		;[9D68h]
	rrc	d
	call	c,S9D7C		;[9D7Ch]
	rrc	d
	call	c,S9D58		;[9D58h]
	ld	a,(hl)
	or	a
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SA981:	exx
	ex	af,af'
	ld	l,a
	ld	h,0
	add	hl,de
	ld	a,(hl)
	exx
	or	e
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SA98B:	bit	7,(iy-54h)
	jr	nz,.417		;[0A9A8h]
	ld	a,(T8420)	;[8420h]
	add	a,3
	sub	c
	and	7Fh		;''
	cp	7
	jr	nc,.417		;[0A9A8h]
	ld	a,(B8421)	;[8421h]
	add	a,3
	sub	b
	and	7Fh		;''
	cp	7
	ret	c
.417:	bit	7,(iy-34h)
	ret	nz
	ld	a,(T8440)	;[8440h]
	add	a,3
	sub	c
	and	7Fh		;''
	cp	7
	ret	nc
	ld	a,(B8441)	;[8441h]
	add	a,3
	sub	b
	and	7Fh		;''
	cp	7
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SA9C3:	ld	a,lx
	and	20h		;' '
	jr	nz,.418		;[0A9D4h]
	bit	6,(iy-54h)
	ret	nz
	ld	de,(T8420)	;[8420h]
	jr	.419		;[0A9DDh]
.418:	bit	6,(iy-34h)
	ret	nz
	ld	de,(T8440)	;[8440h]
.419:	ld	a,e
	add	a,3
	sub	c
	and	7Fh		;''
	cp	7
	ret	nc
	ld	a,d
	add	a,3
	sub	b
	and	7Fh		;''
	cp	7
	ret	nc
	set	3,(ix+0Eh)
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SA9F4:	res	3,(iy-51h)
	ld	bc,(T8420)	;[8420h]
	ld	ix,T8440	;[8440h]
	ld	a,(B8427)	;[8427h]
	jr	.420		;[0AA14h]
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SAA05:	res	3,(iy-31h)
	ld	bc,(T8440)	;[8440h]
	ld	ix,T8420	;[8420h]
	ld	a,(B8447)	;[8447h]
.420:	bit	0,(iy+12h)
	ret	nz
	ld	e,a
	and	0Fh
	ret	z
	ld	a,(ix+7)
	and	0Fh
	ret	nz
	set	4,(ix+0Eh)
	bit	0,e
	jr	z,.421		;[0AA39h]
	ld	a,b
	sub	4
	and	7Fh		;''
	cp	(ix+1)
	jr	nz,.421		;[0AA39h]
	set	0,(ix+7)
.421:	bit	1,e
	jr	z,.422		;[0AA4Bh]
	ld	a,b
	add	a,4
	and	7Fh		;''
	cp	(ix+1)
	jr	nz,.422		;[0AA4Bh]
	set	1,(ix+7)
.422:	bit	2,e
	jr	z,.423		;[0AA5Dh]
	ld	a,c
	sub	4
	and	7Fh		;''
	cp	(ix)
	jr	nz,.423		;[0AA5Dh]
	set	2,(ix+7)
.423:	bit	3,e
	ret	z
	ld	a,c
	add	a,4
	and	7Fh		;''
	cp	(ix)
	ret	nz
	set	3,(ix+7)
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SAA6E:	exx
	ld	bc,6
	push	ix
	pop	hl
	ld	de,17h
	add	hl,de
	ex	de,hl
	ld	a,(ix+15h)
	rrca
	rrca
	rrca
	and	18h
	bit	0,(ix+14h)
	jr	z,.424		;[0AA8Ah]
	add	a,10h
.424:	ld	hl,4372h
	add	a,l
	ld	l,a
	ldir
	exx
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SAA93:	ld	hl,5B90h
	ld	de,5B91h
	ld	bc,3Fh
	ld	(hl),0FFh	;
	ldir
	call	SACC6		;[0ACC6h]
	ld	(BAC51),a	;[0AC51h]
	ld	a,(iy+17h)
	or	a
	ret	z
	ld	b,a
	ld	ix,5C00h
	ld	hl,TAAFE	;[0AAFEh]
	ld	(W873A),hl	;[873Ah]
	ld	a,0CDh		;'Õ'
	ld	(B8739),a	;[8739h]
	res	2,(iy-1)
	bit	1,(iy-1)
	jr	z,.425		;[0AAD1h]
	res	1,(iy-1)
	set	2,(iy-1)
	ld	(iy+1Ah),7
.425:	res	7,(iy-1)
	push	bc
	ld	c,(ix)
	ld	b,(ix+1)
	push	bc
	exx
	pop	bc
	push	ix
	call	S8714		;[8714h]
	pop	ix
	pop	bc
	bit	7,(iy-1)
	jr	nz,.426		;[0AAF2h]
	ld	de,4
	add	ix,de
.426:	djnz	.425		;[0AAD1h]
	sub	a
	ld	(B8739),a	;[8739h]
	ld	l,a
	ld	h,a
	ld	(W873A),hl	;[873Ah]
	ret
;::===============================::
;||      Indexed entry point      ||
;::===============================::
TAAFE:	exx
	ld	a,(ix+2)
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SAB02:	ld	e,a
	and	7
	ex	af,af'
	bit	3,(iy-1)
	call	nz,SAE5C	;[0AE5Ch]
	ld	a,lx
	rra
	rra
	xor	(iy+12h)
	rra
	jr	c,.427		;[0AB24h]
	ld	a,e
	cp	0A0h		;'†'
	jp	c,.428		;[0ABC1h]
	bit	1,(iy+12h)
	jp	z,.428		;[0ABC1h]
.427:	ld	a,r
	rra
	jr	c,.429		;[0AB62h]
	call	SAC50		;[0AC50h]
	ld	a,e
	and	0E0h		;'‡'
	cp	60h		;'`'
	jp	nz,.430		;[0AB3Fh]
	ld	a,(BAC92)	;[0AC92h]
	cp	0Ch
	jr	nc,.430		;[0AB3Fh]
	ld	a,d
	xor	4
	ld	d,a
.430:	ld	a,e
	and	0F8h		;'¯'
	ld	e,a
	ld	a,d
	ex	af,af'
	bit	5,(ix+3)
	jr	z,.431		;[0AB5Fh]
	ld	a,r
	and	3
	jr	z,.431		;[0AB5Fh]
	ld	a,d
	add	a,60h		;'`'
	ld	l,a
	ld	h,84h		;'Ñ'
	bit	4,(ix+3)
	jr	z,.432		;[0AB5Eh]
	inc	l
.432:	ld	d,(hl)
.431:	ld	a,e
	or	d
	ld	e,a
.429:	call	SACF7		;[0ACF7h]
	jr	nz,.433		;[0AB8Ch]
	call	SAD9F		;[0AD9Fh]
	jr	c,.428		;[0ABC1h]
	ld	a,(ix+1)
	ld	(BAB8B),a	;[0AB8Bh]
	ld	(ix+1),0
	call	SA87E		;[0A87Eh]
	jr	c,.434		;[0AB88h]
	ld	(ix),c
	ld	(ix+1),b
	res	5,(ix+3)
	jp	.435		;[0ABA7h]
.434:	ld	(ix+1),0
BAB8B	equ	$-1
.433:	ld	c,(ix)
	ld	b,(ix+1)
	ld	a,(ix+3)
	bit	5,a
	jr	z,.436		;[0AB9Bh]
	xor	10h
.436:	or	20h		;' '
	ld	(ix+3),a
	ld	a,e
	and	0F8h		;'¯'
	ld	e,a
	ex	af,af'
	or	e
	ld	e,a
.435:	ld	a,e
	and	0E0h		;'‡'
	cp	80h		;'Ä'
	jp	nz,.428		;[0ABC1h]
	ld	a,(ix+3)
	cp	0C0h		;'¿'
	jr	c,.437		;[0ABB8h]
	xor	8
.437:	bit	5,a
	jr	z,.438		;[0ABBEh]
	and	0F7h		;'˜'
.438:	ld	(ix+3),a
.428:	ld	a,e
	and	0E0h		;'‡'
	cp	40h		;'@'
	jr	c,.439		;[0ABCDh]
	cp	80h		;'Ä'
	call	c,SAE8E		;[0AE8Eh]
.439:	bit	2,(iy-1)
	jp	z,.440		;[0ABF1h]
	ld	a,e
	and	0E0h		;'‡'
	jr	z,.441		;[0ABE3h]
	cp	60h		;'`'
	jr	z,.441		;[0ABE3h]
	bit	5,(ix+3)
	jr	nz,.440		;[0ABF1h]
.441:	ld	a,(ix+3)
	add	a,40h		;'@'
	ld	d,a
	and	3
	jr	z,.442		;[0ABEEh]
	dec	d
.442:	ld	(ix+3),d
.440:	ld	(ix+2),e
	ld	a,e
	and	0E0h		;'‡'
	rra
	ld	c,a
	rra
	add	a,c
	ld	c,a
	ld	a,e
	and	7
	or	40h		;'@'
	add	a,c
	bit	6,(ix+3)
	jr	z,.443		;[0AC12h]
	add	a,8
	bit	7,(ix+3)
	jr	z,.443		;[0AC12h]
	add	a,8
.443:	ex	af,af'
	exx
	bit	3,(ix+3)
	ret	z
	pop	af
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SAC1B:	ld	a,c
	sub	l
	call	SAC36		;[0AC36h]
	ld	l,a
	cp	80h		;'Ä'
	jr	c,.444		;[0AC27h]
	neg
.444:	ld	d,a
	ld	a,b
	sub	h
	call	SAC36		;[0AC36h]
	ld	h,a
	cp	80h		;'Ä'
	jr	c,.445		;[0AC34h]
	neg
.445:	add	a,d
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SAC36:	cp	80h		;'Ä'
	jr	nc,.446		;[0AC40h]
	cp	40h		;'@'
	ret	c
	xor	80h		;'Ä'
	ret
.446:	cp	0C0h		;'¿'
	ret	nc
	xor	80h		;'Ä'
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SAC46:	call	SAC36		;[0AC36h]
	cp	80h		;'Ä'
	ret	c
	neg
	ccf
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SAC50:	jr	.447		;[0AC52h]
BAC51	equ	$-1
.447:	call	SB4E1		;[0B4E1h]
	ld	d,e
	dec	d
	cp	55h		;'U'
	jr	c,.448		;[0AC61h]
	inc	d
	cp	0AAh		;'™'
	jr	c,.448		;[0AC61h]
	inc	d
.448:	ld	a,d
	and	7
	ld	d,a
	ld	a,0Dh
	ld	(BAC92),a	;[0AC92h]
	ret
;::===============================::
;||   No execution path to here   ||
;::===============================::
	ld	hl,(T8440)	;[8440h]
	call	SAC1B		;[0AC1Bh]
	ld	(BAC92),a	;[0AC92h]
	jr	.450		;[0AC9Ah]
;::===============================::
;||   No execution path to here   ||
;::===============================::
	ld	hl,(T8420)	;[8420h]
	call	SAC1B		;[0AC1Bh]
	ld	(BAC92),a	;[0AC92h]
	jr	.450		;[0AC9Ah]
;::===============================::
;||   No execution path to here   ||
;::===============================::
	ld	hl,(T8420)	;[8420h]
	call	SAC1B		;[0AC1Bh]
	push	hl
	ld	(BAC92),a	;[0AC92h]
	ld	hl,(T8440)	;[8440h]
	call	SAC1B		;[0AC1Bh]
	cp	0
BAC92	equ	$-1
;::===============================::
;||      Indexed entry point      ||
;::===============================::
TAC93:	jr	nc,.451		;[0AC99h]
	ld	(BAC92),a	;[0AC92h]
	ex	(sp),hl
.451:	pop	hl
.450:	sub	a
	cp	h
	jp	nz,.452		;[0ACA7h]
	ld	d,2
	bit	7,l
	ret	nz
	ld	d,6
	ret
.452:	cp	l
	jp	nz,.453		;[0ACB3h]
	ld	d,0
	bit	7,h
	ret	z
	ld	d,4
	ret
.453:	jp	p,.454		;[0ACBEh]
	ld	d,5
	bit	7,h
	ret	nz
	ld	d,7
	ret
.454:	ld	d,3
	bit	7,h
	ret	nz
	ld	d,1
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SACC6:	ld	c,(iy-55h)
	ld	b,(iy-35h)
	bit	7,(iy-2Bh)
	jr	z,.455		;[0ACD9h]
	ld	a,c
	or	a
	ld	a,24h		;'$'
	ret	z
	sub	a
	ret
.455:	ld	a,c
	or	a
	jr	nz,.456		;[0ACF0h]
	bit	7,(iy-54h)
	jr	nz,.456		;[0ACF0h]
	ld	a,b
	or	a
	ld	a,24h		;'$'
	ret	nz
	bit	7,(iy-34h)
	ret	nz
	ld	a,2Fh		;'/'
	ret
.456:	ld	a,b
	or	a
	ld	a,19h
	ret	z
	sub	a
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SACF7:	ld	a,e
	and	7
	add	a,18h
	ld	l,a
	ld	h,84h		;'Ñ'
	ld	a,(hl)
	rra
	jr	nc,.457		;[0AD07h]
	dec	b
	dec	b
	res	7,b
.457:	rra
	jr	nc,.458		;[0AD0Eh]
	inc	b
	inc	b
	res	7,b
.458:	rra
	jr	nc,.459		;[0AD15h]
	dec	c
	dec	c
	res	7,c
.459:	rra
	jr	nc,.460		;[0AD1Ch]
	inc	c
	inc	c
	res	7,c
.460:	ld	a,b
	and	7Ch		;'|'
	add	a,a
	ld	l,a
	ld	h,0E0h		;'‡'
	add	hl,hl
	add	hl,hl
	ld	a,c
	and	7Ch		;'|'
	rra
	rra
	add	a,l
	ld	l,a
	ld	a,(hl)
	or	a
	ret	nz
	ld	a,c
	and	3
	jr	z,.461		;[0AD42h]
	inc	l
	ld	a,l
	and	1Fh
	jp	nz,.462		;[0AD3Fh]
	ld	a,l
	sub	20h		;' '
	ld	l,a
.462:	ld	a,(hl)
	or	a
	ret	nz
.461:	ld	a,b
	and	3
	ret	z
	ld	a,l
	add	a,20h		;' '
	ld	l,a
	jp	nc,.463		;[0AD56h]
	inc	h
	ld	a,h
	sub	4
	cp	80h		;'Ä'
	jr	nz,.463		;[0AD56h]
	ld	h,a
.463:	ld	a,(hl)
	or	a
	ret	nz
	ld	a,c
	and	3
	ret	z
	dec	l
	ld	a,l
	cpl
	and	1Fh
	jp	nz,.464		;[0AD69h]
	ld	a,l
	add	a,20h		;' '
	ld	l,a
.464:	ld	a,(hl)
	or	a
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SAD6C:	ld	a,b
	and	7Ch		;'|'
	add	a,a
	ld	l,a
	ld	h,0E0h		;'‡'
	add	hl,hl
	add	hl,hl
	ld	a,c
	and	7Ch		;'|'
	rra
	rra
	add	a,l
	ld	l,a
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SAD7D:	ld	hl,(W8494)	;[8494h]
	dec	hl
	ld	a,(hl)
	ld	(ix+3),a
	dec	l
	ld	a,(hl)
	ld	(ix+2),a
	dec	l
	ld	a,(hl)
	ld	(ix+1),a
	dec	l
	ld	a,(hl)
	ld	(ix),a
	ld	(W8494),hl	;[8494h]
	dec	(iy+17h)
	set	7,(iy-1)
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SAD9F:	bit	7,(iy-54h)
	jr	nz,.465		;[0ADC4h]
	ld	a,(T8420)	;[8420h]
	add	a,3
	sub	c
	and	7Fh		;''
	cp	7
	jr	nc,.465		;[0ADC4h]
	ld	a,(B8421)	;[8421h]
	add	a,3
	sub	b
	and	7Fh		;''
	cp	7
	jr	nc,.465		;[0ADC4h]
	ld	hl,T8437	;[8437h]
	ld	d,1
	jr	.466		;[0ADE4h]
.465:	bit	7,(iy-34h)
	ret	nz
	ld	a,(T8440)	;[8440h]
	add	a,3
	sub	c
	and	7Fh		;''
	cp	7
	ret	nc
	ld	a,(B8441)	;[8441h]
	add	a,3
	sub	b
	and	7Fh		;''
	cp	7
	ret	nc
	ld	hl,T8457	;[8457h]
	ld	d,0
.466:	ld	(iy+39h),0
	ld	c,(ix)
	ld	b,(ix+1)
	res	3,(ix+3)
	ld	a,e
	and	0E0h		;'‡'
	jr	nz,.467		;[0AE05h]
	call	SAE48		;[0AE48h]
	sub	a
	call	S8787		;[8787h]
.471:	call	SAD7D		;[0AD7Dh]
TAE00	equ	$-1
	exx
	pop	af
	pop	af
	ret
.467:	res	5,(ix+3)
	cp	0A0h		;'†'
	jr	z,.468		;[0AE25h]
	ld	a,(ix+3)
	and	3
	jr	nz,.469		;[0AE23h]
	set	1,(ix+3)
	ld	a,0Ah
	call	S8787		;[8787h]
	inc	hl
	inc	hl
	inc	hl
	call	SAE48		;[0AE48h]
.469:	scf
	ret
.468:	ld	a,lx
	rra
	ld	hl,5B60h
	add	a,l
	ld	l,a
	bit	0,d
	jr	z,.470		;[0AE32h]
	inc	l
.470:	ld	a,(hl)
	add	a,4
	ld	(hl),a
	cp	0C8h		;'»'
	jr	nc,.471		;[0ADFEh]
	bit	0,d
	ld	d,4
	call	SB871		;[0B871h]
	ld	a,2
	call	S8787		;[8787h]
	scf
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SAE48:	bit	3,(ix+2)
	jr	nz,.472		;[0AE55h]
	bit	4,(ix+2)
	jr	z,.473		;[0AE56h]
	inc	hl
.472:	inc	hl
.473:	bit	0,d
	ld	d,(hl)
	jp	SB871		;[0B871h]
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SAE5C:	ld	a,e
	cp	0A0h		;'†'
	jr	c,.474		;[0AE71h]
	ld	a,(B84B2)	;[84B2h]
	add	a,1
	daa
	ld	(B84B2),a	;[84B2h]
.476:	call	SAD7D		;[0AD7Dh]
	pop	af
	exx
	pop	af
	ret
.474:	ld	a,(B84A2)	;[84A2h]
	add	a,1
	daa
	ld	(B84A2),a	;[84A2h]
	ld	a,e
	ld	d,(iy+25h)
	cp	20h		;' '
	jr	c,.475		;[0AE85h]
	ld	d,(iy+26h)
.475:	and	18h
	sub	d
	jr	c,.476		;[0AE6Ah]
	ld	a,e
	sub	d
	ld	e,a
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SAE8E:	bit	4,(iy+29h)
	ret	nz
	cp	60h		;'`'
	jp	z,.477		;[0AF61h]
	ld	l,0
	ld	a,e
	and	3
	jr	z,.478		;[0AEE6h]
	cp	2
	jr	z,.479		;[0AF18h]
	bit	7,(iy-54h)
	jr	nz,.480		;[0AEC6h]
	ld	a,(T8420)	;[8420h]
	sub	c
	call	SAC46		;[0AC46h]
	ld	h,a
	ld	a,(B8421)	;[8421h]
	sub	b
	call	SAC46		;[0AC46h]
	sub	h
	add	a,2
	cp	5
	jr	nc,.480		;[0AEC6h]
	sub	2
	add	a,h
	add	a,h
	jp	.487		;[0AF4Ah]
.480:	bit	7,(iy-34h)
	ret	nz
	ld	a,(T8440)	;[8440h]
	sub	c
	call	SAC46		;[0AC46h]
	ld	h,a
	ld	a,(B8441)	;[8441h]
	sub	b
	call	SAC46		;[0AC46h]
	sub	h
	add	a,2
	cp	5
	ret	nc
	sub	2
	add	a,h
	add	a,h
	jr	.485		;[0AF48h]
.478:	bit	7,(iy-54h)
	jr	nz,.483		;[0AF00h]
	ld	a,(T8420)	;[8420h]
	sub	c
	call	SAC46		;[0AC46h]
	cp	3
	jr	nc,.483		;[0AF00h]
	ld	a,(B8421)	;[8421h]
	sub	b
	call	SAC46		;[0AC46h]
	jr	.487		;[0AF4Ah]
.483:	bit	7,(iy-34h)
	ret	nz
	ld	a,(T8440)	;[8440h]
	sub	c
	call	SAC46		;[0AC46h]
	cp	3
	ret	nc
	ld	a,(B8441)	;[8441h]
	sub	b
	call	SAC46		;[0AC46h]
	jr	.485		;[0AF48h]
.479:	bit	7,(iy-54h)
	jr	nz,.486		;[0AF32h]
	ld	a,(B8421)	;[8421h]
	sub	b
	call	SAC46		;[0AC46h]
	cp	3
	jr	nc,.486		;[0AF32h]
	ld	a,(T8420)	;[8420h]
	sub	c
	call	SAC46		;[0AC46h]
	jr	.487		;[0AF4Ah]
.486:	bit	7,(iy-34h)
	ret	nz
	ld	a,(B8441)	;[8441h]
	sub	b
	call	SAC46		;[0AC46h]
	cp	3
	ret	nc
	ld	a,(T8440)	;[8440h]
	sub	c
	call	SAC46		;[0AC46h]
.485:	set	5,l
.487:	ld	a,e
	and	7
	add	a,a
	add	a,a
	add	a,90h		;'ê'
	add	a,l
	ld	l,a
	ld	h,5Bh		;'['
	cp	(hl)
	ret	nc
	ld	(hl),a
	inc	l
	ld	(hl),c
	dec	(hl)
	inc	l
	ld	(hl),b
	dec	(hl)
	inc	l
	ld	(hl),e
	ret
.477:	ld	a,r
	cp	7
	ret	nc
	rra
	jr	c,.488		;[0AF77h]
	bit	7,(iy-54h)
	ret	nz
	ld	hl,(T8420)	;[8420h]
	ld	a,(B842A)	;[842Ah]
	or	a
	jr	z,.489		;[0AF84h]
.488:	bit	7,(iy-34h)
	ret	nz
	ld	hl,(T8440)	;[8440h]
	ld	a,(B844A)	;[844Ah]
	or	a
	ret	nz
.489:	ld	(iy+2Ch),0
	ld	a,l
	sub	c
	call	SAC46		;[0AC46h]
	jr	c,.490		;[0AF93h]
	set	3,(iy+2Ch)
.490:	add	a,a
	ld	l,a
	ld	a,h
	sub	b
	call	SAC46		;[0AC46h]
	jr	c,.491		;[0AFA0h]
	set	7,(iy+2Ch)
.491:	add	a,a
	ld	h,a
	cp	l
	jr	nc,.492		;[0AFAAh]
	call	SAFD6		;[0AFD6h]
	jr	.493		;[0AFB2h]
.492:	ld	h,l
	ld	l,a
	call	SAFD6		;[0AFD6h]
	ld	a,h
	ld	h,d
	ld	d,a
.493:	ld	a,h
	add	a,a
	add	a,a
	add	a,a
	add	a,a
	or	d
	or	(iy+2Ch)
	ld	d,a
	ld	a,l
	or	0C0h		;'¿'
	ld	hl,(W84A9)	;[84A9h]
	ld	(hl),c
	inc	l
	ld	(hl),b
	dec	(hl)
	inc	l
	ld	(hl),d
	inc	l
	ld	(hl),a
	inc	l
	ld	(W84A9),hl	;[84A9h]
	inc	(iy+29h)
	ld	a,0Ch
	jp	S8787		;[8787h]
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SAFD6:	ld	a,l
	dec	a
	rrca
	rrca
	rrca
	rrca
	inc	a
	and	7
	jr	z,.494		;[0AFFCh]
	ld	d,a
	srl	a
	add	a,l
	ld	l,0FFh		;
.495:	inc	l
	sub	d
	jr	nc,.495		;[0AFE7h]
	bit	4,l
	jr	z,.496		;[0AFF1h]
	ld	l,0Fh
.496:	ld	a,l
	srl	a
	add	a,h
	ld	h,0FFh		;
.497:	inc	h
	sub	l
	jr	nc,.497		;[0AFF7h]
	ret
.494:	pop	af
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SAFFE:	ld	a,(iy+17h)
	or	a
	ret	z
	ld	b,a
	ld	a,(T848B)	;[848Bh]
	add	a,20h		;' '
	ld	e,a
	ld	a,(B848C)	;[848Ch]
	add	a,14h
	ld	d,a
	ld	hl,5C00h
	ld	c,5
.499:	ld	a,(hl)
	inc	l
	sub	e
	call	SAC46		;[0AC46h]
	cp	38h		;'8'
	jr	nc,.498		;[0B02Eh]
	ld	a,(hl)
	sub	d
	call	SAC46		;[0AC46h]
	cp	32h		;'2'
	jr	nc,.498		;[0B02Eh]
	inc	l
	inc	l
.500:	inc	hl
.501:	djnz	.499		;[0B015h]
	ret
.498:	inc	l
	inc	l
	bit	2,(hl)
	jr	z,.500		;[0B02Ah]
	push	de
	ld	de,(W8494)	;[8494h]
	dec	de
	ld	a,(de)
	ld	(hl),a
	dec	e
	dec	l
	ld	a,(de)
	ld	(hl),a
	dec	e
	dec	l
	ld	a,(de)
	ld	(hl),a
	dec	e
	dec	l
	ld	a,(de)
	ld	(hl),a
	ld	(W8494),de	;[8494h]
	pop	de
	dec	(iy+17h)
	dec	b
	ret	z
	dec	c
	jr	nz,.501		;[0B02Bh]
	ret
;::===============================::
;||   No execution path to here   ||
;::===============================::
	cp	30h		;'0'
	ret	nz
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SB059:	bit	1,(iy-51h)
	jr	nz,.502		;[0B064h]
	bit	1,(iy-31h)
	ret	z
.502:	bit	3,(iy+2Dh)
	ret	nz
	ex	af,af'
	push	af
	push	bc
	push	de
	push	hl
	ld	d,h
	ld	e,l
	call	S9D90		;[9D90h]
	ex	de,hl
	push	bc
	call	SB1B6		;[0B1B6h]
	pop	bc
	ld	hl,(W84AD)	;[84ADh]
	ld	(hl),c
	inc	l
	ld	(hl),b
	inc	l
	ex	af,af'
	ld	(hl),a
	or	a
	jr	z,.503		;[0B08Dh]
	inc	l
	inc	l
	ld	(W84AD),hl	;[84ADh]
	inc	(iy+2Dh)
.503:	pop	hl
	pop	de
	pop	bc
	pop	af
	ex	af,af'
	ld	a,30h		;'0'
	ret
.342:	bit	1,(ix+0Eh)
	ret	z
	bit	2,(ix+0Eh)
	jr	nz,.504		;[0B11Dh]
	ld	a,(B84AC)	;[84ACh]
	or	a
	jr	z,.505		;[0B118h]
	push	ix
	call	SB146		;[0B146h]
	ld	ix,5B00h
	ld	a,(iy+31h)
	or	a
	jr	z,.506		;[0B116h]
	ld	c,a
	dec	a
	jr	z,.507		;[0B0CCh]
.508:	call	SB4E1		;[0B4E1h]
	and	7
	cp	c
	jr	nc,.508		;[0B0B9h]
	or	a
	jr	z,.507		;[0B0CCh]
	ld	de,4
.509:	add	ix,de
	dec	a
	jr	nz,.509		;[0B0C7h]
.507:	ld	c,(ix)
	ld	b,(ix+1)
	ld	e,(ix+2)
	pop	ix
	call	SAD6C		;[0AD6Ch]
	ld	a,(ix+0Dh)
	and	7
	ld	c,80h
	jr	z,.510		;[0B0E8h]
.511:	rlc	c
	dec	a
	jr	nz,.511		;[0B0E3h]
.510:	rlc	c
	ld	a,e
	and	c
	jr	z,.510		;[0B0E8h]
	call	SB215		;[0B215h]
	ld	e,(hl)
	call	S9D90		;[9D90h]
	call	SA823		;[0A823h]
	jr	c,.505		;[0B118h]
	call	SA843		;[0A843h]
	jr	c,.505		;[0B118h]
	ld	(ix+1Dh),e
	ld	(ix),c
	ld	(ix+1),b
	set	2,(ix+0Eh)
	ld	(ix+16h),4
	ld	a,0Bh
	call	S8787		;[8787h]
	ret
.506:	pop	ix
.505:	res	1,(ix+0Eh)
	ret
.504:	dec	(ix+16h)
	ret	nz
	res	2,(ix+0Eh)
	res	1,(ix+0Eh)
	ld	c,(ix)
	ld	b,(ix+1)
	call	SB13B		;[0B13Bh]
	ld	a,(ix+1Dh)
	sub	36h		;'6'
	ret	nz
	jp	.512		;[0A59Ah]
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SB13B:	call	SA87E		;[0A87Eh]
	ret	nc
	inc	l
	inc	l
	call	SA554		;[0A554h]
	jr	SB13B		;[0B13Bh]
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SB146:	ld	(iy+31h),0
	ex	af,af'
	ld	lx,(ix+1Eh)
	ld	hx,(ix+1Fh)
	call	S9D90		;[9D90h]
	ld	(iy+30h),0FFh	;
	ld	h,84h		;'Ñ'
	ld	de,5BD0h
.516:	ld	a,(de)
	sub	c
	call	SAC46		;[0AC46h]
	srl	a
	srl	a
	add	a,69h		;'i'
	ld	l,a
	ld	a,(hl)
	push	af
	inc	e
	ld	a,(de)
	sub	b
	call	SAC46		;[0AC46h]
	srl	a
	srl	a
	add	a,69h		;'i'
	ld	l,a
	pop	af
	add	a,(hl)
	jr	c,.513		;[0B1ADh]
	jr	z,.513		;[0B1ADh]
	cp	(iy+30h)
	jr	nz,.514		;[0B190h]
	inc	(iy+31h)
	inc	ix
	inc	ix
	inc	ix
	inc	ix
	jr	.515		;[0B19Dh]
.514:	jr	nc,.513		;[0B1ADh]
	ld	(iy+30h),a
	ld	ix,5B00h
	ld	(iy+31h),1
.515:	dec	e
	ld	a,(de)
	ld	(ix),a
	inc	e
	ld	a,(de)
	ld	(ix+1),a
	inc	e
	ld	a,(de)
	ld	(ix+2),a
	dec	e
.513:	inc	e
	inc	e
	inc	e
	ex	af,af'
	dec	a
	ret	z
	ex	af,af'
	jr	.516		;[0B15Dh]
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SB1B6:	call	S9D3D		;[9D3Dh]
	call	SB1E3		;[0B1E3h]
	call	S9D52		;[9D52h]
	call	SB1E3		;[0B1E3h]
	call	S9D62		;[9D62h]
	call	SB1E3		;[0B1E3h]
	call	S9D62		;[9D62h]
	call	SB1E3		;[0B1E3h]
	call	S9D76		;[9D76h]
	call	SB1E3		;[0B1E3h]
	call	S9D76		;[9D76h]
	call	SB1E3		;[0B1E3h]
	call	S9D3D		;[9D3Dh]
	call	SB1E3		;[0B1E3h]
	call	S9D3D		;[9D3Dh]
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SB1E3:	ld	a,(hl)
	cp	36h		;'6'
BB1E5	equ	$-1
	jr	z,.517		;[0B20Bh]
	or	a
	jr	nz,.518		;[0B210h]
	ld	de,(T8420)	;[8420h]
	bit	6,(iy-54h)
	call	z,SB246		;[0B246h]
	jr	c,.518		;[0B210h]
	ld	de,(T8440)	;[8440h]
	bit	6,(iy-34h)
	call	z,SB246		;[0B246h]
	jr	c,.518		;[0B210h]
	ld	a,(BB1E5)	;[0B1E5h]
	rla
	jr	c,.517		;[0B20Bh]
.517:	ex	af,af'
	scf
	rra
	ex	af,af'
	ret
.518:	ex	af,af'
	and	a
	rra
	ex	af,af'
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SB215:	rrca
	jp	c,S9D43		;[9D43h]
	rrca
	jr	nc,.519		;[0B222h]
	call	S9D43		;[9D43h]
	jp	S9D58		;[9D58h]
.519:	rrca
	jp	c,S9D58		;[9D58h]
	rrca
	jr	nc,.520		;[0B22Fh]
	call	S9D68		;[9D68h]
	jp	S9D58		;[9D58h]
.520:	rrca
	jp	c,S9D68		;[9D68h]
	rrca
	jr	nc,.521		;[0B23Ch]
	call	S9D68		;[9D68h]
	jp	S9D7C		;[9D7Ch]
.521:	rrca
	jp	c,S9D7C		;[9D7Ch]
	call	S9D43		;[9D43h]
	jp	S9D7C		;[9D7Ch]
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SB246:	ld	a,e
	add	a,3
	sub	c
	and	7Fh		;''
	cp	7
	ret	nc
	ld	a,d
	add	a,3
	sub	b
	and	7Fh		;''
	cp	7
	ret
.604:	sub	a
	ld	hl,7F1Bh
	ld	b,10h
.522:	ld	(hl),a
	inc	l
	djnz	.522		;[0B25Eh]
	ld	(B84C8),a	;[84C8h]
	ld	(B84C9),a	;[84C9h]
	inc	a
	ld	(B8403),a	;[8403h]
	ld	(B842C),a	;[842Ch]
	ld	(B844C),a	;[844Ch]
	call	SB34C		;[0B34Ch]
	call	SB4E1		;[0B4E1h]
	and	3
	add	a,2
	ld	(B84BA),a	;[84BAh]
.525:	call	SB590		;[0B590h]
	di
	call	SB2CA		;[0B2CAh]
	ld	(iy+18h),0
	ld	(iy+20h),40h	;'@'
	ei
	call	S8F81		;[8F81h]
	call	SB546		;[0B546h]
	call	S8504		;[8504h]
.523:	inc	(iy+12h)
	call	SB709		;[0B709h]
	ld	a,(iy-54h)
	or	(iy-34h)
	and	3Fh		;'?'
	jr	nz,.523		;[0B298h]
	ld	a,(B8434)	;[8434h]
	and	(iy-2Bh)
	rla
	jr	c,.524		;[0B2B3h]
	jr	.525		;[0B27Fh]
.524:	call	S979C		;[979Ch]
	ld	a,(iy-51h)
	or	(iy-31h)
	and	0FEh		;'˛'
	jr	nz,.524		;[0B2B3h]
	ld	a,(B84BB)	;[84BBh]
	ld	(B84C5),a	;[84C5h]
	di
	jp	.604		;[0B258h]
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SB2CA:	sub	a
	ld	(B84B8),a	;[84B8h]
	ld	(B847E),a	;[847Eh]
	ld	(B847D),a	;[847Dh]
	ld	(B84C0),a	;[84C0h]
	call	S94E7		;[94E7h]
	call	S9AF6		;[9AF6h]
	ld	c,2
	ld	b,26h		;'&'
	call	SB342		;[0B342h]
	ld	(iy+21h),b
	ld	c,0Ch
	ld	b,5
	call	SB342		;[0B342h]
	ld	(iy+3Fh),b
	ld	c,2
	ld	b,19h
	call	SB342		;[0B342h]
	ld	(iy+40h),b
	ld	c,1
	ld	b,0B4h		;'¥'
	call	SB342		;[0B342h]
	ld	(iy+3Eh),b
	ld	bc,(W8492)	;[8492h]
	ld	ix,T8420	;[8420h]
	call	S9A2D		;[9A2Dh]
	ld	ix,T8440	;[8440h]
	call	S9A2D		;[9A2Dh]
	call	SA2D9		;[0A2D9h]
	ld	hl,0
	ld	(T8420),hl	;[8420h]
	ld	(T8440),hl	;[8440h]
.527:	ld	hl,(T848B)	;[848Bh]
	push	hl
	call	SB4F8		;[0B4F8h]
	pop	hl
	ld	de,(T848B)	;[848Bh]
	and	a
	sbc	hl,de
	jr	nz,.527		;[0B323h]
	ld	ix,T8420	;[8420h]
	call	S99C1		;[99C1h]
	ld	ix,T8440	;[8440h]
	jp	S99C1		;[99C1h]
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SB342:	ld	a,(B8403)	;[8403h]
.528:	sub	c
	ret	c
	inc	b
	jr	nz,.528		;[0B345h]
	dec	b
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SB34C:	ei
	call	SB590		;[0B590h]
	di
	ld	(iy+18h),0
	call	SB5F4		;[0B5F4h]
	ei
.531:	call	S8B44		;[8B44h]
.530:	call	S979C		;[979Ch]
	ld	a,(B8434)	;[8434h]
	and	(iy-2Bh)
	rla
	jr	nc,.529		;[0B370h]
	ld	a,(B8497)	;[8497h]
	or	a
	jr	nz,.530		;[0B35Ch]
	jr	.531		;[0B359h]
.529:	ld	de,0
	ld	b,0
	call	SB5D9		;[0B5D9h]
	ld	de,2000h
	ld	b,0F0h		;''
	call	SB5D9		;[0B5D9h]
	bit	7,(iy+4Dh)
	ret	nz
	ld	a,(0FFA7h)
	cp	0C9h		;'…'
	ret	nz
	ld	a,8
	out	(0ABh),a	;Unknown port
	ld	ix,TB3AF	;[0B3AFh]
	ld	de,600h
	call	S8EA0		;[8EA0h]
	ld	de,800h
	call	S8EA0		;[8EA0h]
	ld	de,0A00h
	call	S8EA0		;[8EA0h]
.532:   call    SCANJOY           ;[0B40Bh]
	bit	0,(iy+8)
	jr	nz,.532		;[0B3A5h]
	ret
;::===============================::
;||      Indexed entry point      ||
;::===============================::
TB3AF:	inc	d
	ld	d,e
	ld	b,l
	ld	d,h
	jr	nz,.533		;[0B409h]
	ld	c,b
	ld	b,l
	jr	nz,.534		;[0B40Dh]
	ld	b,c
	ld	d,b
	ld	b,l
	jr	nz,.535		;[0B412h]
	ld	c,a
	jr	nz,.536		;[0B415h]
	ld	c,b
	ld	b,l
	jr	nz,.537		;[0B3D9h]
	ld	d,e
	ld	d,h
	ld	b,c
	ld	d,d
	ld	d,h
	jr	nz,.538		;[0B41Bh]
	ld	b,(hl)
	jr	nz,.539		;[0B41Ch]
	ld	b,c
	ld	e,d
	ld	b,l
	jr	nz,.540		;[0B41Ah]
	ld	c,c
	ld	c,h
	ld	b,l
	ld	d,e
	jr	nz,.541		;[0B3EEh]
.537	equ	$-1
	ld	b,c
	ld	c,(hl)
	ld	b,h
	jr	nz,.542		;[0B42Fh]
	ld	d,d
	ld	b,l
	ld	d,e
	ld	d,e
	jr	nz,.543		;[0B438h]
	ld	d,b
	ld	b,c
	ld	b,e
	ld	b,l
	jr	nz,.544		;[0B436h]
	ld	b,l
	ld	e,c
        jr      nz,WRTPSG        ;[0B3EFh]
.541	equ	$-1
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
WRTPSG:  di
	out	(0A0h),a	;PSG address
	push	af
	ld	a,e
	ei
	out	(0A1h),a	;write PSG register
	pop	af
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
RDPSG:  out     (0A0h),a        ;PSG address
	in	a,(0A2h)	;read PSG register
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SNSMAT: ld      c,a             ;0B3FE
	di
	in	a,(0AAh)	;PPI port C (misc ctrl)
	and	0F0h		;''
	add	a,c
	out	(0AAh),a	;PPI port C (misc ctrl)
	ei
	in	a,(0A9h)	;Keyboard row scan
.533	equ	$-1
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SCANJOY:  ld      de,ROWTABLE        ;[847Fh]
.534	equ	$-1
	ld	b,9
.545:	ld	a,9
.535:	sub	b
        call    SNSMAT           ;[0B3FEh]
.536	equ	$-1
	ld	(de),a
	inc	e
	djnz	.545		;[0B410h]
.540:	ld	a,0Fh
.538	equ	$-1
.539:	ld	e,8Fh		;'è'
        call    WRTPSG           ;[0B3EFh]
	ld	a,0Eh
        call    RDPSG           ;[0B3F9h]
	cpl
	and	1Fh
	ld	(B8427),a	;[8427h]
	ld	a,0Fh
	ld	e,0CFh		;'œ'
.542	equ	$-1
        call    WRTPSG           ;[0B3EFh]
	ld	a,0Eh
        call    RDPSG           ;[0B3F9h]
.544	equ	$-2
.543:	cpl
	and	1Fh
	ld	(B8447),a	;[8447h]
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SB43F:	call	SB444		;[0B444h]
	ei
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SB444:	di
	ld	a,e
	out	(99h),a		;VDP acess
	ld	a,d
	or	40h		;'@'
	out	(99h),a		;VDP acess
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SB44E:	di
	call	SB454		;[0B454h]
	ei
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SB454:	ld	a,e
	out	(99h),a		;VDP acess
	ld	a,d
	out	(99h),a		;VDP acess
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SB45A:	ret
;::===============================::
;||      Indexed entry point      ||
;::===============================::
TB45B:	push	af
	in	a,(99h)		;VDP acess
	ld	a,(B84D5)	;[84D5h]
	or	a
	call	nz,SB468	;[0B468h]
	pop	af
	ei
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SB468:	push	bc
	push	hl
	inc	(iy+18h)
	call	S8837		;[8837h]
	ld	a,(B8499)	;[8499h]
	or	a
	jr	z,.546		;[0B47Ch]
	dec	a
	ld	(B8499),a	;[8499h]
	jr	nz,.547		;[0B480h]
.546:	set	1,(iy-1)
.547:	pop	hl
	pop	bc
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SB483:	ld	(W8489),sp	;[8489h]
	ld	b,18h
	ld	sp,0D323h
	ld	de,0
;
.548:	db	'’’’’’’’’’’’’’’’’',10h,'ÓÌ{',89h,84h,97h
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SB4A6:	ld	b,a
	ld	a,7
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SB4A9:	ld	c,99h
	or	80h		;'Ä'
	di
	out	(c),b
	out	(c),a
	ei
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SB4B4:	push	de
	ld	a,b
	add	a,2
	sub	(iy+0Dh)
	and	7Eh		;'~'
	ld	(BB4DA),a	;[0B4DAh]
	rlca
	ld	l,a
	ld	h,0
	add	hl,hl
	add	hl,hl
	add	hl,hl
	ld	de,(W84D3)	;[84D3h]
	add	hl,de
	ld	de,0FFDDh
	add	hl,de
	ld	a,c
	add	a,2
	sub	(iy+0Ch)
	and	7Eh		;'~'
	rra
	add	a,0
BB4DA	equ	$-1
	add	a,l
	ld	l,a
	pop	de
	ret	nc
	inc	h
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SB4E1:	push	hl
	push	de
	ld	hl,0D431h
WB4E4	equ	$-2
	dec	hl
	ld	a,l
	ld	d,a
	dec	l
	ld	a,h
	add	a,l
	ld	e,a
	sbc	hl,de
	ld	(WB4E4),hl	;[0B4E4h]
	ld	a,r
	sub	l
	pop	de
	pop	hl
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SB4F8:	ld	hl,T848B	;[848Bh]
	ld	a,(B848D)	;[848Dh]
	sub	22h		;'"'
	jr	nc,.549		;[0B505h]
BB502:	sub	a
	and	7Fh		;''
.549:	add	a,2
	and	7Fh		;''
	cp	42h		;'B'
	jr	c,.550		;[0B50Fh]
WB50D:	ld	a,42h		;'B'
.550:	sub	(hl)
	jr	z,.551		;[0B520h]
	and	7Fh		;''
	cp	40h		;'@'
	ld	a,(hl)
	jr	c,.552		;[0B51Bh]
	sub	4
.552:	add	a,2
	and	7Fh		;''
	ld	(hl),a
.551:	inc	hl
	ld	a,(B848E)	;[848Eh]
	sub	14h
	jr	nc,.553		;[0B52Bh]
BB528:	sub	a
	and	7Fh		;''
.553:	add	a,2
	and	7Fh		;''
	cp	5Ah		;'Z'
	jr	c,.554		;[0B535h]
WB533:	ld	a,5Ah		;'Z'
.554:	sub	(hl)
	ret	z
	and	7Fh		;''
	cp	40h		;'@'
	ld	a,(hl)
	jr	c,.555		;[0B540h]
	sub	4
.555:	add	a,2
	and	7Fh		;''
	ld	(hl),a
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SB546:	call	SB5E9		;[0B5E9h]
	ld	de,0
	call	SB444		;[0B444h]
	ld	hl,2800h
	ld	bc,98h
	call	SB585		;[0B585h]
	ld	hl,2800h
	ld	bc,98h
	call	SB585		;[0B585h]
	ld	de,2000h
	call	SB444		;[0B444h]
	ld	hl,2000h
	ld	bc,98h
	call	SB585		;[0B585h]
	ld	hl,2000h
	ld	bc,98h
	call	SB585		;[0B585h]
	ld	hl,2800h
	ld	de,TC000	;[0C000h]
	ld	bc,800h
	ldir
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SB585:	ld	a,8
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SB587:	outi
	jp	nz,SB587	;[0B587h]
	dec	a
	jr	nz,SB587	;[0B587h]
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SB590:	call	SB5E9		;[0B5E9h]
	ld	de,1800h
	call	SB43F		;[0B43Fh]
	sub	a
.557:	out	(98h),a		;VRAM access
	inc	a
	jr	nz,.557		;[0B59Ah]
.558:	out	(98h),a		;VRAM access
	inc	a
	jr	nz,.558		;[0B59Fh]
.559:	out	(98h),a		;VRAM access
	inc	a
	cp	60h		;'`'
	jr	nz,.559		;[0B5A4h]
	ld	de,0
	ld	b,0
	call	SB5D9		;[0B5D9h]
	ld	de,2000h
	ld	b,0F0h		;''
	call	SB5D9		;[0B5D9h]
	ld	b,50h		;'P'
	call	S94C4		;[94C4h]
	ld	de,1B00h
	call	SB43F		;[0B43Fh]
	ld	hl,0D330h
	ld	b,50h		;'P'
.560:	outi
	jp	nz,.560		;[0B5CBh]
	ld	a,(0F3E0h)
	ld	b,a
	ld	a,1
	jp	SB4A9		;[0B4A9h]
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SB5D9:	ld	hl,1300h
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SB5DC:	call	SB43F		;[0B43Fh]
	ld	c,98h
.561:	out	(c),b
	dec	hl
	ld	a,h
	or	l
	jr	nz,.561		;[0B5E1h]
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SB5E9:	ld	a,(0F3E0h)
	res	6,a
	ld	b,a
	ld	a,1
	jp	SB4A9		;[0B4A9h]
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SB5F4:	ld	ix,T8420	;[8420h]
	call	S980C		;[980Ch]
	ld	ix,T8440	;[8440h]
	jp	S980C		;[980Ch]
.209:	push	de
	exx
	bit	7,(ix+14h)
	jr	z,.562		;[0B618h]
	pop	af
	call	SB895		;[0B895h]
	ld	c,20h
	call	SB69E		;[0B69Eh]
	ld	c,0A0h
	jp	SB6B0		;[0B6B0h]
.562:	call	SB8AB		;[0B8ABh]
	call	SB6C1		;[0B6C1h]
	exx
	pop	de
	exx
	call	SB8C1		;[0B8C1h]
	ld	a,(hl)
	xor	0Fh
	inc	a
	srl	a
	exx
	add	a,a
	add	a,a
	add	a,a
	add	a,e
	ld	e,a
	exx
	ld	b,(hl)
.564:	inc	hl
	ld	a,(hl)
	call	SB6EB		;[0B6EBh]
	djnz	.564		;[0B632h]
	call	SB69B		;[0B69Bh]
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SB63C:	bit	0,e
	call	nz,SAA6E	;[0AA6Eh]
	ld	a,lx
	and	20h		;' '
	ld	de,3400h
	jr	nz,.565		;[0B64Dh]
	ld	de,3488h
.565:	call	SB43F		;[0B43Fh]
	ld	c,(ix+14h)
	sub	a
	rr	c
	jr	nc,.566		;[0B65Ah]
	ld	a,0A0h		;'†'
.566:	call	SB693		;[0B693h]
	sub	a
	rr	c
	jr	nc,.567		;[0B664h]
	ld	a,0D0h		;'–'
.567:	call	SB693		;[0B693h]
	sub	a
	rr	c
	jr	nc,.568		;[0B66Eh]
	ld	a,20h		;' '
.568:	call	SB693		;[0B693h]
	ld	a,e
	add	a,48h		;'H'
	ld	e,a
	call	SB43F		;[0B43Fh]
	sub	a
	rr	c
	jr	nc,.569		;[0B67Fh]
	ld	a,80h		;'Ä'
.569:	call	SB693		;[0B693h]
	sub	a
	rr	c
	jr	nc,.570		;[0B689h]
	ld	a,0E0h		;'‡'
.570:	call	SB693		;[0B693h]
	sub	a
	rr	c
	jr	nc,SB693	;[0B693h]
	ld	a,70h		;'p'
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SB693:	ld	b,8
.571:	out	(98h),a		;VRAM access
	inc	e
	djnz	.571		;[0B695h]
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SB69B:	call	SB8C1		;[0B8C1h]
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SB69E:	ld	a,lx
	and	20h		;' '
	ld	de,3400h
	jr	nz,.572		;[0B6AAh]
	ld	de,3488h
.572:	call	SB6B0		;[0B6B0h]
	call	SB6B0		;[0B6B0h]
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SB6B0:	call	SB43F		;[0B43Fh]
	ld	a,c
	ld	b,78h		;'x'
.573:	out	(98h),a		;VRAM access
	inc	e
	djnz	.573		;[0B6B6h]
	exx
	call	SB6CC		;[0B6CCh]
	exx
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SB6C1:	ld	b,0Fh
.574:	push	bc
	ld	a,20h		;' '
	call	SB6EB		;[0B6EBh]
	pop	bc
	djnz	.574		;[0B6C3h]
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SB6CC:	exx
	inc	d
	dec	e
	bit	7,e
	ld	e,0
	jr	z,.575		;[0B6D7h]
	ld	e,88h		;'à'
.575:	exx
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SB6D9:	and	0Fh
	add	a,30h		;'0'
	bit	0,c
	jr	nz,SB6EB	;[0B6EBh]
	set	0,c
	cp	30h		;'0'
	jr	nz,SB6EB	;[0B6EBh]
	ld	a,20h		;' '
	res	0,c
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SB6EB:	exx
	ld	bc,77B0h
	sub	20h		;' '
.96:	add	a,a
	ld	l,a
	ld	h,0
	add	hl,hl
	add	hl,hl
	add	hl,bc
	call	SB43F		;[0B43Fh]
	ld	bc,898h
.576:	outi
	jp	nz,.576		;[0B6FEh]
	ld	a,e
	add	a,8
	ld	e,a
	exx
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SB709:	ld	a,(B8497)	;[8497h]
	and	0C0h		;'¿'
	cp	(iy+20h)
	jr	nz,.577		;[0B73Dh]
	add	a,40h		;'@'
	ld	(B849F),a	;[849Fh]
	inc	(iy+39h)
	ld	d,1
	bit	6,(iy-54h)
	jr	nz,.578		;[0B72Dh]
	ld	hl,T8423	;[8423h]
	call	SB883		;[0B883h]
	set	0,(iy-54h)
.578:	bit	6,(iy-34h)
	jr	nz,.577		;[0B73Dh]
	ld	hl,T8443	;[8443h]
	call	SB883		;[0B883h]
	set	0,(iy-34h)
.577:	ld	ix,T8420	;[8420h]
	exx
	ld	de,1648h
	exx
	bit	1,(iy+12h)
	jr	z,.579		;[0B755h]
	ld	ix,T8440	;[8440h]
	exx
	ld	de,16D0h
	exx
.579:	bit	0,(iy+12h)
	jr	nz,.580		;[0B76Dh]
	bit	0,(ix+0Bh)
	jr	z,.581		;[0B785h]
	res	0,(ix+0Bh)
	ld	hl,T8422	;[8422h]
	ld	b,2
	jp	.583		;[0B801h]
.580:	bit	1,(ix+0Bh)
	jr	z,.581		;[0B785h]
	res	1,(ix+0Bh)
	exx
	ld	a,e
	sub	40h		;'@'
	ld	e,a
	exx
	ld	hl,T8424	;[8424h]
	ld	b,3
	jp	.583		;[0B801h]
.581:	ld	c,(ix+0Bh)
	ld	a,c
	cpl
	and	0Ch
	jr	nz,.584		;[0B792h]
	res	2,c
	res	3,c
.584:	ld	a,c
	cpl
	and	30h		;'0'
	jr	nz,.585		;[0B79Ch]
	res	4,c
	res	5,c
.585:	ld	(ix+0Bh),c
	ld	b,0A0h		;'†'
	ld	a,(ix+8)
	bit	2,(ix+0Bh)
	jr	z,.586		;[0B7B7h]
	res	2,(ix+0Bh)
	ld	c,21h
.590:	call	SB7E7		;[0B7E7h]
	ld	a,c
	jp	SB6EB		;[0B6EBh]
.586:	bit	3,(ix+0Bh)
	jr	z,.587		;[0B7C6h]
	res	3,(ix+0Bh)
	inc	a
.591:	ld	c,20h
	jr	.590		;[0B7B0h]
.587:	ld	b,70h		;'p'
	ld	a,10h
	sub	(ix+9)
	bit	4,(ix+0Bh)
	jr	z,.589		;[0B7DBh]
	res	4,(ix+0Bh)
	ld	c,22h
	jr	.590		;[0B7B0h]
.589:	bit	5,(ix+0Bh)
	ret	z
	res	5,(ix+0Bh)
	dec	a
	jr	.591		;[0B7C2h]
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SB7E7:	exx
	add	a,a
	add	a,a
	add	a,a
	add	a,e
	sub	50h		;'P'
	ld	e,a
	inc	d
	set	5,d
	call	SB43F		;[0B43Fh]
	res	5,d
	exx
	ld	a,b
	ld	b,8
.592:	out	(98h),a		;VRAM access
	nop
	djnz	.592		;[0B7FBh]
	ret
.583:	ld	c,0
	bit	1,(iy+12h)
	jr	z,.593		;[0B80Dh]
	ld	a,l
	add	a,20h		;' '
	ld	l,a
.593:	ld	a,(hl)
	rrca
	rrca
	rrca
	rrca
	call	SB6D9		;[0B6D9h]
	ld	a,b
	dec	a
	jr	nz,.594		;[0B81Bh]
	set	0,c
.594:	ld	a,(hl)
	call	SB6D9		;[0B6D9h]
	inc	hl
	djnz	.593		;[0B80Dh]
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SB823:	ld	a,(ix+3)
	add	a,e
	daa
	ld	(ix+3),a
	ld	a,(ix+2)
	adc	a,d
	daa
	ld	(ix+2),a
	set	0,(ix+0Bh)
	ret	nc
	ld	(ix+2),99h	;'ô'
	ld	(ix+3),99h	;'ô'
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SB841:	ld	a,(ix+6)
	add	a,e
	daa
	ld	(ix+6),a
	ld	a,(ix+5)
	adc	a,d
	daa
	ld	(ix+5),a
	ld	a,(ix+4)
	adc	a,0
	daa
	ld	(ix+4),a
	set	1,(ix+0Bh)
	ret	nc
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SB85F:	ld	a,lx
	and	20h		;' '
	jr	z,.595		;[0B869h]
	inc	(iy+49h)
	ret
.595:	inc	(iy+4Ah)
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SB86D:	ld	a,lx
	and	20h		;' '
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SB871:	jr	z,.596		;[0B87Ch]
	ld	hl,T8423	;[8423h]
	set	0,(iy-54h)
	jr	SB883		;[0B883h]
.596:	ld	hl,T8443	;[8443h]
	set	0,(iy-34h)
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SB883:	ld	a,(hl)
	sub	d
	daa
	ld	(hl),a
	dec	l
	ld	a,(hl)
	sbc	a,0
	daa
	ld	(hl),a
	ret	nc
	ld	(hl),0
	inc	l
	ld	(hl),0
	dec	l
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SB895:	ld	hl,43E6h
	ld	bc,0F04h
.598:	push	bc
.597:	ld	a,(hl)
	inc	hl
	call	SB6EB		;[0B6EBh]
	djnz	.597		;[0B89Ch]
	pop	bc
	call	SB6CC		;[0B6CCh]
	dec	c
	jr	nz,.598		;[0B89Bh]
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SB8AB:	ld	hl,4422h
	ld	bc,0F03h
.600:	push	bc
.599:	ld	a,(hl)
	inc	hl
	call	SB6EB		;[0B6EBh]
	djnz	.599		;[0B8B2h]
	pop	bc
	call	SB6CC		;[0B6CCh]
	dec	c
	jr	nz,.600		;[0B8B1h]
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SB8C1:	ld	a,(ix+13h)
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SB8C4:	ld	hl,444Fh
	ld	c,80h
	or	a
	ret	z
	ld	hl,4457h
	ld	c,40h
	sub	8
	ret	z
	ld	hl,4461h
	ld	c,0A0h
	sub	8
	ret	z
	ld	hl,4469h
	ld	c,20h
	ret
.2:	ld	a,(0DFFFh)
	or	a
	jr	z,.601		;[0B90Fh]
	ld	de,0F3C7h
	ld	hl,TB9FC	;[0B9FCh]
	ld	bc,0Ah
	ldir
	call	7Eh
	di
	ld	sp,0F660h
        ld      iy,ROWTABLE        ;[847Fh]
	call	SBAA4		;[0BAA4h]
	ld	a,(0FFFCh)
	out	(0A8h),a	;PSLOT register
	call	SBA8D		;[0BA8Dh]
	ld	a,(0DFFFh)
	inc	a
	call	z,0D000h
.601:	di
	ld	sp,0F660h
        ld      iy,ROWTABLE        ;[847Fh]
	ld	a,(0F3E0h)
	or	2
	ld	(0F3E0h),a
	out	(99h),a		;VDP acess
	ld	a,81h		;'Å'
	out	(99h),a		;VDP acess
	ld	de,680h
	ld	hl,TC900	;[0C900h]
	ld	bc,120h
	ldir
	ld	hl,TC000	;[0C000h]
	ld	de,328h
	ld	bc,2D8h
	ldir
	ld	hl,4000h
	ld	de,1000h
	ld	bc,3000h
	ldir
	ld	de,800h
	ld	bc,800h
	ldir
	ld	de,73DAh
	ld	bc,400h
	ldir
	ld	de,77B0h
	ld	bc,400h
	ldir
	ld	de,1A00h
	call	SB444		;[0B444h]
	ld	a,0
.602:	out	(98h),a		;VRAM access
	inc	a
	jr	nz,.602		;[0B966h]
	ld	de,3900h
	call	SB444		;[0B444h]
	ld	hl,0A00h
	ld	a,5
	ld	bc,8098h
	call	SB587		;[0B587h]
	call	SBA55		;[0BA55h]
	ld	de,3300h
	call	SB444		;[0B444h]
	ld	a,5
.603:	out	(c),e
	nop
	djnz	.603		;[0B987h]
	dec	a
	jr	nz,.603		;[0B987h]
	ld	a,(0FFFDh)
	call	SB9E6		;[0B9E6h]
	ld	(B8433),a	;[8433h]
	ld	a,c
	ld	(B8435),a	;[8435h]
	ld	a,b
	ld	(B842F),a	;[842Fh]
	ld	a,(0FFFEh)
	call	SB9E6		;[0B9E6h]
	ld	(B8453),a	;[8453h]
	ld	a,c
	ld	(B8455),a	;[8455h]
	ld	a,b
	ld	(B844F),a	;[844Fh]
	ld	de,7A0h
	ld	hl,2200h
	ld	bc,58h
	ldir
	ld	hl,TC300	;[0C300h]
	ld	de,4000h
	ld	bc,600h
	ldir
	ld	a,0C3h		;'√'
	ld	(38h),a
	ld	hl,TB45B	;[0B45Bh]
	ld	(39h),hl
	ld	a,0D0h		;'–'
	ld	(0D380h),a
	call	S94C2		;[94C2h]
	call	SBA26		;[0BA26h]
	ld	sp,TC000	;[0C000h]
	call	SB483		;[0B483h]
	jp	.604		;[0B258h]
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SB9E6:	add	a,a
	ld	e,a
	ld	d,0
	ld	hl,VB9F4	;[0B9F4h]
	add	hl,de
	ld	b,(hl)
	inc	hl
	ld	c,(hl)
	add	a,a
	add	a,a
	ret
;
VB9F4:	dw	T8E09		;[8E09h]
	dw	0D805h
.607	equ	$-1
	dw	320Bh
	dw	6403h
;::===============================::
;||      Indexed entry point      ||
;::===============================::
TB9FC:	nop
	jr	.605		;[0B9FFh]
.605:	jr	nz,.606		;[0BA01h]
.606:	nop
	nop
	dec	de
	nop
	jr	c,.607		;[0B9F7h]
TBA06	equ	$-1
	db	'p',0
;::===============================::
;||      Indexed entry point      ||
;::===============================::
TBA09:	and	b
	add	a,b
	and	b
	or	b
	and	b
	ld	(hl),b
	ld	d,b
	nop
	sub	b
	add	a,b
	sub	b
	sub	b
	sub	b
	and	b
	and	b
	and	b
	and	b
	sub	b
	sub	b
	add	a,b
	ld	h,b
	sub	b
	sub	b
	sub	b
	sub	b
	add	a,b
	add	a,b
	ld	h,b
	ld	h,b
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SBA26:	ld	de,600h
	ld	hl,28E8h
	ld	bc,18h
	ldir
	ld	hl,2A88h
	ld	c,8
	ldir
	ld	hl,20E8h
	ld	c,18h
	ldir
	ld	hl,2288h
	ld	c,8
	ldir
	ld	hl,2950h
	ld	c,20h
	ldir
	ld	hl,TBA06	;[0BA06h]
	ld	c,20h
	ldir
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SBA55:	ld	de,3D80h
	call	SB444		;[0B444h]
	ld	hl,800h
	ld	b,0Ah
.608:	push	bc
	call	SBA6F		;[0BA6Fh]
	pop	bc
	djnz	.608		;[0BA60h]
	ld	hl,TBC00	;[0BC00h]
	ld	a,4
	jp	SB587		;[0B587h]
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SBA6F:	call	SBA84		;[0BA84h]
	ld	a,l
	add	a,8
	ld	l,a
	call	SBA84		;[0BA84h]
	ld	a,l
	sub	10h
	ld	l,a
	call	SBA84		;[0BA84h]
	ld	a,l
	add	a,8
	ld	l,a
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SBA84:	ld	bc,898h
.609:	outi
	jp	nz,.609		;[0BA87h]
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SBA8D:	ld	de,0
	call	SB454		;[0B454h]
	ld	hl,4400h
	ld	a,40h		;'@'
	ld	bc,98h
.610:	ini
	jp	nz,.610		;[0BA9Bh]
	dec	a
	jr	nz,.610		;[0BA9Bh]
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SBAA4:	call	SBAF6		;[0BAF6h]
	in	a,(0A8h)	;PSLOT register
	ld	b,a
	ex	af,af'
	ld	a,b
	and	30h		;'0'
	ld	b,a
	in	a,(0A8h)	;PSLOT register
	and	0FCh		;'¸'
	dec	a
	ld	hl,0
.613:	inc	a
	out	(0A8h),a	;PSLOT register
	ld	c,a
	ld	a,(hl)
	cpl
	ld	(hl),a
	cp	(hl)
	ld	a,c
	jr	z,.611		;[0BAE9h]
	ld	e,0
.612:	ld	a,c
	rrca
	rrca
	and	0C0h		;'¿'
	or	b
	out	(0A8h),a	;PSLOT register
	ld	a,(0FFFFh)
	cpl
	and	0FCh		;'¸'
	or	e
	ld	(0FFFFh),a
	ld	a,c
	out	(0A8h),a	;PSLOT register
	ld	a,(hl)
	cpl
	ld	(hl),a
	cp	(hl)
	ld	a,c
	jr	z,.611		;[0BAE9h]
	inc	e
	ld	a,e
	cp	4
	jr	nz,.612		;[0BAC4h]
	ld	a,c
	jr	.613		;[0BAB7h]
.611:	ex	af,af'
	out	(0A8h),a	;PSLOT register
	ex	af,af'
	ld	c,a
	ld	a,(0FFFCh)
	or	c
	ld	(0FFFCh),a
	ret
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SBAF6:	in	a,(0A8h)	;PSLOT register
	ld	b,a
	ex	af,af'
	ld	a,b
	and	30h		;'0'
	ld	b,a
	in	a,(0A8h)	;PSLOT register
	and	0F3h		;'Û'
	sub	4
	ld	hl,4000h
.616:	add	a,4
	out	(0A8h),a	;PSLOT register
	ld	c,a
	ld	a,(hl)
	cpl
	ld	(hl),a
	cp	(hl)
	ld	a,c
	jr	z,.614		;[0BB3Eh]
	ld	e,0
.615:	ld	a,c
	rrca
	rrca
	rrca
	rrca
	and	0C0h		;'¿'
	or	b
	out	(0A8h),a	;PSLOT register
	ld	a,(0FFFFh)
	cpl
	and	0F3h		;'Û'
	or	e
	ld	(0FFFFh),a
	ld	a,c
	out	(0A8h),a	;PSLOT register
	ld	a,(hl)
	cpl
	ld	(hl),a
	cp	(hl)
	ld	a,c
	jr	z,.614		;[0BB3Eh]
	ld	a,e
	add	a,4
	ld	e,a
	cp	10h
	jr	nz,.615		;[0BB15h]
	ld	a,c
	jr	.616		;[0BB07h]
.614:	ex	af,af'
	out	(0A8h),a	;PSLOT register
	ex	af,af'
	ld	(0FFFCh),a
	ret
;::===============================::
;||   No execution path to here   ||
;::===============================::
	db	0,0,0FFh,0FFh,0FFh,0FFh,0,0,0,0,0FFh,0FFh,0FFh,0FFh,0
	db	0,0,0,0FFh,0FFh,0FFh,0FFh,0,0,0,0,0FFh,0FFh,0FFh,0FFh
	db	0,0,0,0,0FFh,0FFh,0FFh,0FFh,0,0,0,0,0FFh,0FFh,0FFh,0FFh
	db	0,0,0,0,0FFh,0FFh,0FFh,0FFh,0,0,0,0,0,0,0,0,0FFh,0FFh
	db	0FFh,0FFh,0,0,0,0,0FFh,0FFh,0FFh,0FFh,0,0,0,0,0FFh,0FFh
	db	0FFh,0FFh,0,0,0,0,0FFh,0FFh,0FFh,0FFh,0,0,0,0,0FFh,0FFh
	db	0FFh,0FFh,0,0,0,0,0FFh,0FFh,0FFh,0FFh,0,0,0,0,0FFh,0FFh
	db	0FFh,0FFh,0,0,0,0,0FFh,0FFh,0FFh,0FFh,0,0,0,0,0FFh,0FFh
	db	0FFh,0FFh,0,0,0,0,0FFh,0FFh,0FFh,0FFh,0,0,0,0,0FFh,0FFh
	db	0FFh,0FFh,0,0,0,0,0FFh,0FFh,0FFh,0FFh,0,0,0,0,0FFh,0FFh
	db	0FFh,0FFh,0,0,0,0,0FFh,0FFh,0FFh,0FFh,0,0,0,0,0FFh,0FFh
	db	0FFh,0FFh,0,0,0,0,0FFh,0FFh,0FFh,0FFh
;::===============================::
;||      Indexed entry point      ||
;::===============================::
TBC00:	nop
	nop
	nop
	rlca
	rrca
	rrca
.619:	rrca
	rla
	rra
	rra
	inc	e
	rra
	rrca
	rlca
	nop
	nop
	nop
	nop
	nop
	add	a,b
	ret	nz
	ret	po
	ret	po
	ld	h,b
	djnz	.617		;[0BC8Ah]
	ld	(hl),b
	ret	po
	add	a,b
	nop
	nop
	nop
	nop
	inc	bc
	rrca
	rra
	ccf
	jr	c,.618		;[0BC2Eh]
	dec	sp
	ld	a,(353Fh)
	dec	bc
	ld	e,0Eh
.618:	nop
	nop
	nop
	add	a,b
	or	b
	cp	b
	jr	z,.619		;[0BC06h]
	ret	c
	ret	c
	cp	b
	ld	d,b
	ret	po
	ld	a,b
	ret	m
	ld	(hl),b
	nop
	nop
	inc	sp
	ld	(hl),a
	di
	call	p,1D6Dh
	inc	c
	nop
	ld	h,c
	di
	di
	ld	h,e
	dec	a
	ld	a,l
	ld	a,b
	jr	nc,.620		;[0BBDFh]
	cp	a
	ccf
	ret	c
	ret	nz
	add	a,0Fh
	rrca
	xor	0E0h		;'‡'
	ret	po
	ret	pe
	xor	0CFh		;'œ'
	scf
	ld	(hl),38h	;'8'
	inc	a
	jr	.621		;[0BC64h]
.621:	inc	h
	ld	h,h
	ld	h,b
	nop
	jr	nz,.622		;[0BCCAh]
	ld	(hl),c
	ld	(hl),e
	ld	(hl),e
	ld	(hl),b
	ld	hl,6001h
	ret	p
	ld	h,(hl)
	rlca
	rlca
	inc	de
	jr	.623		;[0BC90h]
;::===============================::
;||   No execution path to here   ||
;::===============================::
	nop
	nop
	add	a,(hl)
	synchr	8Fh		;Check BASIC program char
	ld	b,0C0h		;'¿'
	ret	c
	nop
	jr	nz,.624		;[0BCE7h]
	ld	c,b
	nop
	nop
	ld	b,b
	nop
	djnz	.617		;[0BC8Ah]
.617:	nop
	ld	h,b
	ld	(hl),b
	jr	c,.625		;[0BC8Fh]
.625:	nop
.623:	ret	nz
	pop	bc
	add	a,e
	ld	(hl),30h	;'0'
	nop
	nop
	ld	(bc),a
	ld	(bc),a
	nop
	nop
	add	a,b
	nop
	ld	b,60h		;'`'
	ld	h,b
	nop
	ld	b,b
	nop
	nop
	ld	(bc),a
	nop
	nop
	nop
	nop
	nop
	ld	b,b
	nop
	nop
	jr	nz,.626		;[0BCBFh]
	nop
	nop
	djnz	.627		;[0BCB3h]
.627:	ld	(bc),a
	nop
	nop
	ld	bc,0
	nop
	nop
	nop
	nop
	ld	(bc),a
	nop
.626:	add	a,b
	or	h
	ld	l,d
	call	nc,0F4EAh
	ret	m
	ret	m
	ld	b,0FFh		;
	ret	p
.622:	pop	bc
	add	a,d
	add	a,d
	rst	38h
	jp	z,0FFCFh
	rrca
	add	a,e
	ld	b,c
	ld	b,c
	rst	38h
	out	(73h),a		;Unknown port
	synchr	0CBh		;Check BASIC program char
	call	SC0C0		;[0C0C0h]
	db	0FDh		;Invalid op-code '˝'
	rst	30h
	db	0FDh
	dw	0F3E3h		;Far call to slot 1 (external)
	out	(3),a		;Network ver 1.00
	inc	bc
	rst	38h
	rst	18h		;Print character [A] (BASIC,NIKE)
;
.624:	db	0BFh,7Fh,'Ejjjm',7Fh,0,'˛ˆÊ÷¬ˆ˛',0,'˛Ê⁄Ê⁄Ê˛',0,0FFh,0FFh
	db	0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
	db	0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
	db	0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0A0h,9Ah,0B1h
	db	8Ah,80h,80h,'¿',5,'Y',8Dh,'Q',5,0Dh,0BBh,0Fh,0FFh,'œ'
	db	0Fh,7,80h,'¿‡‡',0FFh,0FFh,0FFh,0FFh,7Fh,0Fh,':B––',0A8h
	db	'T',92h,'ÈÙ˚¬',92h,92h,86h,89h,'Ú',0Eh,'˛¸¸',0FFh,'¸'
	db	'¸¸¯‡?',0BFh,0FFh,0BFh,0BFh,0BFh,'O''¿',80h,80h,80h,80h
	db	'¿Á¯',13h,9,9,19h,19h,'3Á',1Fh,'Õ',8Ah,89h,8Bh,85h,'¬'
	db	'·¯',0B3h,'U',95h,'’',0ADh,'[',0A7h,1Fh,'¿',0BFh,7Fh
	db	7Fh,9Ch,'„',0FFh,0FFh,7Fh,8Fh,'Û˝˛~',0BEh,0BEh,'√',81h
	db	0Ch,'l`,',89h,'√',0BEh,'}˝',0BBh,'«',0FFh,'?œ<a·',91h
	db	89h,81h,1,7Fh,'<',86h,87h,89h,91h,81h,80h,'˛',7Fh,1,81h
	db	89h,91h,'·a<˛',80h,81h,91h,89h,87h,86h,'<',0FFh,0FFh
	db	0FFh,'ıÔ˛Ô˚',0FFh,0FFh,0FFh,'_Ô',0FFh,'Ô',0BFh,'Ô˛Ôı'
	db	0FFh,0FFh,0FFh,0FFh,'Ô',0FFh,'Ô_',0FFh,0FFh,0FFh,0FFh
	db	0FFh,0FFh,0FFh,0FFh,80h,80h,80h,0FFh,0FFh,0FFh,0FFh,0FFh
	db	0,0,0,0FFh,0,0,0,0,0,0,0FFh,0FFh,1,1,2,2,4,4,0FFh,0FFh
	db	7Fh,0FFh,'¸¯¯¯¯¯',0FFh,0FFh,0FFh,'¯Ë',0FFh,0FFh,0FFh
	db	7Fh,'?',1Fh,1Fh,9Fh,3,7,0Fh,0FFh,0FFh,0FFh,0FFh,'˛o',0FFh
	db	7Fh,'˝¸¯¯˙',0FFh,'¸‡¿«¯ƒ',0FFh,7Fh,'OG◊/''''Ô',1Fh,0BFh
	db	0FFh,0FFh,'˛',0FFh,'˚',6,1Fh,0BFh,7Fh,0FFh,'Ô',0FFh,0FFh
	db	'3wÛÙm',1Dh,0Ch,0,8Eh,0BFh,'?ÿ¿∆',0Fh,0Fh,'ˆ˛ˆ¸ÙZ',0B4h
	db	'˘·Ê¯‡‡‡‡‡8<',18h,0,'$d`',0,'`f',7,7,13h,18h,18h,'G'
	db	'GGGGGG',7Fh,90h,0AAh,0A9h,92h,80h,80h,'¿',0,' dH',0
	db	0,'@',0,'¿¡',83h,'60',0,0,2,0FFh,0FFh,'Ô‰¿√˚¯',0FFh,0FFh
	db	0FFh,13h,8,'lk',8Fh,0,'@',0,0,2,0,0,0,0,10h,0,2,0,0,1
	db	0,15h,'*’Í˜¸¿¯P',0A8h,'V',0AAh,'‘~',4,':',15h,'*’Í˜¸'
	db	'¯P',0A8h,'V',0AAh,'‘z',14h,':',7Fh,7Fh,7Fh,7Fh,7Fh
	db	7Fh,7Fh,0,0FFh,0FFh,0FFh,'¸¯¯¯¯',0FFh,0FFh,0FFh,8Fh,'C'
	db	'√CÛÁ»',90h,'ÚÚ',0FFh,0FFh,0FFh,'«',7Fh,7Fh,7Fh,7Fh,0FFh
	db	0FFh,0FFh,0FFh,'œ«ŒÃÃƒ¿‡‡„‡¯',0FFh,0FFh,'o',0Fh,0Fh
	db	9Fh,7Fh,0FFh,0FFh,0FFh,'G',8Fh,1Fh,1Fh,'???',7Fh,'˛¸'
	db	'¯ÛÙËË‡≈¿ Ù·Ò',0FFh,0FFh,'G',0AFh,1Fh,87h,7,8Fh,0FFh
	db	0FFh,'s„',7,0Fh,1Fh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
	db	0FFh,'˛¯¸aÛÛc=}x0Ó‡‡ËÓœ76',0Fh,1Fh,7Fh,'??',1Bh,1,'¡'
	db	0FFh,0FFh,0FFh,'?',7,81h,'¬¿ `qssp!',1,0,0,86h,'œ',8Fh
	db	6,'¿ÿ#S',0BFh,7Fh,0FFh,0FFh,0FFh,0FFh,0FFh,'˛˛˛¸¯‡',10h
	db	0,0,'`p8',0,0,2,0,0,80h,0,6,'``''„#sÛ„Û',0FFh,0FFh,0FFh
	db	0FFh,0FFh,'‡',84h,18h,'4',0,0,'@',0,0,' ',10h,0,0,0,0
	db	0,0,2,0,80h,'OO',9Fh,9Fh,9Fh,1Fh,'?',7Fh,0FFh,0FFh,83h
	db	80h,'ﬂ¯',0FFh,0FFh,0FFh,0FFh,0FFh,7Fh,1Fh,1Fh,'¯˛'
	db	'¸¸‹',80h,80h,'?o',0,0,0,1,'G',0FFh,'˛',0FFh,'˛',0FFh
	db	0FFh,'¸',0B8h,18h,7Fh,'?',1Fh,8Fh,'œO//',18h,84h,'¿‡'
	db	'¸˛',0FFh,0FFh,'/''«',7,3,3,'¡¯'
TC000:	db	'6',3,'M',3,'M',3,'M',3,'M',3,'M',3,'M',3,1,0Ch,0Ch,0Ch
	db	8,4,5,4,5,5,5,5,5,5,4,4,3,3,2,1,1,1,0,1,0Fh,0Fh,0Eh,0Dh
	db	0Dh,0Ch,0Ch,0Bh,0Ah,9,9,8,8,7,7,6,6,5,5,4,3,3,3,2,2,2
	db	1,1,1,1,1,1,1,1,1,1,1,1,1,0,'a',19h,'ı',17h,9Ch,16h,'W'
	db	15h,'%',14h,3,13h,'Û',11h,'Ò',10h,'˛',0Fh,18h,0Fh,'?'
	db	0Eh,'s',0Dh,'9',0Dh,'˚',0Bh,'O',0Bh,0ACh,0Ah,13h,0Ah
	db	82h,9,'˘',8,'y',8,0FFh,7,8Bh,7,' ',7,0B8h,6,'Y',6,'˝'
	db	5,0A7h,5,'W',5,9,5,'¡',4,'}',4,'=',4,0FFh,3,'∆',3,8Fh
	db	3,'\',3,',',3,0FFh,2,'‘',2,0ABh,2,84h,2,'a',2,'?',2,1Eh
	db	2,0,2,'„',1,'»',1,0AEh,1,96h,1,'~',1,'j',1,'V',1,'C',1
	db	'0',1,1Fh,1,0Eh,1,0FFh,0
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SC0C0:	pop	af
	nop
	call	po,0D800h
SC0C4	equ	$-1
	nop
	jp	z,TC000		;[0C000h]
	nop
	or	h
	nop
	xor	d
	nop
	and	c
	nop
	sub	a
	nop
	adc	a,a
	nop
	adc	a,b
	nop
	ld	a,a
	nop
	ld	a,c
	nop
	ld	(hl),d
	nop
	ld	l,e
	nop
	ld	h,(hl)
	nop
	ld	e,a
	nop
	ld	e,d
	nop
	ld	d,l
	nop
	ld	d,b
	nop
	ld	c,h
	nop
	ld	b,a
	nop
	ld	b,h
	nop
	ld	b,c
	nop
	dec	a
	nop
	ld	a,(3600h)
	nop
	inc	sp
	nop
	jr	nc,.655		;[0C0FAh]
.655:	ld	l,0
	ld	hl,(2900h)
	nop
	dec	h
;::===============================::
;||      Indexed entry point      ||
;::===============================::
TC101:	nop
	inc	h
	nop
	ld	(2000h),hl
	nop
	ld	e,0
	dec	e
	nop
	dec	de
	nop
	nop
	ld	bc,TA000	;[0A000h]
	nop
	ld	bc,100h
	ld	e,1
	nop
	ld	bc,5103h
	ld	a,(bc)
	adc	a,l
	inc	b
	dec	b
	ld	de,200h
	add	hl,de
	sbc	a,d
	inc	b
	ld	(bc),a
	dec	(hl)
	sbc	a,d
	inc	b
	sbc	a,d
	inc	b
	sbc	a,d
	inc	bc
	sbc	a,d
	ld	bc,0A10h
	ld	(bc),a
	add	hl,de
	sbc	a,d
	inc	b
	ld	(bc),a
	dec	h
	sbc	a,d
	inc	b
	sbc	a,d
	inc	b
	sbc	a,d
	inc	bc
	sbc	a,d
	ld	bc,111h
	nop
	cp	10h
	rst	38h
	nop
	ld	bc,1103h
	ld	(bc),a
	dec	b
	ld	a,(bc)
	and	l
	dec	bc
	or	h
	nop
	ld	bc,1C5h
	call	0CE01h
	ld	bc,1C5h
	call	z,0CD01h
	ld	bc,1C5h
	ret
;::===============================::
;||   No execution path to here   ||
;::===============================::
	ld	bc,1C5h
	call	nz,SC301	;[0C301h]
	ld	bc,1CAh
	push	bc
	ld	bc,1C6h
	jp	TC101		;[0C101h]
;::===============================::
;||   No execution path to here   ||
;::===============================::
	ld	bc,1BEh
	jp	.657		;[0BE01h]
;::===============================::
;||   No execution path to here   ||
;::===============================::
	ld	bc,1C2h
	jp	.658		;[0C201h]
;::===============================::
;||   No execution path to here   ||
;::===============================::
	ld	bc,1B9h
	cp	l
	ld	bc,1BEh
	cp	c
	ld	bc,1BDh
	cp	e
	ld	bc,1BEh
	cp	d
	ld	bc,1BDh
	pop	bc
	ld	bc,1BCh
	jp	.659		;[0BF01h]
;::===============================::
;||   No execution path to here   ||
;::===============================::
	ld	bc,1C5h
	pop	bc
	ld	bc,1C3h
	push	bc
	ld	bc,1C7h
	jp	SC901		;[0C901h]
;::===============================::
;||   No execution path to here   ||
;::===============================::
	ld	bc,1C5h
	call	z,SC901		;[0C901h]
	ld	bc,1C5h
	jp	nz,.661		;[0CA01h]
	ld	bc,1CCh
	adc	a,1
	synchr	1		;Check BASIC program char
	pop	de
	ld	bc,1CEh
	jp	z,.662		;[0C601h]
	ld	bc,2C5h
	pop	de
	ld	(bc),a
	push	bc
	ld	(bc),a
	pop	de
	ld	(bc),a
	nop
	ld	bc,1Dh
	pop	bc
	ld	bc,1CAh
	ret	nz
	ld	bc,1C1h
	add	a,1
	pop	bc
	ld	bc,1BEh
	cp	l
	ld	bc,1B9h
	push	bc
	ld	bc,1C3h
	pop	bc
	ld	bc,1BDh
	cp	b
	ld	bc,1B9h
	cp	(hl)
	ld	bc,1B7h
	cp	c
	ld	bc,1B7h
	or	(hl)
	ld	bc,1B4h
	or	(hl)
	ld	bc,1B4h
	or	d
	ld	(bc),a
	cp	(hl)
	ld	(bc),a
	or	d
	ld	(bc),a
	cp	(hl)
.658:	ld	(bc),a
	nop
	ld	bc,1Dh
	cp	(hl)
	ld	bc,1C5h
	call	nz,SC501	;[0C501h]
	ld	bc,1C9h
	call	0D101h
	ld	bc,1C9h
	push	bc
	ld	bc,1CDh
	call	z,SC901		;[0C901h]
	ld	bc,1CCh
	ret
;::===============================::
;||   No execution path to here   ||
;::===============================::
	ld	bc,1CFh
	call	z,0CD01h
	ld	bc,1C9h
	push	bc
	ld	bc,1CAh
	push	bc
	ld	bc,1CCh
	push	bc
	ld	bc,1CDh
	call	z,0CD01h
	ld	bc,1D2h
	sub	2
	push	de
	ld	bc,1D6h
	ret	c
	ld	bc,1D9h
	jp	c,0DD01h
	ld	bc,1DAh
	sub	1
	pop	de
	ld	bc,1CEh
	synchr	1		;Check BASIC program char
	pop	de
	ld	bc,1CEh
	jp	z,0D601h
	ld	bc,1CBh
	synchr	1		;Check BASIC program char
	jp	nc,0CD01h
	ld	bc,1CFh
	jp	nc,0CF01h
	ld	bc,1D2h
	rst	10h
	ld	bc,1D2h
	in	a,(1)		;Network ver 1.00
	jp	c,0D601h
	ld	bc,1D1h
	synchr	1		;Check BASIC program char
	adc	a,1
	ld	de,1
	cp	10h
	rst	38h
	nop
	ld	bc,1802h
	ld	de,T9300	;[9300h]
	ld	bc,196h
	sbc	a,b
	ld	bc,198h
	sub	(hl)
	ld	bc,298h
	sbc	a,b
	ld	bc,0FD1Bh
	djnz	.666		;[0C29Dh]
	nop
	ld	bc,11Eh
.666	equ	$-1
	ld	e,1
	nop
	ld	bc,3502h
	ld	de,TAE00	;[0AE00h]
	ld	bc,1B0h
	xor	c
	ld	bc,1ABh
	and	h
	ld	(bc),a
	and	h
	ld	(bc),a
	djnz	.667		;[0C2B7h]
	ld	de,1E01h
.667:	ld	bc,0FE00h
	djnz	.668		;[0C2BBh]
.668	equ	$-1
	db	0,1,11h,0,93h,1,96h,1,98h,1,98h,1,96h,1,98h,2,98h,1,10h
	db	3,11h,1,1Eh,0,0,'˛',10h,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
	db	0FFh,0FFh,0FFh,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0FFh,0FFh
	db	0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SC2FB:	rst	38h
	rst	38h
	rst	38h
	rst	38h
	rst	38h
;::===============================::
;||      Indexed entry point      ||
;::===============================::
TC300:	inc	b
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SC301:	rlca
	ld	a,(bc)
	inc	c
	ld	bc,0A02h
	dec	bc
	inc	b
	ex	af,af'
	ld	a,(bc)
	dec	bc
	ld	bc,403h
	rlca
	inc	b
	rlca
	inc	b
	rlca
	ld	bc,402h
.773	equ	$-1
	dec	b
	inc	b
	ex	af,af'
	inc	b
	dec	b
	ld	(bc),a
	inc	bc
	dec	bc
	inc	c
	add	hl,bc
	rlca
	dec	bc
	inc	c
	ld	(bc),a
	ld	(bc),a
	dec	bc
	dec	bc
	add	hl,bc
	ex	af,af'
	dec	bc
	dec	bc
	ld	(bc),a
	inc	bc
	ld	b,7
	add	hl,bc
	rlca
	ld	b,7
	ld	(bc),a
	ld	(bc),a
	ld	b,5
	add	hl,bc
	ex	af,af'
	ld	b,5
	ld	bc,0A03h
	inc	c
	inc	a
	dec	a
	ld	a,3Fh		;'?'
	ld	c,h
	ld	c,l
	ld	c,(hl)
	ld	c,a
	add	hl,de
	ld	a,(de)
	dec	de
	inc	e
	ld	(2423h),hl
	dec	h
	ld	h,27h		;'''
	jr	z,.669		;[0C37Dh]
	ld	hl,(2C2Bh)
	dec	l
	dec	e
	ld	e,1Fh
	ld	d,c
	jr	nc,.670		;[0C38Fh]
	ld	(1D33h),a
	ld	e,2Eh		;'.'
	cpl
	dec	e
	ld	e,2Eh		;'.'
	cpl
	ld	hl,(2E2Bh)
	cpl
	dec	e
	ld	e,2Eh		;'.'
	cpl
	dec	e
	ld	e,2Eh		;'.'
	cpl
	ld	hl,(2E2Bh)
	cpl
	dec	c
	ld	c,0
	nop
	ld	d,e
.669:	ld	d,h
	ld	d,l
	ld	d,(hl)
	ld	d,d
	ld	(de),a
	inc	de
	inc	d
	ld	de,1312h
	inc	d
	ld	e,c
	ld	e,d
	rla
	jr	.671		;[0C3E4h]
;::===============================::
;||   No execution path to here   ||
;::===============================::
	ld	e,b
	rla
.670:	jr	.672		;[0C3A6h]
;::===============================::
;||   No execution path to here   ||
;::===============================::
	ld	d,17h
	jr	.673		;[0C3EEh]
;::===============================::
;||   No execution path to here   ||
;::===============================::
	ld	e,d
	rla
	jr	.674		;[0C3F0h]
;::===============================::
;||   No execution path to here   ||
;::===============================::
	ld	e,b
	rla
	jr	.675		;[0C3B2h]
;::===============================::
;||   No execution path to here   ||
;::===============================::
	ld	d,17h
	jr	.676		;[0C3FAh]
;::===============================::
;||   No execution path to here   ||
;::===============================::
	ld	e,d
	rla
	jr	.677		;[0C3FCh]
;::===============================::
;||   No execution path to here   ||
;::===============================::
	ld	e,b
.672:	rla
	jr	.678		;[0C3BEh]
;::===============================::
;||   No execution path to here   ||
;::===============================::
	ld	d,17h
	jr	.679		;[0C406h]
;::===============================::
;||   No execution path to here   ||
;::===============================::
	ld	e,d
	rla
	jr	.680		;[0C408h]
;::===============================::
;||   No execution path to here   ||
;::===============================::
	ld	e,b
.675:	rla
	jr	.681		;[0C3CAh]
;::===============================::
;||   No execution path to here   ||
;::===============================::
	ld	d,17h
	jr	.682		;[0C3F1h]
;::===============================::
;||   No execution path to here   ||
;::===============================::
	add	hl,sp
	ld	a,(343Bh)
	dec	(hl)
.678:	ld	(hl),37h	;'7'
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SC3C0:	ld	(5023h),hl
	dec	h
	dec	c
	ld	c,0Fh
	djnz	.683		;[0C409h]
	ld	b,c
.681:	ld	b,d
	ld	b,e
	ld	b,h
	ld	b,l
	ld	b,d
	ld	b,(hl)
	ld	b,a
	ld	c,b
	ld	c,c
	ld	c,d
	jr	nz,.684		;[0C3F7h]
	ld	e,e
	ld	c,e
	jr	nz,.685		;[0C3FBh]
	dec	e
	ld	e,20h		;' '
	ld	hl,1F1Dh
	nop
	nop
	nop
	nop
;
.671:	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'`ab'
	db	'cdefghijklmnopqrstuvwxyz{|}~',7Fh,'`abcdefghijklmno'
	db	'pqrstuvwxyz{|}~',7Fh,'`abcdefghijklmnopqrstuvwxyz{|'
	db	'}~',7Fh,80h,81h,82h,83h,84h,85h,86h,87h,88h,89h,8Ah
	db	8Bh,8Ch,8Dh,8Eh,8Fh,90h,91h,92h,93h,94h,95h,96h,97h,98h
	db	99h,9Ah,9Bh,9Ch,9Dh,9Eh,9Fh,80h,81h,82h,83h,84h,85h,86h
	db	87h,88h,89h,8Ah,8Bh,8Ch,8Dh,8Eh,8Fh,90h,91h,92h,93h,94h
	db	95h,96h,97h,98h,99h,9Ah,9Bh,9Ch,9Dh,9Eh,9Fh,80h,81h,82h
	db	83h,84h,85h,86h,87h,88h,89h,8Ah,8Bh,8Ch,8Dh,8Eh,8Fh,90h
	db	91h,92h,93h,94h,95h,96h,97h,98h,99h,9Ah,9Bh,9Ch,9Dh,9Eh
	db	9Fh,0A0h,0A1h,0A2h,0A3h,0A4h,0A5h,0A6h,0A7h,0A8h,0A9h
	db	0AAh,0ABh,0ACh,0ADh,0AEh,0AFh,0B0h,0B1h,0B2h,0B3h,0B4h
	db	0B5h,0B6h,0B7h,0B8h,0B9h,0BAh,0BBh,0BCh,0BDh,0BEh,0BFh
	db	0A0h,0A1h,0A2h,0A3h,0A4h,0A5h,0A6h,0A7h,0A8h,0A9h,0AAh
	db	0ABh,0ACh,0ADh,0AEh,0AFh,0B0h,0B1h,0B2h,0B3h,0B4h,0B5h
	db	0B6h,0B7h,0B8h,0B9h,0BAh,0BBh,0BCh,0BDh,0BEh,0BFh,0A0h
	db	0A1h,0A2h,0A3h,0A4h
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SC501:	and	l
	and	(hl)
	and	a
	xor	b
	xor	c
	xor	d
	xor	e
	xor	h
	xor	l
	xor	(hl)
	xor	a
	or	b
	or	c
	or	d
	or	e
	or	h
	or	l
	or	(hl)
	or	a
	cp	b
	cp	c
	cp	d
	cp	e
	cp	h
	cp	l
	cp	(hl)
	cp	a
	ld	e,h
	ld	e,l
	ld	e,(hl)
	ld	e,a
	ld	e,h
	ld	e,l
	ld	e,(hl)
	ld	e,a
	ld	e,h
	ld	e,l
	ld	e,(hl)
	ld	e,a
	ld	e,h
	ld	e,l
	ld	e,(hl)
	ld	e,a
	ld	e,h
	ld	e,l
	ld	e,(hl)
	ld	e,a
	ld	e,h
	ld	e,l
	ld	e,(hl)
	ld	e,a
	ld	e,h
	ld	e,l
	ld	e,(hl)
	ld	e,a
	ld	e,h
	ld	e,l
	ld	e,(hl)
	ld	e,a
	ld	e,h
	ld	e,l
	ld	e,(hl)
	ld	e,a
	ld	e,h
	ld	e,l
	ld	e,(hl)
	ld	e,a
	ld	e,h
	ld	e,l
	ld	e,(hl)
	ld	e,a
	ld	e,h
	ld	e,l
	ld	e,(hl)
	ld	e,a
	ld	e,h
	ld	e,l
	ld	e,(hl)
	ld	e,a
	ld	e,h
	ld	e,l
	ld	e,(hl)
	ld	e,a
	ld	e,h
	ld	e,l
	ld	e,(hl)
	ld	e,a
	ld	e,h
	ld	e,l
	ld	e,(hl)
	ld	e,a
	ld	e,h
	ld	e,l
	ld	e,(hl)
	ld	e,a
	ld	e,h
	ld	e,l
	ld	e,(hl)
	ld	e,a
	ld	e,h
	ld	e,l
	ld	e,(hl)
	ld	e,a
	ld	e,h
	ld	e,l
	ld	e,(hl)
	ld	e,a
	ld	e,h
	ld	e,l
	ld	e,(hl)
	ld	e,a
	ld	e,h
	ld	e,l
	ld	e,(hl)
	ld	e,a
	ld	e,h
	ld	e,l
	ld	e,(hl)
	ld	e,a
	ld	e,h
	ld	e,l
	ld	e,(hl)
	ld	e,a
	ret	nz
	pop	bc
	jp	nz,.686		;[0C4C3h]
	push	bc
	add	a,0C7h		;'«'
	ret	z
	ret
;::===============================::
;||   No execution path to here   ||
;::===============================::
	jp	z,0CCCBh
	call	0CFCEh
	ret	nc
	pop	de
	jp	nc,0D4D3h
	push	de
	sub	0D7h		;'◊'
	ret	c
	exx
	jp	c,0DCDBh
	db	0DDh		;Invalid op-code '›'
	sbc	a,0DFh		;'ﬂ'
	ret	nz
	pop	bc
	jp	nz,.686		;[0C4C3h]
	push	bc
	add	a,0C7h		;'«'
	ret	z
	ret
;::===============================::
;||   No execution path to here   ||
;::===============================::
	jp	z,0CCCBh
	call	0CFCEh
	ret	nc
	pop	de
	jp	nc,0D4D3h
	push	de
	sub	0D7h		;'◊'
	ret	c
	exx
	jp	c,0DCDBh
	db	0DDh		;Invalid op-code '›'
	sbc	a,0DFh		;'ﬂ'
	ret	nz
	pop	bc
	jp	nz,.686		;[0C4C3h]
	push	bc
	add	a,0C7h		;'«'
	ret	z
	ret
;::===============================::
;||   No execution path to here   ||
;::===============================::
	jp	z,0CCCBh
	call	0CFCEh
	ret	nc
	pop	de
	jp	nc,0D4D3h
	push	de
	sub	0D7h		;'◊'
	ret	c
	exx
	jp	c,0DCDBh
	db	0DDh		;Invalid op-code '›'
	sbc	a,0DFh		;'ﬂ'
	ret	po
	pop	hl
	jp	po,0E4E3h
	push	hl
	and	0E7h		;'Á'
	ret	pe
	jp	(hl)
;::===============================::
;||   No execution path to here   ||
;::===============================::
	jp	pe,0ECEBh
	db	0EDh		;Invalid op-code 'Ì'
	xor	0EFh		;'Ô'
	ret	p
	pop	af
	jp	p,0F4F3h
	push	af
	or	0F7h		;'˜'
	ret	m
	ld	sp,hl
	jp	m,0FCFBh
	db	0FDh		;Invalid op-code '˝'
	cp	0FFh		;
	ret	po
	pop	hl
	jp	po,0E4E3h
.662:	push	hl
	and	0E7h		;'Á'
	ret	pe
	jp	(hl)
;::===============================::
;||   No execution path to here   ||
;::===============================::
	jp	pe,0ECEBh
	db	0EDh		;Invalid op-code 'Ì'
	xor	0EFh		;'Ô'
	ret	p
	pop	af
	jp	p,0F4F3h
	push	af
	or	0F7h		;'˜'
	ret	m
	ld	sp,hl
	jp	m,0FCFBh
	db	0FDh		;Invalid op-code '˝'
	cp	0FFh		;
	ret	po
	pop	hl
	jp	po,0E4E3h
	push	hl
	and	0E7h		;'Á'
	ret	pe
	jp	(hl)
;::===============================::
;||   No execution path to here   ||
;::===============================::
	jp	pe,0ECEBh
	db	0EDh		;Invalid op-code 'Ì'
	xor	0EFh		;'Ô'
	ret	p
	pop	af
	jp	p,0F4F3h
	push	af
	or	0F7h		;'˜'
	ret	m
	ld	sp,hl
	jp	m,0FCFBh
	db	0FDh		;Invalid op-code '˝'
	cp	0FFh		;
	nop
	ex	af,af'
	djnz	.694		;[0C660h]
	jr	z,.695		;[0C672h]
	ld	b,b
	ld	c,b
	ld	d,b
	ld	h,b
	ld	l,b
	ld	(hl),b
	add	a,b
	adc	a,b
	sub	b
	nop
	inc	b
	nop
	ld	b,7
	dec	b
	ld	b,2
	ld	bc,203h
	nop
	nop
	inc	b
	nop
	nop
	djnz	.696		;[0C66Dh]
	nop
	ld	bc,1010h
.694	equ	$-1
	nop
	ld	(bc),a
	jr	.697		;[0C675h]
;::===============================::
;||   No execution path to here   ||
;::===============================::
	nop
	inc	bc
	jr	.698		;[0C681h]
;::===============================::
;||   No execution path to here   ||
;::===============================::
	nop
	inc	bc
	jr	.699		;[0C685h]
.696:	nop
	inc	bc
	jr	.700		;[0C689h]
;::===============================::
;||   No execution path to here   ||
;::===============================::
	nop
.695:	djnz	.701		;[0C694h]
	jr	nc,.702		;[0C67Bh]
.697	equ	$-1
	ex	af,af'
	ld	a,(bc)
	nop
	nop
	add	hl,bc
.702:	jr	.703		;[0C6A4h]
;::===============================::
;||   No execution path to here   ||
;::===============================::
	dec	b
	rlca
	add	hl,bc
	nop
.698:	nop
	ex	af,af'
	ld	d,24h		;'$'
.699:	inc	b
	ld	b,8
	nop
.700:	nop
	rlca
	inc	d
	ld	hl,504h
	rlca
	nop
	nop
	ld	b,12h
.701:	jr	.704		;[0C699h]
;::===============================::
;||   No execution path to here   ||
;::===============================::
	inc	b
	dec	b
	nop
.704:	nop
	ld	b,12h
	jr	.705		;[0C6A1h]
;::===============================::
;||   No execution path to here   ||
;::===============================::
	inc	b
	dec	b
	nop
.705:	nop
	ex	af,af'
	ld	(bc),a
.703:	add	hl,bc
	inc	bc
	djnz	.706		;[0C6ACh]
	ld	de,1806h
	ld	b,18h
.706	equ	$-1
	ld	b,0
	ld	(bc),a
	nop
	inc	bc
	ld	bc,204h
	dec	b
	inc	bc
	ld	b,3
	ld	b,0
	cp	2
	cp	2
	nop
	ld	(bc),a
	ld	(bc),a
	nop
	ld	(bc),a
	cp	2
	cp	0
	cp	0FEh		;'˛'
	ld	d,27h		;'''
	dec	c
	dec	bc
	ld	c,18h
	rra
	rla
	ret	po
	rst	38h
	pop	hl
	rst	38h
	ld	bc,2100h
	nop
	jr	nz,.707		;[0C6DCh]
.707:	rra
	nop
	rst	38h
	rst	38h
	rst	18h		;Print character [A] (BASIC,NIKE)
	rst	38h
	rst	38h
	ret	po
	sbc	a,9Eh		;'û'
	jr	nz,.708		;[0C749h]
	ld	h,d
	ld	h,e
	ld	h,h
	ld	h,l
	ld	h,(hl)
	ld	h,a
	ld	l,b
	ld	l,c
	ld	l,d
	ld	l,e
	ld	l,h
	ld	l,l
	jr	nz,.709		;[0C716h]
	ld	l,(hl)
	ld	l,a
	ld	(hl),b
	ld	(hl),c
	ld	(hl),d
	ld	(hl),e
	ld	(hl),h
	ld	(hl),l
	halt
	ld	(hl),a
	ld	a,b
	ld	a,c
	ld	a,d
	jr	nz,.710		;[0C725h]
	jr	nz,.711		;[0C782h]
	jr	nz,.712		;[0C729h]
	ld	a,h
	ld	a,l
	jr	nz,.713		;[0C72Dh]
	jr	nz,.714		;[0C72Fh]
	ld	a,(hl)
	ld	a,a
	jr	nz,.715		;[0C733h]
	jr	nz,.716		;[0C735h]
	jr	nz,.717		;[0C737h]
.709	equ	$-1
	ld	e,e
	ld	e,h
	ld	e,l
	ld	e,(hl)
	ld	e,a
	ld	e,h
	jr	nz,.718		;[0C73Fh]
	jr	nz,.719		;[0C741h]
	jr	nz,.720		;[0C746h]
	inc	h
	dec	h
.710:	jr	nz,.721		;[0C747h]
	jr	nz,.708		;[0C749h]
.712:	jr	nz,.722		;[0C74Bh]
	jr	nz,.723		;[0C74Dh]
.713:	jr	nz,.724		;[0C755h]
.714:	daa
	jr	z,.725		;[0C752h]
	ld	a,(3C3Bh)
.715	equ	$-2
.716:	dec	a
	ld	a,3Fh		;'?'
.717	equ	$-1
	jr	nz,.711		;[0C782h]
	ld	b,l
	ld	b,c
	ld	c,h
	ld	d,h
	ld	c,b
.718:	jr	nz,.726		;[0C761h]
.719:	jr	nz,.727		;[0C763h]
	jr	nz,.728		;[0C765h]
	jr	nz,.729		;[0C777h]
.720	equ	$-1
.721:	jr	nz,.730		;[0C769h]
.708:	ld	(3030h),a
.722	equ	$-1
	jr	nc,.731		;[0C76Eh]
.723	equ	$-1
	jr	nz,.732		;[0C757h]
	ld	d,a
	ld	b,c
.725:	ld	d,d
	ld	d,d
	ld	c,c
.724:	ld	c,a
	ld	d,d
.732:	add	hl,bc
	add	a,c
	add	a,d
	add	a,e
	add	a,h
	add	a,l
	add	a,(hl)
	add	a,a
	adc	a,b
	adc	a,c
.726:	rlca
	add	hl,hl
.727:	ld	hl,(2C2Bh)
.728	equ	$-1
	dec	l
	ld	l,2Fh		;'/'
.730:	inc	bc
	ld	b,l
	ld	c,h
	ld	b,(hl)
	ld	b,41h		;'A'
.731	equ	$-1
	ld	d,d
	ld	c,l
	ld	c,a
	ld	d,l
	ld	d,d
	inc	c
	ld	d,b
	ld	c,c
.729:	ld	b,e
	ld	c,e
	ld	d,l
	ld	d,b
	jr	nz,.733		;[0C7CDh]
	ld	c,a
	ld	d,a
	ld	b,l
	ld	d,d
	inc	c
.711:	ld	c,l
	ld	b,c
	ld	b,a
	ld	c,c
	ld	b,e
	jr	nz,.734		;[0C7A9h]
	ld	d,b
	ld	c,a
	ld	d,a
	ld	b,l
	ld	d,d
	ld	a,(bc)
	ld	d,e
	ld	c,b
	ld	c,a
	ld	d,h
	jr	nz,.735		;[0C7E5h]
	ld	c,a
	ld	d,a
	ld	b,l
	ld	d,d
	ld	a,(bc)
	ld	d,e
	ld	c,b
	ld	c,a
	ld	d,h
	jr	nz,.736		;[0C7F3h]
	ld	d,b
	ld	b,l
	ld	b,l
	ld	b,h
	inc	c
	ld	b,(hl)
	ld	c,c
	ld	b,a
	ld	c,b
.734:	ld	d,h
	jr	nz,.737		;[0C7CCh]
	ld	d,b
	ld	c,a
	ld	d,a
	ld	b,l
	ld	d,d
	ld	c,4Eh
	ld	c,a
	ld	d,a
	jr	nz,.738		;[0C7FFh]
	ld	b,c
	ld	d,e
	jr	nz,.739		;[0C7DBh]
	ld	b,l
	ld	e,b
	ld	d,h
	ld	d,d
	ld	b,c
	ld	c,4Ah
	ld	d,l
	ld	d,e
	ld	d,h
	jr	nz,.740		;[0C808h]
	ld	d,h
	ld	b,l
	jr	nz,.741		;[0C7EBh]
	ld	d,e
.737:	ld	c,a
.733:	ld	c,l
	ld	b,l
	ld	c,50h
	ld	c,a
	ld	c,c
	ld	d,e
	ld	c,a
	ld	c,(hl)
	ld	b,l
	ld	b,h
	jr	nz,.742		;[0C7FAh]
	ld	b,(hl)
.739:	ld	c,a
	ld	c,a
	ld	b,h
	inc	c
	jr	nc,.743		;[0C811h]
	ld	h,b
	ld	sp,3030h
.735:	jr	nz,.744		;[0C829h]
	ld	c,a
	ld	c,(hl)
	ld	d,l
	ld	d,e
.741:	djnz	.745		;[0C846h]
	ld	c,a
	ld	d,l
	jr	nz,.746		;[0C839h]
	ld	b,c
	ld	d,(hl)
.736:	ld	b,l
	jr	nz,.747		;[0C83Ch]
	ld	c,a
	ld	d,l
	ld	c,(hl)
	ld	b,h
.742:	jr	nz,.748		;[0C83Dh]
	ld	c,54h
	ld	d,d
.738:	ld	b,l
;::===============================::
;||      Indexed entry point      ||
;::===============================::
TC800:	ld	b,c
	ld	d,e
	ld	d,l
	ld	d,d
	ld	b,l
	jr	nz,.749		;[0C827h]
	ld	d,d
.740:	ld	c,a
	ld	c,a
	ld	c,l
	djnz	.750		;[0C853h]
	ld	c,c
	ld	c,(hl)
	ld	b,h
	jr	nz,.751		;[0C866h]
.743	equ	$-1
	ld	c,b
	ld	b,l
	jr	nz,.752		;[0C836h]
	ld	d,b
	ld	c,a
	ld	d,h
	ld	c,c
	ld	c,a
	ld	c,(hl)
	ld	c,4Fh
	ld	d,h
	ld	c,b
	ld	b,l
	ld	d,d
	jr	nz,.753		;[0C844h]
	ld	d,b
	ld	c,h
	ld	b,c
.749:	ld	e,c
	ld	b,l
.744:	ld	d,d
	ld	d,e
	ld	c,53h
	ld	c,b
	ld	c,a
	ld	d,h
	ld	d,e
	jr	nz,.754		;[0C881h]
	ld	c,a
	ld	d,a
	jr	nz,.755		;[0C88Ah]
.752	equ	$-1
	ld	d,h
	ld	d,l
.746:	ld	c,(hl)
	ld	c,53h
.747:	ld	c,b
.748:	ld	c,a
	ld	d,h
	ld	d,e
	jr	nz,.756		;[0C890h]
	ld	c,a
	ld	d,a
.753:	jr	nz,.757		;[0C88Eh]
.745:	ld	d,l
	ld	d,d
	ld	d,h
	jr	nz,.758		;[0C891h]
	ld	c,a
	ld	c,a
	ld	b,h
	inc	c
	jr	nc,.754		;[0C881h]
	ld	h,b
	ld	sp,3030h
.750	equ	$-2
	jr	nz,.759		;[0C899h]
	ld	c,a
	ld	c,(hl)
	ld	d,l
	ld	d,e
	djnz	.760		;[0C8B6h]
	ld	c,a
	ld	d,l
	jr	nz,.761		;[0C8A9h]
	ld	b,c
	ld	d,(hl)
	ld	b,l
	jr	nz,.762		;[0C8ACh]
.751:	ld	c,a
	ld	d,l
	ld	c,(hl)
	ld	b,h
	jr	nz,.763		;[0C8ADh]
	ld	c,54h
	ld	d,d
	ld	b,l
	ld	b,c
	ld	d,e
	ld	d,l
	ld	d,d
	ld	b,l
	jr	nz,.764		;[0C897h]
	ld	d,d
	ld	c,a
	ld	c,a
	ld	c,l
	djnz	.765		;[0C8C3h]
	ld	c,c
	ld	c,(hl)
	ld	b,h
	jr	nz,.766		;[0C8D6h]
.754	equ	$-1
	ld	c,b
	ld	b,l
	jr	nz,.767		;[0C8A6h]
	ld	d,b
	ld	c,a
	ld	d,h
	ld	c,c
.755:	ld	c,a
	ld	c,(hl)
	ld	c,4Fh
.757:	ld	d,h
	ld	c,b
.756:	ld	b,l
.758:	ld	d,d
	jr	nz,.768		;[0C8B4h]
	ld	d,b
	ld	c,h
	ld	b,c
.764:	ld	e,c
	ld	b,l
.759:	ld	d,d
	ld	d,e
	ld	c,53h
	ld	c,b
	ld	c,a
	ld	d,h
	ld	d,e
	jr	nz,.769		;[0C8F1h]
	ld	c,a
	ld	d,a
	jr	nz,.770		;[0C8FAh]
.767	equ	$-1
	ld	d,h
	ld	d,l
.761:	ld	c,(hl)
	ld	c,53h
.762:	ld	c,b
.763:	ld	c,a
	ld	d,h
	ld	d,e
	jr	nz,TC900	;[0C900h]
	ld	c,a
	ld	d,a
.768:	jr	nz,.771		;[0C8FEh]
.760:	ld	d,l
	ld	d,d
	ld	d,h
	dec	c
	ret	pe
	inc	c
	sbc	a,a
	nop
	inc	e
	ld	b,b
	rlca
	rst	18h		;Print character [A] (BASIC,NIKE)
	inc	e
.765:	ld	b,b
	inc	e
	ld	b,b
	xor	h
	adc	a,a
	synchr	30h		;Check BASIC program char
	rlca
	rst	18h		;Print character [A] (BASIC,NIKE)
	ld	(bc),a
	adc	a,a
	xor	b
	inc	bc
	sbc	a,c
	sbc	a,62h		;'b'
	ret	p
	ld	b,d
	nop
.766:	nop
	nop
	ld	h,l
	dec	bc
	ld	de,TC101	;[0C101h]
	ld	a,(bc)
	ld	l,b
	add	hl,bc
	adc	a,b
	add	hl,bc
	jr	nc,.772		;[0C8EDh]
	ld	d,h
	ld	a,(bc)
	inc	a
	dec	bc
	dec	d
	nop
	rlca
	rst	18h		;Print character [A] (BASIC,NIKE)
	ld	(bc),a
.772:	adc	a,e
	xor	h
	inc	bc
	sbc	a,c
.769:	sbc	a,85h		;'Ö'
	ret	nc
	nop
	call	nz,0D205h
	add	hl,de
	call	nz,3E00h
.770	equ	$-2
	ld	b,e
	jp	.773		;[0C316h]
.771	equ	$-2
;
TC900:	db	'G'
;::===============================::
;||          SUBROUTINE           ||
;::===============================::
SC901:	db	'GGGGGGGGGGGGGGGG',7,'G',7,'G',7,'G',7,'GGGGGGGGG',7
	db	'G',7,'G',7,'G',7,'GGGGGGGGG',7,'G',7,'G',7,'G',7,'G'
	db	'GGGGGGGGGGGGGGGG@@@@@@@G@@@@@@@G@@@@@@@@@@@@@@@@@GG'
	db	'GGGG@@GGG@GGG@@@@@GGGGGGGGGGG@@@@@@@GGGGGGGGGGGGGGG'
	db	'GGGGGGGGG@@@@@@@@G@@@@@@@G@@@@@@@GGGGGGGGGGGGGGGGGG'
	db	'G',7,'GGG',7,'GGG@GGG@GGG',7,'GGG',7,'GGGGGGGGGGG',7
	db	'GGG',7,'GGGGGGGGGGGGGGGGG@@@@@@@G@@@@@@@G@@@@@@@'
;
	END
