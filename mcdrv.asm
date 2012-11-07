
section         code
MCDRV:				; ...
		jp	IntFunct


;****************************************************************************
MCDRVC:
Commands:				; ...
		di			; Input	point for driver commands
		push	ix
		push	hl
		push	de
		push	bc
		cp	13
		jr	nc, EndCommand
		add	a, a
		ld 	d,0
		ld 	e,a
		push 	de
		pop 	ix
		ld	de, Table_CMD
		add	ix, de
		ld	e, (ix+0)
		ld	d, (ix+1)
		push 	de
		pop 	ix
		call	JumpCommand

EndCommand:				; ...
		pop	bc
		pop	de
		pop	hl
		pop	ix
		ret
;****************************************************************************

JumpCommand:				; ...
		jp	(ix)
;****************************************************************************
Table_CMD:	dw CMD_inivar		; ...
		dw CMD_inivar
		dw CMD_putSFX
		dw CMD_inichips
		dw CMD_fadeout
		dw CMD_fadein
		dw CMD_chkmus
		dw CMD_sfx
		dw CMD_chksfx
		dw CMD_musicon
		dw CMD_incmus
		dw CMD_musicoff
		dw CMD_putMinc

;****************************************************************************

CMD_inivar:				; ...
		jp	inivars
;****************************************************************************

CMD_putSFX:
		ld (Table_SFX),hl
		ret


;********************************************************************
CMD_putMinc:
		ld (TableMinc),hl
		ret



;****************************************************************************

CMD_musicon:				; ...
		in	a, (0E6h)
		ld	(Tlast_FM), a
		jr	PutSong
;****************************************************************************

CMD_musicoff:				; ...
		in	a, (0E6h)
		ld	(Tlast_FM), a
		ld	hl,EmptySong

PutSong:				; ...
		push	hl		; Init all variables for playing a song
		call	inivars
		pop	hl
		call	IniTblSng
		ret

EmptySong:	db 0Ch, 0, 9, 0, 0A1h, 62h, 25h, 72h, 0
		db 10h, 0, 0A1h, 62h, 25h, 72h, 0, 17h
		db 0, 0A1h, 62h, 25h, 72h, 0, 1Eh, 0, 0A1h
		db 62h, 25h, 72h, 0, 25h, 0, 0A1h, 62h
		db 25h, 72h, 0, 2Ch, 0, 0A1h, 62h, 25h
		db 72h, 0, 33h, 0, 0A1h, 62h, 25h, 72h
		db 0, 3Ah, 0, 0A1h, 62h, 25h, 72h, 0, 41h
		db 0, 0A1h, 62h, 25h, 72h, 0, 48h, 0, 0A1h
		db 62h, 25h, 72h, 0, 4Fh, 0, 0A1h, 62h
		db 25h, 72h, 0, 56h, 0, 0A1h, 62h, 25h
		db 72h, 0, 0, 0







;****************************************************************************

CMD_inichips:				; ...
		call	inivars
		call	inichips
		ret
;****************************************************************************


CMD_fadeout:				; ...
		ld	b, c
		ld	a, 80h
		or	c
		ld	(FadeCtl), a
		ld	a, b
		and	80h
		ld	(FadeOutRest), a
		ret
;****************************************************************************

CMD_fadein:				; ...
		ld	a, (SilenceFlag)
		or	a
		ret	z
		ld	a, 0C0h
		or	c
		ld	(FadeCtl), a
		ld	a, 0Fh
		ld	(FadeNumPass), a
		xor	a
		ld	(SilenceFlag), a
		ret
;****************************************************************************

CMD_chkmus:				; ...
		ld	a, (ChannelOFF)
		ld	b, a
		ld	a, (FadeCtl)
		or	b
		ret
;****************************************************************************

CMD_sfx:				; ...
		ld	hl, (Table_SFX)	; Definicion de	los SFX
		ld	a,h
		or	l
		ret	z
		call	SearchSong
		ret	nc
		call	PutSFX
		xor	a
		ret
;****************************************************************************

CMD_incmus:				; ...
		ld	hl, (TableMinc)
		ld	a,h
		or	l
		ret	z
		call	SearchSong
		ret	nc
		call	PutMusInc
		xor	a
		ret
;****************************************************************************
;Search	for a song in a	song list
;hl -> Address of song list

SearchSong:				; ...
		ld	d, h		; Input: HL -> SFX Table base
		ld	e, l
		ld	a, c
		dec	a
		cp	(hl)
		ld	a, 0FFh
		ret	nc
		ld	b, 0
		add	hl, bc
		add	hl, bc
		ld	c, (hl)
		inc	hl
		ld	b, (hl)
		ex	de, hl
		add	hl, bc
		scf
		ret
;****************************************************************************

CMD_chksfx:				; ...
		ld	a, (SFX_ON)
		or	a
		ret
;****************************************************************************

WritePSG:				; ...
		push	af
;b -> PSG channel
		ld	a, b
		out	(010h),	a
		pop	af
		out	(011h),	a
		ret
;****************************************************************************

ReadPSG:				; ...
		ld	a, b
		out	(010h),	a
		in	a, (012h)
		ret
;****************************************************************************


WriteFM:	push bc
		ld c,a
		ld a,b
		out (7ch),a
		ld a,c
		out (7dh),a
		pop bc
		ret


;****************************************************************************

inivars:				; ...
              ld    hl, Start_REL
              ld    de, Start_RAM
              ld    bc, End_REL - Start_REL
              ldir

		ld	hl, ChannelOFF
		ld	de, TimeLastChn
		ld	bc, 298h
		ld	(hl), 0
		ldir
		ld	a, 4Bh ; 'K'
		ld	(NumDecInt), a
		ld	a, 20h ; ' '
		ld	(ShdFM_E), a
		ld	a, 9
		ld	(Rhythm_Mode), a
		ld	a, 1
		ld	(ChannelOFF), a

initPSG:				; ...
		ld	b, 7
		call	ReadPSG
		or	3Fh
		ld	(ShdPSG_7), a
		call	WritePSG
		ret
;****************************************************************************

IniTblSng:				; ...
		ld	ix, ChnTblSong
		ld	a, (hl)
		cp	0FEh		; Bload	header?
		jr	nz, IniTblSng1
		ld	de, 7
		add	hl, de

IniTblSng1:				; ...
		ld	e, l
		ld	d, h
		inc	hl
		inc	hl

IniTblSng2:				; ...
		push	hl
		ld	(ix+0),	1
		inc	hl
		inc	hl
		ld	(ix+1),	l
		ld	(ix+2),	h
		pop	hl
		ld	bc, 2Eh
		add	ix, bc
		ld	a, (hl)
		inc	hl
		ld	h, (hl)
		ld	l, a
		add	hl, de
		push	hl
		ld	a, (hl)
		inc	hl
		or	(hl)
		pop	hl
		jr	nz, IniTblSng2
		ret
;****************************************************************************

PutSFX:					; ...
		push	hl
		ld	hl, ChnSFXPSG1
		ld	de, ChnSFXPSG1+1
		ld	bc, 45
		ld	(hl), 0
		ldir
		pop	hl
		ld	ix, ChnSFXPSG1
		ld	a, (hl)

PutSFX1:				; ...
		ld	(ix+0),	1
		inc	hl
		ld	(ix+1),	l
		ld	(ix+2),	h
		ld	de, 46
		add	ix, de
		call	ADD_HL
		ld	a, (hl)
		or	a
		jr	nz, PutSFX1
		ld	a, (ShdPSG_7)
		or	36h ; '6'
		ld	(ShdPSG_7), a
		ld	a, 3
		ld	(SFX_ON), a
		ret
;****************************************************************************

PutMusInc:				; ...
		push	hl
		ld	a, (SONG_ON)
		or	a
		jr	nz, PutMusInc1
		ld	hl, ChannelAct
		ld	de, ShadowVars
		ld	bc, 28Fh
		ldir

PutMusInc1:				; ...
		call	inivars
		ld	a, 1
		ld	(SONG_ON), a
		pop	hl
		call	IniTblSng
		ret
;****************************************************************************

QuitSong:				; ...
		ld	hl, ShadowVars
		ld	de, ChannelAct
		ld	bc, 28Fh
		ldir
		xor	a
		ld	(SONG_ON), a
		ld	a, (FM_InstSoft)
		call	WriteFMInst
		xor	a
		ld	b, 8
		call	WritePSG
		inc	b
		call	WritePSG
		inc	b
		call	WritePSG
		ret
;****************************************************************************

inichips:

		call    MCSearchFM

		ld	c, 9
		ld	b, 30h

