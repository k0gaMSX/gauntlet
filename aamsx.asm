section code

StartLogo:
                    xor		a
                    ld		(CLIKSW),a
                    ld		(CSRSW),a
                    xor		a
                    ld		(FORCLR),a
                    ld		(BAKCLR),a
                    ld		(BDRCLR),a

                    ld		a,2
                    call	CHGMOD

                    ; Logo!!
                    ld		hl,AAMSX_PAT+8
                    ld		de,0c000h
        	    call    	UnTCF
		    ld		hl,0c000h
		    ld 		de,0
		    ld		bc,3*0800h
		    call	LDIRVM

                    ld		hl,AAMSX_COL+8
                    ld		de,0c000h
        	    call    	UnTCF
		    ld		hl,0c000h
		    ld 		de,02000h
		    ld		bc,3*0800h
		    call	LDIRVM

                    ld		bc,260
.loop:		    push	bc
		    ld 		a,8
                    call	SNSMAT
                    pop        	bc
		    and 	1
		    ret		z
                    ei
                    halt
		    dec		bc
		    ld		a,c
		    or		b
                    jr 		nz,.loop

                    ret


AAMSX_COL:
                    incbin "AAMSX.COL"
AAMSX_PAT:
                    incbin "AAMSX.PAT"
