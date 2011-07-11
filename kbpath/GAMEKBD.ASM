JOY1STAT:	equ	8427h
JOY2STAT:	equ	8447h
WRTPSG:	equ	0B3EFh
RDPSG:	equ	0B3F9h
SNSMAT:	equ	0B3FEh
ROWTABLE:	equ	847Fh

	org	0F975h

SCANJOY:	ld	de,ROWTABLE+5	;[8485h]
	ld	b,4	;filas 6,7,8 (9 - 6)
MATLOOP:	ld	a,9
	sub	b
	call	SNSMAT	;[0B3FEh]
	ld	(de),a
	inc	e
	djnz	MATLOOP	;[0B410h]

	ld	a,3	;fila 3
	call	SNSMAT
	ld	(ROWTABLE+3),a
        ld      a,4     ;fila 4
	call	SNSMAT
        ld      (ROWTABLE+4),a


	ld	a,0Fh
	ld	e,8Fh	;''
	call	WRTPSG	;[0B3EFh]
	ld	a,0Eh
	call	RDPSG	;[0B3F9h]
	cpl
	and	3Fh
	bit	5,a
        jr      z,nojoy1B
	ld	b,a
        ld      a,(ROWTABLE+7)
        res     7,a
        ld      (ROWTABLE+7),a
	ld	a,b

nojoy1B:ld	(JOY1STAT),a	;[8427h]
	ld	a,0Fh
	ld	e,0CFh		;'O'
	call	WRTPSG	;[0B3EFh]
	ld	a,0Eh
	call	RDPSG	;[0B3F9h]
	cpl
	and	3Fh
	bit	5,a
        jr      z,nojoy2B
	ld	b,a
        ld      a,(ROWTABLE+6)
        res     2,a
        ld      (ROWTABLE+6),a
	ld	a,b

nojoy2B:ld	(JOY2STAT),a	;[8447h]

	push	bc
	push	af

	ld	b,0
	ld	a,(ROWTABLE+8)
	bit	0,a
	jr	nz,JOY1
	set	4,b

JOY1:
	and	0f0h
	bit	7,a	;leeR
	jr	nz,LEE_JOY_D
	set	3,a

LEE_JOY_D:
	bit	6,a
	jr	nz,LEE_JOY_U
	set	1,a
LEE_JOY_U:
	bit	5,a
	jr	nz,LEE_JOY_L
	set	0,a
LEE_JOY_L:
	bit	4,a
	jr	nz,LEE_JOY_2
	set	2,a
LEE_JOY_2:
	and	0fh
	or	b

	ld	hl,JOY1STAT
	or	(hl)
	ld	(hl),a

;MSB                                                                    LSB
;        7       6       5       4       3       2       1       0
;    -----------------------------------------------------------------
; 0  |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
;    |-------+-------+-------+-------+-------+-------+-------+-------|
; 1  |   ;   |   ]   |   [   |   \   |   =   |   -   |   9   |   8   |
;    |-------+-------+-------+-------+-------+-------+-------+-------|
; 2  |   B   |   A   | accent|   /   |   .   |   ,   |   `   |   '   |
;    |-------+-------+-------+-------+-------+-------+-------+-------|
; 3  |   J   |   I   |   H   |   G   |   F   |   E   |   D   |   C   |
;    |-------+-------+-------+-------+-------+-------+-------+-------|
; 4  |   R   |   Q   |   P   |   O   |   N   |   M   |   L   |   K   |
;    |-------+-------+-------+-------+-------+-------+-------+-------|
; 5  |   Z   |   Y   |   X   |   W   |   V   |   U   |   T   |   S   |
;    |-------+-------+-------+-------+-------+-------+-------+-------|
; 6  |   F3  |   F2  |   F1  | CODE  | CAPS  | GRAPH | CTRL  | SHIFT |
;    |-------+-------+-------+-------+-------+-------+-------+-------|
; 7  | RETURN| SELECT|   BS  | STOP  |  TAB  |  ESC  |   F5  |   F4  |
;    |-------+-------+-------+-------+-------+-------+-------+-------|
; 8  | RIGHT | DOWN  |   UP  | LEFT  |  DEL  |  INS  | HOME  | SPACE |
;    -----------------------------------------------------------------

	ld	b,0

	ld	a,(ROWTABLE+3)	;LEE JOY2 U y R  (F E)
	bit	2,a
	jr	nz,LEE_JOY2R
	set	0,b	;B = 0000 000U

LEE_JOY2R:
	bit	3,a
	jr	nz,LEE_JOY2L
	set	3,b	;B = 0000 R00U

LEE_JOY2L:
	ld	a,(ROWTABLE+5)
	bit	0,a
	jr	nz,LEE_JOY2D
	set	2,b	;B = 0000 RL0U

LEE_JOY2D:
	bit	5,a
	jr	nz,LEE_JOY2F
	set	1,b	;B = 0000 RLDU
LEE_JOY2F:
	ld	a,(ROWTABLE+6)
	bit	0,a
	jr	nz,JOY2_END
	set	4,b	;B = 0001 RLDU

JOY2_END:
	ld	a,(JOY2STAT)
	or	b
	ld	(JOY2STAT),a

	pop	af
	pop	bc
	ret