inichip1:				; ...
		ld	a, 0Fh
		call	WriteFM
		inc	b
		dec	c
		jr	nz, inichip1
		jp	initPSG

;***************************************************************************

;;; ****************************************************************
; Search and init FM


MCSearchFM:
DetectMSXMUSIC:
        xor     a
        ld      (FMSlot),a              ; reset slotnr
	inc	a
	ld	(FMfound),a

.pri_l: push    bc
        ld      a,4
        sub     b
        ld      c,a
        ld      hl,EXPTBL
        add     a,l
        ld      l,a
        ld      a,(hl)
        add     a,a
        jr      nc,.notExp

        ld      b,4                     ; slot is expanded
.exp_l: push    bc
        ld      a,24h
        sub     b
        rlca
        rlca
        or      c
        ld      (SearchTemp),a

        call    .SearchFM

        ld      a,(FMSlot)

        or      a
        pop     bc
        jr      nz,.end
        djnz    .exp_l
.nextpri:
        pop     bc
        djnz    .pri_l
	xor	a
	ld	(FMfound),a	
        ret

.notExp:                                ; slot is not expanded
        ld      a,c
        ld      (SearchTemp),a

        call    .SearchFM

        ld      a,(FMSlot)

        or      a
        jp      z,.nextpri
.end:   pop     bc
        ret
	
.SearchFM:
        ld      b,8
        ld      hl,.TxtAPRL
        ld      de,4018h
        call    .Compare
        ret     nc

        ld      b,4
        ld      hl,.TxtOPLL
        ld      de,401Ch
        call    .Compare
        ret     c

        ld      hl,7FF6h
        push    af
        push    hl
        call    RDSLT
        or      1
        ld      e,a
        pop     hl
        pop     af
        call    WRSLT
        or      a
	ret

.Compare:
        ld      a,(SearchTemp)
        ld      c,a
.loop:  push    bc
        push    hl
        push    de
        ld      a,c
        ex      de,hl
        call    RDSLT
        pop     de
        pop     hl
        pop     bc
        cp      (hl)
        scf
        ret     nz

        inc     hl
        inc     de
        djnz    .loop
        ld      a,c
        ld      (FMSlot),a
        or      a
        ret
	

.TxtAPRL: db     "APRL"
.TxtOPLL: db     "OPLL"

section rdata
SearchTemp:     rb      1
FMSlot: 	rb      1
section code	
	


;****************************************************************************
;Funcion execute on each interrupt

IntFunct:
		ld	hl, FadeContAct
		ld	a, (FadeCtl)
		bit	6, a
		jp	z, FadeOutR	; Fade in?
		and	3Fh
		cp	(hl)
		jp	z, FadeInP	; do it	reach cont of ints of fade?
		inc	(hl)
		jp	BeginDeco
;****************************************************************************

FadeInP:
		xor	a		; It is	necesary does a	fade out pass
		ld	(hl), a
		inc	hl
		dec	(hl)
		jp	nz, BeginDeco	; Is it	fade finish?
		xor	a
		ld	(FadeCtl), a
		jp	BeginDeco
;****************************************************************************
;This code is which deal with fade out command

FadeOutR:
		cp	80h
		jp	c, BeginDeco	; is fade out command active?
		and	3Fh
		cp	(hl)		; Is necesary decrement	volumen?
		jp	z, FadeOutAct
		inc	(hl)		; Not yet
		jp	BeginDeco
;****************************************************************************
;This code decrement volumen for fade out and actualize	all variables implicates on fade out

FadeOutAct:
		xor	a
		ld	(hl), a
		inc	hl
		inc	(hl)
		ld	a, (hl)
		cp	10h
		jp	c, BeginDeco	; did it finished fade out?
		ld	a, (FadeOutRest); Is active option of decodification on	silence?
		or	a
		jp	z, FadeORest
		ld	(SilenceFlag), a; yes, it is
		xor	a
		ld	(FadeCtl), a
		call	inichips
		jp	BeginDeco
;****************************************************************************
;This code clean song at all

FadeORest:
		xor	a
		ld	(ChannelOFF), a
		call	inivars
		call	inichips

BeginDeco:
		ld	a, 80h
		ld	(TimeLastChn), a
		ld	a, (SFX_ON)
		ld	(MaskSFX), a
		ld	a, (NumDecLeft)
		ld	b, a
		ld	a, (NumDecInt)
		add	a, b

DecoLoop:				; ...
		cp	4Bh
		jp	c, EndLoopInt
		sub	4Bh
		push	af
		ld	ix, ChnTblSong-46
		xor	a
		ld	(TimeLastChn), a
		ld	a, 80h
		call	DecoChannel
		ld	a, 81h
		call	DecoChannel
		ld	a, 82h
		call	DecoChannel
		xor	a
		call	DecoChannel
		ld	a, 1
		call	DecoChannel
		ld	a, 2
		call	DecoChannel
		ld	a, 3
		call	DecoChannel
		ld	a, 4
		call	DecoChannel
		ld	a, 5
		call	DecoChannel
		ld	a, 6
		call	DecoChannel
		ld	a, 7
		call	DecoChannel
		ld	a, 8
		call	DecoChannel
		pop	af
		jp	DecoLoop
;****************************************************************************

EndLoopInt:				; ...
		ld	(NumDecLeft), a
		ld	a, (SFX_ON)
		or	a
		jr	nz, DecoSFX
		ld	a, (TimeLastChn)
		or	a
		ret	nz
		ld	a, (SONG_ON)
		or	a
		jp	nz, QuitSong
		ld	(ChannelOFF), a
		ret
;****************************************************************************

DecoSFX:				; ...
		ld	ix, ChnSFXPSG1-46
		xor	a
		ld	(TimeLastChn), a
		ld	(MaskSFX), a
		ld	a, 82h
		call	DecoChannel
		ld	a, 81h
		call	DecoChannel
		ld	a, (TimeLastChn)
		or	a
		ret	nz
		ld	(SFX_ON), a
		ret
;****************************************************************************
;Function which	decode a channel

DecoChannel:				; ...
		ld	de, 46
		add	ix, de
		ld	(ChannelAct), a
		and	80h
		ld	b, a
		ld	a, (ChannelAct)
		cp	6
		jr	c, DecoChnMel
		ld	a, (ShdFM_E)	; Channell can be a FM Rhythm channel
		and	20h		; Save FM Rhythm status
		or	b
		ld	b, a

DecoChnMel:				; ...
		ld	a, (ix+0Ch)
		and	0Fh
		or	b
		ld	(ix+0Ch), a
		ld	a, (ix+0)
		or	a
		jp	z, ChangeModeChn; if time decoding is 0	it means that channell is inactive thus	it is only necessary actualize channel mode

		ld	a, 1		; Time of Channel is not finished
		ld	(TimeLastChn), a
		call	PlayEffect	; Make actions for efecct command
		dec	(ix+0)		; Decrement channel count
		bit	7, (ix+0Bh)	; is channel executing a rest?
		jr	nz, DecoChnADSR

		ld	a, (ix+0Ah)	; If timbre time is defined
		cp	(ix+0)
		jr	nz, DecoChnADSR

		or	a		; If time is diferent of 0 mean	that is	reached	maximun	time of	active note
		jr	nz, DecoChnTimeOff; and	is necessary put off channel sound

		ld	a, (ChannelAct)
		add	a, a
		jr	c, DecoChnADSR	; on FM	channels is necessary desactive	note on	final count

DecoChnTimeOff:				; ...
		call	ChangeModeChn	; It is	necesary put on	silence	this channel

DecoChnADSR:				; ...
		ld	a, (ix+0)	; Actions necesary after deal adsr duration
		or	a
		jr	z, DecoNext

		ld	a, (ix+0Dh)	; Is there a adsr definition?
		or	a
		jr	z, WriteAdsrVol

		dec	(ix+0Dh)	; and is it necessary change volumen of	channel	for adsr definition?
		jr	nz, WriteAdsrVol

		ld	a, (ix+10h)	; Change Volumen value
		add	a, (ix+9)
		jr	nc, adsrDef

		cp	(ix+0Fh)	; is sustain level reach?
		jr	c, WriteAdsrVol

		jr	adsrSustain
;****************************************************************************

adsrDef:				; ...
		cp	(ix+0Fh)	; Does adsr rect reach its sustain level?
		jr	z, adsrSustain
		jr	nc, WriteAdsrVol

adsrSustain:				; ...
		ld	(ix+9),	a
		call	WriteVol
		ld	a, (ix+0Eh)
		ld	(ix+0Dh), a
		jr	DecoChnVib
