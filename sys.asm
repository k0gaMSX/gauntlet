
	
;;; ********************************************
;;; Name:	DisPause
;;; Author:	Roberto Vargas Caballero (k0ga)
;;; Date:	18-03-2008
;;; Assembler:	TniASM	
;;; Function:	Disable Pause key in R800
;;; Modify:	A,HL
;;; *********************************************
	
DisPause:	
		
	ld      a,(EXPTBL)
        ld      hl,002Dh	; 
        call    RDSLT
        cp      3
        ret     nz

	
	ld	a,[FCB1h]	; disable pause key
	res	1,a
	out	[A7h],a
	ret



		


;;; Name:	InstallInt
;;; Function:	Install a new ISR
;;; Entry:
;;;	hl -> Pointer to the new ISR
;;; Modify:	hl,de,bc

	


_InstallInt:
	di
	push	hl
	ld	hl,H.KEYI
	ld	de,oldISR
	ld	bc,5	
	ldir	

	pop	hl
	ld	a,c3h
	ld	(H.KEYI),a
	ld	(H.KEYI+1),hl
	ret




		
;;; Name:	DeinstallInt
;;; Function:	Restore default ISR
;;; Entry:
;;;	hl -> Pointer to the new ISR
;;; Modify:	hl,de,bc	


	
_DeinstallInt:
	di
	ld	hl,oldISR
	ld	de,H.KEYI
	ld	bc,5
	ldir
        ret


;;; Name:	SaveSlotC
;;; Function:	Save Slot in which cartridge is inserted
;;; Modify:	A,HL,DE

	
SaveSlotC:	
	call	RSLREG
	rrca
	rrca
	and	11b
	ld	e,a
	ld	d,0
	ld	hl,EXPTBL
	add	hl,de
	ld	e,a
	ld	a,(hl)
	and	80h
	or	e
	ld	e,a
	
	inc	hl
	inc	hl
	inc	hl
	inc	hl
	ld	a,(hl)
	
	and	00001100b
	or	e
	ld	(romslt),a
	ret




LoadBin:
	ex	de,hl
	ld	bc,800h
	ld	hl,6000h
.loop:		
	ld	a,(de)
	or	a
	jr	z,.bload
	ld	(hl),a
	inc	de
	add	hl,bc
	jr	.loop
	
	
.bload:			
	ld	hl,(6000h+1)
	ld	e,l
	ld	d,h
	ld	bc,(6000h+3)
	or	a
	sbc	hl,bc
	ld	c,l
	ld	b,h
	ld	hl,6000h
	ldir
	ld	hl,(6000h)
	jp	(hl)
	
	
	
	
		
	

		
		


	

	

;;; Name:	RomSlotPageX
;;; Function:	Select Slot Cartridge for the page X
	

RomSlotPage0:
	ld	hl,0
	jr	SlotChg
RomSlotPage1:
	ld	hl,1<<14
	jr	SlotChg
			
RomSlotPage2:
	ld	hl,2<<14
	jr	SlotChg
	
RomSlotPage3:
	ld	hl,3<<14
	
SlotChg:		
	ld	a,(romslt)
	jp	ENASLT
	

		
	

	
section	rdata
romslt:		rb	1
oldISR:		rb	5
	