;****************************************************************************

WriteAdsrVol:				; ...
		ld	a, (FadeCtl)
		bit	7, a
		ld	a, (ix+9)
		call	nz, WriteVol	; Write	new volumen if fade is inactive

DecoChnVib:				; ...
		ld	a, (ix+12h)	; Is vib command define?
		or	a
		ret	z

		dec	(ix+12h)
		ret	nz
		ld	a, (ix+13h)	; If time of vib is finished
		ld	(ix+12h), a
		ld	a, (ix+5)	; add lsb frecuency adder
		add	a, (ix+14h)
		ld	(ix+5),	a
		ld	a, (ix+6)
		adc	a, (ix+15h)	; and MSB frecuency adder
		ld	(ix+6),	a
		jp	WriteFrec
;****************************************************************************

DecoNext:				; ...
		xor	a
		ld	(ix+12h), a
		ld	a, (ix+0Eh)
		or	a
		jr	z, DecopOP1
		ld	(ix+0Dh), a
		ld	a, (ix+11h)
		ld	(ix+9),	a

DecopOP1:				; ...
		ld	l, (ix+1)
		ld	h, (ix+2)
		ld	a, (hl)
		or	a
		jp	z, ChangeModeChn
		inc	hl
		ld	(ix+1),	l
		ld	(ix+2),	h
		dec	a
		ld	hl, Table_OP

DecoOP2:				; ...
		cp	(hl)
		jr	c, DecoOP3
		sub	(hl)
		inc	hl
		inc	hl
		inc	hl
		jr	DecoOP2
;****************************************************************************

DecoOP3:				; ...
		inc	hl		; Opcode decodify
		ld	e, (hl)
		inc	hl		; de ->	Address	of opcode routine
		ld	d, (hl)		; a -> parameter of routine
		ld	hl, DecopOP1	; put return address
		push	hl
		push	de
		ret
;****************************************************************************
Table_OP:	db 24h			; ...
		dw OP_play
		db 1
		dw OP_rest
		db 2
		dw OP_moct
		db 8
		dw OP_oct
		db 2
		dw OP_mvol
		db 10h
		dw OP_vol
		db 20h
		dw OP_FMinst
		db 10h
		dw OP_loop
		db 1
		dw OP_endl
		db 10h
		dw OP_adsr
		db 10h
		dw OP_vib
		db 4
		dw OP_XXX
		db 5Bh
		dw OP_time
		db 8
		dw OP_divsus
		db 1
		dw OP_timel
		db 1
		dw OP_loopl
		db 1
		dw OP_FMinstl
		db 1
		dw OP_WriteFM
		db 1
		dw OP_effect
		db 1
		dw OP_par
;****************************************************************************

OP_play:				; ...
		ld	c, (ix+4)
		ld	(ix+4),	a
		ld	hl, table_note
		call	ADD_HL_A4
		ld	a, (ChannelAct)
		cp	80h
		jr	c, OP_playFM

		inc	hl		; On PSG channels is necessary calculate absolute frecuency
		inc	hl
		ld	e, (hl)
		inc	hl
		ld	d, (hl)
		ld	b, (ix+7)
		inc	b

OP_playPSG1:				; ...
		srl	d
		rr	e
		djnz	OP_playPSG1
		jr	nc, OP_playPSG2
		inc	de

OP_playPSG2:				; ...
		ld	(ix+6),	d
		ld	(ix+5),	e
		jr	OP_PlayW
;****************************************************************************

OP_playFM:				; ...
		ld	a, (hl)
		ld	(ix+5),	a
		inc	hl
		ld	a, (hl)
		ld	(ix+6),	a

OP_PlayW:				; ...
		call	WriteFrec
		ld	a, (ix+9)
		call	WriteVol
		ld	a, (ix+0Bh)	; this channel play a rest just	before this play?
		cp	80h
		jr	nc, OP_playEnd

		add	a, 40h		; Put flag of active channel
		jp	p, OP_PlayConf	; It is	necesary reconfigure channel?
		ld	(ix+0Bh), a

OP_PlayConf:				; ...
		call	ChangeModeChn
		call	ActChannel

OP_playEnd:				; ...
		ld	a, (ix+3)	; Put duration of note
		ld	(ix+0),	a
		pop	hl		; Ending decodification	of channel
		ret
;****************************************************************************

OP_rest:				; ...
		ld	(ix+0Ch), 0
		call	ChangeModeChn
		ld	a, (ix+3)
		ld	(ix+0),	a
		pop	hl
		ld	a, (ix+0Bh)	; Channel is active
		add	a, 40h
		ret	p
		and	7Fh		; and play a rest
		ld	(ix+0Bh), a
		ret
;****************************************************************************

OP_moct:				; ...
		or	a
		jr	nz, OP_octADD
		dec	a

OP_octADD:				; ...
		add	a, (ix+7)
		and	7

OP_oct:					; ...
		ld	(ix+7),	a
		ret
;****************************************************************************

OP_mvol:				; ...
		or	a
		jr	nz, OP_volADD
		dec	a

OP_volADD:				; ...
		add	a, (ix+8)
		and	0Fh

OP_vol:					; ...
		ld	(ix+8),	a
		ld	(ix+0Eh), 0	; Clean	adsr data
		ld	(ix+0Dh), 0
		bit	7, (ix+0Ch)
		jr	nz, OP_volEnd	; is a PSG channel?
		ld	b, a
		ld	a, 0Fh
		sub	b

OP_volEnd:				; ...
		ld	(ix+9),	a
		ret
;****************************************************************************

OP_FMinstl:				; ...
		call	GetNextOP

OP_FMinst:				; ...
		bit	7, (ix+0Ch)
		jr	z, OP_FM_INST
		ld	(ix+6),	80h	; Put PSG channel as noise
		ld	(ix+5),	a
		jp	OP_PlayW
;****************************************************************************

OP_FM_INST:				; ...
		cp	10h
		jr	nc, OP_FMintSoft
		ld	(ix+16h), a
		jr	WFMinst2
;****************************************************************************

OP_FMintSoft:				; ...
		ld	(ix+16h), 0	; FM instrument	software
		sub	10h
		ld	(FM_InstSoft), a

WriteFMInst:				; ...
		ld	l, a
		ld	h, 0
		add	hl, hl
		add	hl, hl
		add	hl, hl
		ld	de, (ptable_fmins)
		add	hl, de
		ld	b, 0

WFMinst1:				; ...
		ld	a, (hl)
		inc	hl
		call	WriteFM
		inc	b
		bit	3, b
		jr	z, WFMinst1

WFMinst2:				; ...
		ret
;****************************************************************************

OP_loopl:				; ...
		call	GetNextOP

OP_loop:				; ...
		push	ix
		pop	hl
		ld	de, 2Dh
		add	hl, de
		ld	d, h
		ld	e, l
		dec	hl
		dec	hl
		dec	hl
		ld	bc, 0Ch
		lddr
		inc	hl
		ld	(hl), a
		ld	a, (ix+1)
		inc	hl
		ld	(hl), a
		ld	a, (ix+2)
		inc	hl
		ld	(hl), a
		ret
;****************************************************************************

OP_endl:				; ...
		ld	a, (ix+1Fh)
		or	a
		jr	z, OP_endl1
		dec	a
		jr	z, OP_endl2
		ld	(ix+1Fh), a

OP_endl1:				; ...
		ld	a, (ix+20h)	; It is	necesary other loop iteration
		ld	(ix+1),	a
		ld	a, (ix+21h)
		ld	(ix+2),	a
		ret
;****************************************************************************

OP_endl2:				; ...
		push	ix		; loop cont is finished
		pop	hl
		ld	de, 1Fh
		add	hl, de
		ex	de, hl
		ld	hl, 3
		add	hl, de
		ld	bc, 0Ch
		ldir
		ret
;****************************************************************************

OP_adsr:				; ...
		ld	l, a
		add	a, a
		add	a, l
		ld	hl, (ptable_adsr)
		call	ADD_HL
		ld	a, (hl)
		ld	(ix+0Dh), a
		ld	(ix+0Eh), a
		inc	hl
		ld	a, (hl)
		ld	(ix+0Fh), a
		inc	hl
		ld	a, (hl)
		ld	(ix+10h), a
		ld	a, (ix+9)
		ld	(ix+11h), a
		ret
;****************************************************************************

OP_vib:					; ...
		ld	l, a
		add	a, a
		add	a, l
		ld	hl, (ptable_vib)
		call	ADD_HL
		ld	a, (hl)
		ld	(ix+12h), a
		ld	(ix+13h), a
		inc	hl
		ld	a, (hl)
		ld	(ix+14h), a
		inc	hl
		ld	a, (hl)
		ld	(ix+15h), a
		ret
;****************************************************************************

OP_XXX:					; ...
		sub	2
		jr	c, OP_XXX1
		inc	a

OP_XXX1:				; ...
		add	a, (ix+3)

OP_timel:				; ...
		call	GetNextOP

OP_time:				; ...
		ld	(ix+3),	a
		jr	ActTimeSound
;****************************************************************************

OP_divsus:				; ...
		ld	b, a
		ld	a, (ix+0Bh)
		and	0F0h
		or	b
		ld	(ix+0Bh), a

ActTimeSound:				; ...
		ld	h, (ix+3)
		xor	a
		srl	h
		rra
		srl	h
		rra
		srl	h
		rra
		ld	l, a
		ld	a, (ix+0Bh)
		and	7
		ld	d, 0
		ld	e, a
		call	MulHL_DE
		ld	(ix+0Ah), h
		ret
;****************************************************************************

OP_WriteFM:				; ...
		call	GetNextOP
		ld	b, a
		call	GetNextOP
		jp	WriteFM
;****************************************************************************

OP_effect:				; ...
		call	GetNextOP
		ld	hl, (ptable_effect)
		call	ADD_HL_A4
		ld	a, (hl)
		ld	(ix+17h), a
		inc	hl
		ld	a, (hl)
		ld	(ix+18h), a
		inc	hl
		ld	a, (hl)
		ld	(ix+1Ah), a
		inc	hl
		ld	a, (hl)
		ld	(ix+1Bh), a
		jp	InitEffect
;****************************************************************************

OP_par:					; ...
		call	GetNextOP
		ld	hl, tblParAddress
		call	ADD_HL_A2
		ld	a, (hl)
		inc	hl
		ld	h, (hl)
		ld	l, a
		jp	(hl)
;****************************************************************************
tblParAddress:	dw DisableChannel	; ...
		dw ActiveChannel
		dw DisableSus
		dw EnableSus
		dw ActiveSD_HH
		dw ActiveTOM_TCY
		dw ActiveNoise
		dw DisableNoise
		dw AddUnitsInt
		dw SetTimenSFX
		dw ActiveRhythm
		dw DisableRhythm
;****************************************************************************

DisableChannel:				; ...
		set	6, (ix+0Bh)
		ret
;****************************************************************************

ActiveChannel:				; ...
		ld	a, (ix+0Bh)
		and	37h
		ld	(ix+0Bh), a
		jp	ChangeModeChn
;****************************************************************************

DisableSus:				; ...
		res	5, (ix+0Bh)	; Disable sustain hard on FM channel
		ret
;****************************************************************************

EnableSus:				; ...
		set	5, (ix+0Bh)
		ret
;****************************************************************************

ActiveSD_HH:				; ...
		ld	hl, Rhythm_Mode	; Active SD Instrument
		ld	a, (ChannelAct)
		cp	7
		jr	nz, ActiveHHInst

		res	2, (hl)
		set	3, (hl)
		ret
;****************************************************************************

ActiveHHInst:				; ...
		res	1, (hl)
		set	0, (hl)
		ret
;****************************************************************************

ActiveTOM_TCY:				; ...
		ld	hl, Rhythm_Mode
		ld	a, (ChannelAct)
		cp	7
		jr	nz, ActiveTCY

		set	2, (hl)
		res	3, (hl)
		ret
;****************************************************************************

ActiveTCY:				; ...
		set	1, (hl)
		res	0, (hl)
		ret
;****************************************************************************

ActiveNoise:				; ...
		res	0, (ix+0Ch)
		ret
;****************************************************************************

DisableNoise:				; ...
		set	0, (ix+0Ch)
		ret
;****************************************************************************

AddUnitsInt:				; ...
		call	GetNextOP	; Add units of time on each interrupt
		ld	(NumDecInt), a
		ret
;****************************************************************************

SetTimenSFX:				; ...
		call	GetNextOP	; Puts number of interrupt that	are needed for begining	of effect
		ld	(ix+1Eh), a
		ret
;****************************************************************************

ActiveRhythm:				; ...
		ld	a, 20h
		ld	(ShdFM_E), a
		ld	b, 0Eh
		call	WriteFM
		ret
;****************************************************************************

DisableRhythm:				; ...
		xor	a
		ld	(ShdFM_E), a
		ld	b, 0Eh
		call	WriteFM
		ret
;****************************************************************************
		db 18h
		db 0FEh
;****************************************************************************
;a -> New volumen level

WriteVol:				; ...
		push	hl
		push	bc
		push	de
		ld	c, a
		ld	a, (FadeCtl)
		and	80h
		jr	z, WVolChip
		ld	hl, FadeNumPass
		bit	7, (ix+0Ch)
		jr	z, WVolPSG
		ld	a, c
		sub	(hl)
		jr	nc, WVolPSG1
		xor	a
		jr	WVolPSG1
;****************************************************************************

WVolPSG:				; ...
		ld	a, c
		add	a, (hl)
		cp	0Fh
		jr	c, WVolPSG1
		ld	a, 0Fh

WVolPSG1:				; ...
		ld	c, a

WVolChip:				; ...
		ld	a, (SilenceFlag)
		or	a
		jr	nz, WriteVolEnd
		ld	a, (ChannelAct)
		cp	80h
		jr	c, WVolFM
		ld	b, a
		ld	a, (MaskSFX)
		and	b
		jr	nz, WriteVolEnd
		ld	a, b
		add	a, 88h
		ld	b, a
		ld	a, c
		call	WritePSG
		jr	WriteVolEnd
;****************************************************************************

WVolFM:					; ...
		bit	5, (ix+0Ch)
		jr	z, VolFM_Mel	; Is a FM channel Ryhthm?
		cp	7
		jr	c, VolFM_Mel
		jr	z, VolFM_HH	; Is HH	Channel

		ld	a, c		; Is SD	Channel
		ld	(SD_VOL), a
		add	a, a
		add	a, a
		add	a, a
		add	a, a
		ld	c, a
		ld	a, (HH_VOL)
		jr	VolFM_WR
;****************************************************************************

VolFM_HH:				; ...
		ld	a, c
		ld	(HH_VOL), a
		ld	a, (SD_VOL)
		add	a, a
		add	a, a
		add	a, a
		add	a, a

VolFM_WR:				; ...
		or	c		; Write	register #37 (HH and SD	voluemn)
		ld	b, 37h
		call	WriteFM
		rrca
		rrca
		rrca
		rrca
		inc	b
		jr	WFM_Vol
;****************************************************************************

VolFM_Mel:				; ...
		add	a, 30h		; Write	volumen	in a FM	melody channel
		ld	b, a
		ld	a, (ix+16h)
		add	a, a
		add	a, a
		add	a, a
		add	a, a
		or	c

WFM_Vol:				; ...
		call	WriteFM

WriteVolEnd:				; ...
		pop	de
		pop	bc
		pop	hl
		ret
;****************************************************************************
;Actualize hardware of a channel with tables valours after a play command

ActChannel:				; ...
		ld	a, (SilenceFlag)
		or	a
		ret	nz
		push	bc
		ld	a, (ChannelAct)
		cp	80h
		jr	nc, ActChnPSG

		bit	5, (ix+0Ch)
		jr	z, ActChnFM_m

		call	PutRhythm
		ld	b, a
		ld	a, (ShdFM_E)
		or	b
		ld	(ShdFM_E), a
		ld	b, 0Eh
		call	WriteFM
		jp	ChgChnModeEnd
;****************************************************************************

ActChnFM_m:				; ...
		add	a, 10h		; FM is	used on	mode melody
		ld	b, a
		ld	a, (ix+5)
		call	WriteFM
		ld	a, b
		add	a, 10h
		ld	b, a
		ld	a, (ix+7)
		add	a, a
		or	(ix+6)
		or	10h
		call	WriteFM
		set	4, (ix+0Bh)
		jr	ActChnSFX
;****************************************************************************

ActChnPSG:				; ...
		ld	b, a
		ld	a, (MaskSFX)
		and	b
		jr	nz, ActChnSFX
		ld	a, b
		and	3
		add	a, a
		jr	nz, ActChnPSG1
		ld	a, 1

ActChnPSG1:				; ...
		ld	c, a
		cpl
		bit	0, (ix+0Ch)
		jr	z, ActChnPSG2	; PSG noise?
		ld	c, 0

ActChnPSG2:				; ...
		bit	7, (ix+6)
		jr	z, ActChnPSGn
		rlca
		rlca
		rlca
		jr	ActChnPSG_7
;****************************************************************************

ActChnPSGn:				; ...
		rlc	c		; Actualize noise PSG channell
		rlc	c
		rlc	c

ActChnPSG_7:				; ...
		ld	b, a
		ld	a, (ShdPSG_7)
		and	b
		or	c
		ld	(ShdPSG_7), a
		ld	b, 7
		call	WritePSG

ActChnSFX:				; ...
		pop	bc		; does action for effect command
		bit	7, (ix+17h)
		ret	z
		ld	a, (ix+1Eh)
		or	a
		jr	z, acSFX_n1E	; Is there time	for type 0  of effect?
		ld	(ix+1Ch), a
		set	6, (ix+17h)
		ret
;****************************************************************************

acSFX_n1E:				; ...
		bit	2, (ix+17h)	; Effect command with b7 of +17h set and no +1e	value
		call	nz, InitEffect
		ld	a, (ix+19h)
		jp	ApplyEffect
;****************************************************************************

ChangeModeChn:				; ...
		push	bc
		ld	a, (ChannelAct)
		cp	80h
		jr	c, ChgModeFM

		ld	b, a
		ld	a, (MaskSFX)
		and	b
		jr	nz, ChgChnModeEnd

		ld	a, b
		ld	c, 9
		and	3
		jr	z, ChgModePSG_W

		sla	c
		dec	a
		jr	z, ChgModePSG_W
		sla	c

ChgModePSG_W:				; ...
		bit	0, (ix+0Ch)
		jr	nz, ChgChnModeEnd
		ld	a, (ShdPSG_7)
		or	c
		ld	(ShdPSG_7), a
		ld	b, 7
		call	WritePSG
		jr	ChgChnModeEnd
;****************************************************************************

ChgModeFM:				; ...
		bit	5, (ix+0Ch)
		jr	z, ChgModeFM_Mel
		call	PutRhythm
		cpl
		ld	b, a
		ld	a, (ShdFM_E)
		and	b
		ld	(ShdFM_E), a
		ld	b, 0Eh
		call	WriteFM
		jr	ChgChnModeEnd
;****************************************************************************

ChgModeFM_Mel:				; ...
		add	a, 20h		; It is	a melodyc FM channel
		ld	b, a
		ld	a, (ix+7)
		add	a, a
		or	(ix+6)
		ld	c, a
		ld	a, (ix+0Bh)
		and	20h
		or	c
		call	WriteFM
		res	4, (ix+0Bh)

ChgChnModeEnd:				; ...
		pop	bc
		ret
;****************************************************************************
;Return	value for configuring channel as Rhythm	as indicate

PutRhythm:				; ...
		sub	6
		ld	b, a
		ld	a, 10h
		ret	z
		ld	a, (Rhythm_Mode)
		dec	b
		jr	nz, PutRhythm1
		and	0Ch
		ret
;****************************************************************************

PutRhythm1:				; ...
		and	3
		ret
;****************************************************************************

WriteFrec:				; ...
		push	hl
		ld	a, (ChannelAct)
		cp	80h
		jr	c, WFrecPSG
		ld	h, (ix+6)
		jr	WFrecFM
;****************************************************************************

WFrecPSG:				; ...
		ld	a, (ix+7)
		add	a, a
		or	(ix+6)
		ld	h, a

WFrecFM:				; ...
		ld	l, (ix+5)
		call	WriteFrecPar
		pop	hl
		ret
;****************************************************************************

WriteFrecPar:				; ...
		push	bc
		ld	a, (ChannelAct)
		cp	80h
		jr	c, WriteFrecFM
		ld	b, a
		ld	a, (MaskSFX)
		and	b
		jr	nz, WrtFrecEnd
		bit	7, h
		jr	nz, WFrcPSG_Noise
		sla	b
		ld	a, l
		call	WritePSG
		inc	b
		ld	a, h
		jr	WriteFrecPSG1
;****************************************************************************

WFrcPSG_Noise:				; ...
		ld	b, 6
		ld	a, l

WriteFrecPSG1:				; ...
		call	WritePSG
		jr	WrtFrecEnd
;****************************************************************************

WriteFrecFM:				; ...
		bit	5, (ix+0Ch)
		jr	z, WrtFrecFM_W	; Is a rhythm channel?
		cp	7
		jr	c, WrtFrecFM_W	; Is one of multiplexed	rhythm channel?

		ld	a, (Rhythm_Mode)
		and	9
		ld	a, 7
		jr	nz, WrtFrecFM_W
		ld	a, 8

WrtFrecFM_W:				; ...
		add	a, 10h		; Write	new frecuency on OPLL chip
		ld	b, a
		ld	a, l
		call	WriteFM
		ld	a, b
		add	a, 10h
		ld	b, a
		ld	a, (ix+0Bh)	; Active KEY on	channel
		and	10h
		or	h
		call	WriteFM

WrtFrecEnd:				; ...
		pop	bc
		ret
;****************************************************************************

GetNextOP:				; ...
		ld	h, (ix+2)
		ld	l, (ix+1)
		ld	a, (hl)
		inc	hl
		ld	(ix+2),	h
		ld	(ix+1),	l
		ret
;****************************************************************************

InitEffect:				; ...
		ld	a, (ix+17h)
		and	3
		ld	hl, TjmpInitEffect
		call	ADD_HL_A2
		ld	a, (hl)
		inc	hl
		ld	h, (hl)
		ld	l, a
		jp	(hl)
;****************************************************************************
TjmpInitEffect:	dw initSFXF0		; ...
		dw initSFXF1
		dw iniSFXF2
		dw iniSFXF2
;****************************************************************************

initSFXF0:				; ...
		xor	a
		ld	(ix+1Dh), a
		ld	(ix+1Ch), a
		ld	(ix+19h), a
		ret
;****************************************************************************

initSFXF1:				; ...
		ld	a, (ix+18h)
		ld	(ix+19h), a
		ld	a, (ix+1Bh)
		ld	(ix+1Dh), a
		ld	a, (ix+1Ah)
		ld	(ix+1Ch), a

		ld	a, (ix+18h)
		or	a
		jp	m, InitSFX1_1
		bit	4, (ix+17h)
		jr	nz, InitSFX1_2
		jr	InitSFX1_3
;****************************************************************************

InitSFX1_1:				; ...
		bit	4, (ix+17h)
		jr	nz, InitSFX1_3

InitSFX1_2:				; ...
		neg
		ld	(ix+18h), a

InitSFX1_3:				; ...
		ld	(ix+19h), a
		ret
;****************************************************************************

iniSFXF2:				; ...
		call	initSFXF0
		ld	a, (ix+18h)
		or	a
		jp	m, InitSFX2_1
		bit	4, (ix+17h)
		jr	nz, InitSFX2_2
		ret
;****************************************************************************

InitSFX2_1:				; ...
		bit	4, (ix+17h)
		ret	nz

InitSFX2_2:				; ...
		neg
		ld	(ix+18h), a
		ld	h, (ix+1Bh)
		ld	l, (ix+1Ah)
		call	NegHL
		ld	(ix+1Bh), h
		ld	(ix+1Ah), l
		ret
;****************************************************************************
;This routine makes all	actions	necesary for effect command on each decodification of channell

PlayEffect:				; ...
		ld	a, (ix+17h)
		or	a
		ret	p

		bit	6, a
		jr	z, PlayEffectJ	; Is it	necessary init effect?

		dec	(ix+1Ch)
		ret	nz
		call	InitEffect
		res	6, (ix+17h)

PlayEffectJ:				; ...
		ld	a, (ix+17h)
		and	3
		ld	hl, TblPlaySFX
		call	ADD_HL_A2
		ld	a, (hl)
		inc	hl
		ld	h, (hl)
		ld	l, a
		jp	(hl)
;****************************************************************************

TblPlaySFX:	dw PlaySFXF0		; ...
		dw PlaySFXF1
		dw PlaySFXF2
		dw PlaySFXF2
;****************************************************************************

PlaySFXF0:				; ...
		ld	a, (ix+1Ch)
		add	a, (ix+1Ah)
		ld	l, a
		ld	a, (ix+1Dh)
		adc	a, (ix+1Bh)
		ld	h, a
		call	CompareS
		jr	nc, PlaySFX0_1
		ld	h, (ix+18h)
		ld	l, 0
		call	NegHL

PlaySFX0_1:				; ...
		ld	a, h
		cp	(ix+19h)	; call only if value has change
		call	nz, ApplyEffect
		ld	(ix+1Dh), h
		ld	(ix+1Ch), l
		ret
;****************************************************************************

PlaySFXF1:				; ...
		ld	l, (ix+1Ch)
		ld	h, (ix+1Dh)
		dec	hl
		ld	a, h
		or	l
		jr	nz, PlaySFX1_1
		ld	a, (ix+18h)
		neg
		ld	(ix+18h), a
		call	ApplyEffect
		ld	h, (ix+1Bh)
		ld	l, (ix+1Ah)

PlaySFX1_1:				; ...
		ld	(ix+1Ch), l
		ld	(ix+1Dh), h
		ret
;****************************************************************************

PlaySFXF2:				; ...
		ld	a, (ix+1Ch)
		add	a, (ix+1Ah)
		ld	l, a
		ld	a, (ix+1Dh)
		adc	a, (ix+1Bh)
		ld	h, a
		call	CompareS
		jr	nc, PlaySFX2_1
		ex	de, hl
		ld	a, (ix+18h)
		neg
		ld	(ix+18h), a
		ld	h, (ix+1Bh)
		ld	l, (ix+1Ah)
		call	NegHL
		ld	(ix+1Ah), l
		ld	(ix+1Bh), h
		ex	de, hl

PlaySFX2_1:				; ...
		ld	a, h
		cp	(ix+19h)
		call	nz, ApplyEffect
		ld	(ix+1Ch), l
		ld	(ix+1Dh), h
		ret
;****************************************************************************

ApplyEffect:				; ...
		push	hl
		ld	(ix+19h), a
		bit	3, (ix+17h)	; Is volumen or	frecuency effect?
		jr	nz, FrecSFX

		add	a, (ix+9)	; Volumen effect
		ld	b, a
		ld	a, (ChannelAct)
		cp	80h
		ld	a, b
		jr	c, VolSFX_FM

		cp	10h
		jr	VolSFX_W
;****************************************************************************

VolSFX_FM:				; ...
		cp	80h

VolSFX_W:				; ...
		call	c, WriteVol	; Write	new volumen if there is	in adecuate range
		pop	hl
		ret
;****************************************************************************

FrecSFX:				; ...
		ld	l, a		; frecuency effect
		and	80h
		jr	z, FrecSFX1
		ld	a, 0FFh		; If is	a negative number then expand sign

FrecSFX1:				; ...
		ld	h, a
		ld	a, (ix+5)
		add	a, l
		ld	l, a
		ld	a, (ix+6)
		adc	a, h
		ld	h, a

		ld	a, (ChannelAct)
		cp	80h
		jr	nc, FrecSFX_W
		ld	a, (ix+7)	; if is	a FM channel is	necesary add octave
		add	a, a		; shift	one position
		or	h		; and add lsb of frecuency
		ld	h, a

FrecSFX_W:				; ...
		call	WriteFrecPar
		pop	hl
		ret
;****************************************************************************
;Output: C -> 0	if ix+24 is maior than h

CompareS:				; ...
		bit	7, (ix+18h)
		jr	nz, CompareS1
		ld	a, h
		or	a
		ret	m
		sub	(ix+18h)
		ret	z
		ccf
		ret
;****************************************************************************

CompareS1:				; ...
		ld	a, h
		or	a
		ret	p
		sub	(ix+18h)
		ret
;****************************************************************************

NegHL:					; ...
		ld	a, h
		cpl
		ld	h, a
		ld	a, l
		cpl
		ld	l, a
		inc	hl
		ret
;****************************************************************************



ADD_HL_A4:				; ...
		add	a, a
		jr	nc, ADD_HL_A2
		inc	h

ADD_HL_A2:				; ...
		add	a, a
		jr	nc, ADD_HL
		inc	h

ADD_HL:					; ...
		add	a, l
		jr	nc, loc_0_8A22
		inc	h

loc_0_8A22:				; ...
		ld	l, a
		ret
;****************************************************************************

MulHL_DE:				; ...
		push	bc
		ld	c, e
		ld	b, d
		ex	de, hl
		ld	hl, 0

MUL1:					; ...
		srl	b
		rr	c
		jr	nc, Mul2
		add	hl, de

Mul2:					; ...
		sla	e
		rl	d
		ld	a, b
		or	c
		jr	nz, MUL1
		pop	bc
		ret
;****************************************************************************
table_note:	db 0AAh, 0, 0FCh, 1Ah,	0ACh, 0, 0B7h, 1Ah; ...
		db 0ADh, 0, 73h, 1Ah, 0B4h, 0,	7Ah, 19h
		db 0B6h, 0, 39h, 19h, 0B7h, 0,	0F9h, 18h
		db 0BEh, 0, 14h, 18h, 0C0h, 0,	0D6h, 17h
		db 0C2h, 0, 9Ah, 17h, 0CAh, 0,	0B3h, 16h
		db 0CCh, 0, 79h, 16h, 0CEh, 0,	40h, 16h
		db 0D6h, 0, 6Dh, 15h, 0D8h, 0,	36h, 15h
		db 0DAh, 0, 0,	15h, 0E3h, 0, 39h, 14h,	0E5h
		db 0, 5, 14h, 0E7h, 0,	0D3h, 13h, 0F0h
		db 0, 16h, 13h, 0F2h, 0, 0E5h,	12h, 0F5h
		db 0, 0B5h, 12h, 0FEh,	0, 4, 12h, 1, 1
		db 0D6h, 11h, 3, 1, 0A9h, 11h,	0Dh, 1,	1
		db 11h, 10h, 1, 0D6h, 10h, 13h, 1, 0ABh
		db 10h, 1Dh, 1, 0Dh, 10h, 20h,	1, 0E4h
		db 0Fh, 23h, 1, 0BBh, 0Fh, 2Eh, 1, 26h
		db 0Fh, 32h, 1, 0FFh, 0Eh, 35h, 1, 0D9h
		db 0Eh, 40h, 1, 4Ch, 0Eh, 44h,	1, 28h,	0Eh
		db 47h, 1, 4, 0Eh

ptable_adsr:    dw  Table_adsr	    ; ...
ptable_vib:	dw Table_vib		; ...
ptable_effect:	dw Table_effect	; ...
ptable_fmins:	dw Table_fmins		; ...

Start_REL:  equ   $

REL_Tlast_FM:	db 50h		; Time of last FM access
REL_Tmsx:		db 0

REL_ChannelOFF:     db    0		    ; ...
REL_TimeLastChn:	db 0			; ...
REL_FadeOutRest:	db 0			; ...
					; 80h allow decodification follow on silence
REL_SilenceFlag:	db 0			; ...
					; Flag that indicate that driver is on silence mode
REL_SONG_ON:	db 0			; ...
REL_SFX_ON:		db 0			; ...
REL_MaskSFX:	db 0			; ...
					; Used for inhibit PSG1	and PSG2 when a	SFX is playing
REL_FadeContAct:	db 0			; ...
					; Cont number of ints sinde last change	volumen	make for fade routine
REL_FadeNumPass:	db 0			; ...
					; Cont Number of volumen changes for Fade routine
REL_FadeCtl:	db 0			; ...
REL_ChannelAct:	db 8			; ...
REL_ShdPSG_7:	db 0BFh		; ...
REL_FM_InstSoft:	db 0			; ...
					; Number of soft FM define
REL_ChnSFXPSG1:	db 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0; ...
		db 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0; PSG1
		db 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0,	0, 0, 0
REL_ChnSFXPSG2:	db 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0; PSG2
		db 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0,	0, 0, 0
REL_ChnTblSong:	db 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0A0h; ...
		db 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0; PSG0
		db 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0,	0, 0, 0
		db 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0A0h; PSG1
		db 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0,	0, 0, 0
		db 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0A0h; PSG2
		db 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0,	0, 0, 0
		db 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0; FM0
		db 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0,	0, 0, 0
		db 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0; FM1
		db 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0,	0, 0, 0
		db 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0; FM2
		db 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0,	0, 0, 0
		db 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0; FM3
		db 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0,	0, 0, 0
		db 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0; FM4
		db 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0,	0, 0, 0
		db 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0; FM5
		db 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0,	0, 0, 0
		db 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	20h; FM6
		db 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0,	0, 0, 0
		db 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	20h; FM7
		db 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0,	0, 0, 0
		db 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	20h; FM8
		db 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0,	0, 0, 0
		db 0
		db 0
REL_ShdFM_E:	db 20h			; ...
REL_Rhythm_Mode:	db 9			; ...
					; Indicate Rhythm instrument configuration (b0-b4 0=OFF	1=ON)
REL_HH_VOL:		db 0			; ...
					; Volumen of FM	HD instrument
REL_SD_VOL:		db 0			; ...
					; Volumen of FM	SD instrument
REL_NumDecInt:	db 4Bh			; ...
					; Multipli of #4b does some iteration of main loop of decodification on	each interrupt
REL_NumDecLeft:	db 0			; ...
					; Number of units of decodification that remaining from	last interrupt calling
REL_ShadowVars:	db 0FFh, 0, 0FFh, 0FFh, 0, 0FFh, 0, 0,	0FFh; ...
		db 0, 0FFh, 0FFh, 0, 0FFh, 0, 0, 0FFh,	0
		db 0FBh, 0FFh,	0, 0FFh, 0, 0, 0EFh, 0,	0FFh
		db 0FFh, 0, 0FFh, 0, 0, 0DFh, 0, 7Fh, 0FFh
		db 0, 0FFh, 0,	0, 0FFh, 0, 0FFh, 0FFh,	0
		db 0FFh, 90h, 0, 0FFh,	0, 0FFh, 0FFh, 0
		db 0FFh, 0, 0,	0FFh, 0, 0FFh, 0FFh, 0,	0FFh
		db 0, 0, 0FFh,	0, 0FFh, 0FFh, 0, 0FFh,	0
		db 0, 0FFh, 0,	0FFh, 0FFh, 80h, 0FFh, 0
		db 0, 0FFh, 0,	8Fh, 0FFh, 0, 0FFh, 0, 0
		db 0FFh, 0, 0FFh, 0FFh, 0, 0FFh, 0, 0,	0FFh
		db 0, 7Fh, 0FFh, 0, 0FFh, 0, 0, 0FFh, 0
		db 0FFh, 0FFh,	0, 0FFh, 0, 0, 0FFh, 0,	0FFh
		db 0FFh, 0, 0FFh, 0, 0, 0FFh, 0, 0FFh,	0FFh
		db 0, 0FFh, 0,	0, 0FFh, 0, 0FFh, 0FFh,	0
		db 0FFh, 0, 0,	0FFh, 0, 0FFh, 0FFh, 0,	0FFh
		db 0, 0, 0FFh,	0, 0FFh, 7Fh, 0, 0FFh, 0
		db 0, 0FFh, 0,	0FFh, 0FFh, 0, 0FFh, 0,	0
		db 0FFh, 0, 0FFh, 0FFh, 0, 0FFh, 0, 0,	0FFh
		db 0, 0FFh, 0FFh, 0, 0FFh, 0, 0, 0FFh,	0
		db 0FFh, 0FFh,	0, 0FFh, 0, 0, 0FFh, 0,	0FFh
		db 0FFh, 0, 0FFh, 0, 0, 0FFh, 0, 0FFh,	0FFh
		db 0, 0FFh, 0,	0, 0FFh, 0, 0FFh, 0FFh,	0
		db 0FFh, 0, 0,	0FFh, 0, 0FFh, 0FFh, 0,	0FFh
		db 0, 0, 0FFh,	0, 0FFh, 0FFh, 0, 0FFh,	0
		db 0, 0FFh, 0,	0FFh, 0FFh, 0, 0FFh, 0,	0
		db 0FFh, 0, 0FFh, 0FFh, 0, 0FFh, 0, 0,	0FFh
		db 0, 0FFh, 0FFh, 0, 0FFh, 0, 0, 0FFh,	0
		db 0FFh, 0FFh,	0, 0FFh, 0, 0, 0FFh, 0,	0FFh
		db 0FFh, 0, 0FFh, 0, 0, 0FFh, 0, 0FFh,	0FFh
		db 0, 0FFh, 0,	0, 0FFh, 0, 0FFh, 0FFh,	0
		db 0FFh, 0, 0,	0FFh, 0, 0FFh, 0FFh, 0,	0FFh
		db 0, 0, 0FFh,	0, 0FFh, 0FFh, 0, 0FFh,	0
		db 0, 0FFh, 0,	0FFh, 0FFh, 0, 0FFh, 0,	0
		db 0FFh, 0, 0FFh, 0FFh, 0, 0FFh, 0, 0,	0FFh
		db 0, 0FFh, 0FFh, 0, 0FFh, 0, 0, 0FFh,	0
		db 0FFh, 0FFh,	0, 0FFh, 0, 0, 0FFh, 0,	0FFh
		db 0FFh, 0, 0FFh, 0, 0, 0FFh, 0, 0FFh,	0FFh
		db 0, 0FFh, 0,	0, 0FFh, 0, 0FFh, 0FFh,	0
		db 0FFh, 0, 0,	0FFh, 0, 0FFh, 0FFh, 0,	0FFh
		db 0, 0, 0FFh,	0, 0FFh, 0FFh, 0, 0FFh,	0
		db 0, 0FFh, 0,	0FFh, 0FFh, 0, 0FFh, 0,	0
		db 0FFh, 0, 0FFh, 0FFh, 0, 0FFh, 0, 0,	0FFh
		db 0, 0FFh, 0FFh, 0, 0FFh, 0, 0, 0FFh,	0
		db 0FFh, 0FFh,	0, 0FFh, 0, 0, 0FFh, 0,	0FFh
		db 77h, 0, 0FFh, 0, 0,	0FFh, 0, 0FFh, 0FFh
		db 0, 0FFh, 0,	0, 0FFh, 0, 0FFh, 0FFh,	0
		db 0FFh, 0, 0,	0FFh, 0, 0FFh, 0FFh, 0,	0FFh
		db 0, 0, 0FFh,	0, 7Fh,	0FFh, 0, 0FFh, 0
		db 0, 0FFh, 0,	0FFh, 0FFh, 0, 0FFh, 0,	0
		db 0FFh, 0, 0FFh, 0FFh, 10h, 0FFh, 0, 0
		db 0FFh, 0, 0FFh, 0FFh, 0, 0FFh, 0, 0,	0FFh
		db 0, 0FFh, 0FFh, 0, 0FFh, 0, 0, 0FFh,	0
		db 0FFh, 0FFh,	0, 0FFh, 0, 0, 0FFh, 0,	0FFh
		db 0FFh, 0, 0FFh, 0, 0, 0FFh, 0, 0FFh,	0FFh
		db 0, 0FFh, 0,	0, 7Fh,	0, 0FFh, 0FFh, 0
		db 0FFh, 0, 0,	0FFh, 0, 0FFh, 0FFh, 0,	0FFh
		db 0, 0, 0FFh,	0, 0FFh, 0FFh, 0, 0FFh,	0
		db 0, 0FFh, 0,	0FFh, 0FFh, 0, 0FFh, 0,	0
		db 0FFh, 0, 0FBh, 0FFh, 0, 0FFh, 0, 0,	0EFh
		db 0, 0FFh, 0FFh, 0, 0FFh, 0, 0, 0FFh,	0
		db 7Fh, 0FFh, 0, 0FFh,	0, 0, 0FFh, 0, 0FFh
		db 0FFh, 0, 0FFh, 90h,	0, 0FFh, 0, 0FFh
		db 0FFh, 0, 0FFh, 0, 0, 0FFh, 0, 0FFh,	0FFh
		db 0, 0FFh, 0,	0, 0FFh, 0, 0FFh, 0FFh,	0
		db 0FFh, 0, 0,	0FFh, 0, 0FFh, 0FFh, 80h
		db 0FFh, 0, 0,	0FFh, 0, 0CFh, 0FFh, 0,	0FFh
		db 0, 0, 0FFh,	0, 0FFh, 0FFh, 0, 0FFh,	0
		db 0, 0FFh, 0,	7Fh, 0FFh, 0, 0FFh, 0, 0
		db 0FFh, 0, 0FFh, 0FFh, 0, 0FFh, 0, 0,	0FFh
		db 0, 0FFh, 0FFh, 0, 0FFh, 0, 0, 0FFh,	0
		db 0FFh, 0FFh,	0, 0FFh, 0, 0, 0FFh, 0,	0FFh
		db 0FFh, 0, 0FFh, 0, 0, 0FFh, 0, 0FFh,	0FFh
		db 0, 0FFh, 0
		db    0
		db 0FFh
		db    0
		db 0FFh

REL_Table_adsr:	db 0Ah, 7, 0FFh
		db 2, 9,0FFh
		db 2, 6, 0FFh
		db 1, 8, 1
		db 2,0Ah,0FFh
		db 1, 0, 0FFh
		db 2,9,1
		db 0Ah,0,0FFh
		db 4,0,0FFh
		db 2,2,0FFh
		db 0Fh,0,0FFh
		db 3,0Bh,0FFh
		db 16h,0,0FFh
		db 3,0Dh,0FFh
		db 1,5, 0FFh
		db 5,7,0FCh

REL_Table_vib:	db 1, 0F6h, 0FFh, 1, 28h, 0, 1, 5, 0, 1; ...
		db 0FBh, 0FFh,	1, 0FEh, 0FFh, 2, 0FFh,	0FFh
		db 2, 3, 0, 3,	2, 0, 3, 0FEh, 0FFh, 1,	32h
		db 0, 1, 0B5h,	0FFh, 1, 0B0h, 0FFh, 1,	14h
		db 0, 1, 3, 0,	1, 0FDh, 0FFh, 0, 0, 0

REL_Table_effect:	db 1, 2, 55h, 4
		db 8Eh, 2, 40h, 1
		db 8Ah, 2,90h, 1
		db 9Ah, 3, 0F4h, 1
		db 82h, 1, 0AAh,0
		db 8Ah, 4, 58h, 2
		db 8Ah, 4, 8Ah, 2
		db 8Ah,52h, 2Ch, 1
		db 8Eh, 2, 40h, 1
		db 8Eh, 2,40h, 1
		db 9Ah, 1, 0FAh, 0
		db 9Ah, 1, 25h, 0
		db 8Ah, 4, 0F0h, 0
		db 9Ah, 0FCh, 10h,0FFh
		db 9Ah, 0C8h, 0, 0FFh
		db 9Ah, 81h, 80h, 0FDh
		db 8Fh, 60h, 1, 0
		db 8Eh, 6, 0, 2
		db 8Fh, 0FFh,1, 0
		db 9Ah, 0Ch, 0E8h, 3
		db 9Eh, 3, 0F4h,1
		db 8Eh, 3, 20h, 3
		db 0,0,0,0
		db 0,0,0,0
		db 0,0,0,0
		db 0,0,0,0
		db 0,0,0,0
		db 0,0,0,0
		db 0,0,0,0
		db 0,0,0,0
		db 0,0,0,0
		db 0,0,0,0

REL_Table_fmins:	db 51h, 61h, 17h, 7, 50h, 0F1h, 5Ch, 0DCh; ...
		db 0, 21h, 1, 7, 0DAh,	0F6h, 5Fh, 0FFh
		db 62h, 41h, 40h, 7, 0FAh, 0F6h, 0AFh,	0FFh
		db 44h, 71h, 87h, 27h,	0FAh, 0F5h, 2Ah
		db 0FDh, 47h, 62h, 24h, 8, 0F3h, 0F3h,	0F9h
		db 0FCh, 63h, 62h, 15h, 0Fh, 0F0h, 0F3h
		db 0FFh, 0FFh,	67h, 60h, 14h, 27h, 0F7h
		db 0F2h, 8Ah, 0FAh, 61h, 62h, 0Eh, 6, 0F5h
		db 0F2h, 0Fh, 0FEh, 12h, 12h, 1Bh, 7, 50h
		db 40h, 10h, 1Ah, 60h,	61h, 8Ah, 20h, 0F3h
		db 0F1h, 3Ah, 0FAh, 43h, 40h, 92h, 7, 0F4h
		db 0F2h, 0AAh,	0AAh, 66h, 64h,	15h, 6,	50h
		db 83h, 0FAh, 0FAh, 0E1h, 62h,	5, 3, 0D0h
		db 72h, 2Bh, 0FBh, 61h, 65h, 40h, 4, 0F4h
		db 0F4h, 1Ah, 0ACh, 61h, 65h, 40h, 4, 0F4h
		db 0F6h, 1Ah, 7Dh, 60h, 61h, 89h, 20h,	0F2h
		db 0F1h, 5Ah, 1Ah, 43h, 61h, 41h, 0, 0F9h
		db 0F6h, 0FCh,	0FCh, 60h, 61h,	1Dh, 7,	0F1h
		db 71h, 1Ah, 0DAh, 6Ch, 22h, 59h, 6, 0E3h
		db 0D2h, 23h, 4Dh, 62h, 62h, 3Fh, 7, 96h
		db 76h, 2Ah, 0Ah, 61h,	61h, 5Ch, 0, 56h
		db 44h, 1Dh, 0Ch, 61h,	62h, 63h, 26h, 36h
		db 54h, 1Dh, 0Ch, 41h,	41h, 21h, 27h, 0F7h
		db 50h, 3, 0E5h, 25h, 60h, 1Eh, 15h, 0FAh
		db 0F3h, 0FCh,	87h, 0,	17h, 18h, 0, 8Fh
		db 9Fh, 8Fh, 1Fh, 6Ah,	61h, 14h, 7Fh, 0F7h
		db 0F2h, 0FFh,	0CFh, 18h, 41h,	5Ch, 5Fh
		db 0F1h, 0F0h,	0FFh, 0FFh, 4, 2, 14h, 8Fh
		db 71h, 0F1h, 0FFh, 0FFh, 6, 1, 1Fh, 2Fh
		db 0F4h, 0F3h,	0FFh, 0FFh, 7Ch, 61h, 1Ch
		db 5Fh, 0F6h, 0F2h, 8Fh, 2Fh, 0Ch, 2, 51h
		db 1Fh, 0F1h, 0F2h, 0FFh, 0FFh, 2, 42h
		db 56h, 26h, 0F1h, 0F0h, 0FFh,	0FFh
		db 0CDh, 0CAh,	80h, 4,	0CDh, 0CAh, 80h
		db 4, 0CDh, 0CAh, 80h,	0C9h, 0Eh, 9, 6
		db 30h, 3Eh, 0Fh, 0CDh, 0D8h, 80h, 4, 0Dh
		db 20h, 0F7h, 0C3h, 31h, 81h, 21h, 0DBh
		db 8Ah, 3Ah



REL_Table_SFX:	dw 0
REL_TableMinc:	dw 0

End_REL:      equ $

section          rdata

Start_RAM:    equ   $

;;; ************************************************************
ChannelOFF:   equ   REL_ChannelOFF - Start_REL + Start_RAM
TimeLastChn:  equ   REL_TimeLastChn - Start_REL + Start_RAM
FadeOutRest:  equ   REL_FadeOutRest - Start_REL + Start_RAM
SilenceFlag:  equ   REL_SilenceFlag - Start_REL + Start_RAM
SONG_ON:      equ   REL_SONG_ON - Start_REL + Start_RAM
SFX_ON:       equ   REL_SFX_ON - Start_REL + Start_RAM
MaskSFX:      equ   REL_MaskSFX - Start_REL + Start_RAM
FadeContAct:  equ   REL_FadeContAct - Start_REL + Start_RAM
FadeNumPass:  equ   REL_FadeNumPass - Start_REL + Start_RAM
FadeCtl:      equ   REL_FadeCtl - Start_REL + Start_RAM
ChannelAct:   equ   REL_ChannelAct - Start_REL + Start_RAM
ShdPSG_7:     equ   REL_ShdPSG_7 - Start_REL + Start_RAM
FM_InstSoft:  equ   REL_FM_InstSoft - Start_REL + Start_RAM
ChnSFXPSG1:   equ   REL_ChnSFXPSG1 - Start_REL + Start_RAM
ChnSFXPSG2:   equ   REL_ChnSFXPSG2 - Start_REL + Start_RAM
ChnTblSong:   equ   REL_ChnTblSong - Start_REL + Start_RAM
ShdFM_E:      equ   REL_ShdFM_E - Start_REL + Start_RAM
Rhythm_Mode:  equ   REL_Rhythm_Mode - Start_REL + Start_RAM
HH_VOL:       equ   REL_HH_VOL - Start_REL + Start_RAM
SD_VOL:       equ   REL_SD_VOL - Start_REL + Start_RAM
NumDecInt:    equ   REL_NumDecInt - Start_REL + Start_RAM
NumDecLeft:   equ   REL_NumDecLeft - Start_REL + Start_RAM
ShadowVars:   equ   REL_ShadowVars - Start_REL + Start_RAM
Table_adsr:   equ   REL_Table_adsr - Start_REL + Start_RAM
Table_vib:    equ   REL_Table_vib - Start_REL + Start_RAM
Table_effect: equ   REL_Table_effect - Start_REL + Start_RAM
Table_fmins:  equ   REL_Table_fmins - Start_REL + Start_RAM
Table_SFX:    equ   REL_Table_SFX - Start_REL + Start_RAM
TableMinc:    equ   REL_TableMinc - Start_REL + Start_RAM
Tlast_FM:     equ   REL_Tlast_FM - Start_REL + Start_RAM
section code
