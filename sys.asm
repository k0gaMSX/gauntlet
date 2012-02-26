
;;; ********************************************
;;; Name:       DisPause
;;; Author:     Roberto Vargas Caballero (k0ga)
;;; Date:       18-03-2008
;;; Assembler:  TniASM
;;; Function:   Disable Pause key in R800
;;; Modify:     A,HL
;;; *********************************************

DisPause:

        ld      a,(EXPTBL)
        ld      hl,002Dh        ;
        call    RDSLT
        cp      3
        ret     nz


        ld      a,[FCB1h]       ; disable pause key
        res     1,a
        out     [A7h],a
        ret






;;; Name:       InstallInt
;;; Function:   Install a new ISR
;;; Entry:
;;;     hl -> Pointer to the new ISR
;;; Modify:     hl,de,bc




_InstallInt:
        di
        push    hl
        ld      hl,H.KEYI
        ld      de,oldISR
        ld      bc,5
        ldir

        pop     hl
        ld      a,c3h
        ld      (H.KEYI),a
        ld      (H.KEYI+1),hl
        ret





;;; Name:       DeinstallInt
;;; Function:   Restore default ISR
;;; Entry:
;;;     hl -> Pointer to the new ISR
;;; Modify:     hl,de,bc



_DeinstallInt:
        di
        ld      hl,oldISR
        ld      de,H.KEYI
        ld      bc,5
        ldir
        ret



LoadMazeR:
        ld      de,.MazeFiles-1


.loop:
        push    hl
        push    de
        ld      b,6

.strcmp:
        inc     hl
        inc     de
        ld      a,(de)
        cp      (hl)
        jr      nz,.next
        djnz    .strcmp
        jr      .found

.next:  pop     hl
        ld      de,9
        add     hl,de
        ex      de,hl
        pop     hl
        jr      .loop


.found: pop     de
        pop     hl
        ld      hl,7
        add     hl,de

        ld      a,(hl)
        ld      e,5
        add     a,e

        inc     hl
        ld      e,(hl)
        inc     hl
        ld      d,(hl)

        ex      de,hl
        ld      de,0d000h
        ld      bc,3832
        call    8KLdir
.l:     ret






.MazeFiles:
        db      "MAZE00"
        db      maze00>>16
        dw      maze00&0ffffh

        db      "MAZE01"
        db      maze01>>16
        dw      maze01&0ffffh

        db      "MAZE02"
        db      maze02>>16
        dw      maze02&0ffffh


        db      "MAZE03"
        db      maze03>>16
        dw      maze03&0ffffh

        db      "MAZE04"
        db      maze04>>16
        dw      maze04&0ffffh


        db      "MAZE05"
        db      maze05>>16
        dw      maze05&0ffffh

        db      "MAZE06"
        db      maze06>>16
        dw      maze06&0ffffh

        db      "MAZE07"
        db      maze07>>16
        dw      maze07&0ffffh


        db      "MAZE08"
        db      maze08>>16
        dw      maze08&0ffffh


        db      "MAZE09"
        db      maze09>>16
        dw      maze09&0ffffh

        db      "MAZE10"
        db      maze10>>16
        dw      maze10&0ffffh


        db      "MAZE11"
        db      maze11>>16
        dw      maze11&0ffffh


        db      "MAZE12"
        db      maze12>>16
        dw      maze12&0ffffh


        db      "MAZE13"
        db      maze13>>16
        dw      maze13&0ffffh


        db      "MAZE14"
        db      maze14>>16
        dw      maze14&0ffffh

        db      "MAZE15"
        db      maze15>>16
        dw      maze15&0ffffh

        db      "MAZE16"
        db      maze16>>16
        dw      maze16&0ffffh

        db      "MAZE17"
        db      maze17>>16
        dw      maze17&0ffffh


        db      "MAZE18"
        db      maze18>>16
        dw      maze18&0ffffh


        db      "MAZE19"
        db      maze19>>16
        dw      maze19&0ffffh


        db      "MAZE20"
        db      maze20>>16
        dw      maze20&0ffffh


        db      "MAZE21"
        db      maze21>>16
        dw      maze21&0ffffh


        db      "MAZE22"
        db      maze22>>16
        dw      maze22&0ffffh


        db      "MAZE23"
        db      maze23>>16
        dw      maze23&0ffffh


        db      "MAZE24"
        db      maze24>>16
        dw      maze24&0ffffh

        db      "MAZE25"
        db      maze25>>16
        dw      maze25&0ffffh

        db      "MAZE26"
        db      maze26>>16
        dw      maze26&0ffffh

        db      "MAZE27"
        db      maze27>>16
        dw      maze27&0ffffh

        db      "MAZE28"
        db      maze28>>16
        dw      maze28&0ffffh
        db      "MAZE29"
        db      maze29>>16
        dw      maze29&0ffffh

        db      "MAZE30"
        db      maze30>>16
        dw      maze30&0ffffh




;;; Name:       8KLdir
;;; Author:     Roberto Vargas Caballero
;;; Function:   Ldir from 8k rom ascii8 mapper (6000h-8000h page)
;;; Input:
;;;             hl -> source
;;;             de -> destinity
;;;             bc -> number of bytes
;;;             a -> offset in pages
;;; Modify:     de,hl,bc,af




8KLdir: push    de
        push    af
        ld      a,c
        or      a
        jr      z,.noinc
        inc     a

.noinc:
        ld      c,a
        ld      a,h
        and     e0h
        rlca
        rlca
        rlca
        pop     de
        add     a,d
        pop     de
        ld      (pageldir),a
        ld      (6800h),a

        bit     7,h
        jr      z,.loop
        ld      a,-20h
        add     a,h
        ld      h,a


.loop:
        bit     7,h
        jr      z,.putp2


.putp1: ld      a,-20h
        add     a,h
        ld      h,a

        ld      a,(pageldir)
        inc     a
        ld      (pageldir),a
        ld      (6800h),a


.putp2:
        ld      a,(hl)
        ld      (de),a
        inc     de
        inc     hl
        dec     c
        jp      nz,.loop
        djnz    .loop
        ret


section rdata
.page:          rb      1
section code



; *** MEMORY SUBROUTINES ***

RAM8K:          equ             0
RAM16K:         equ             1
RAM32K:         equ             2
RAM48K:         equ             3
RAM64K:         equ             4

; Especiales para lineal y carga de Roms

NORAML:         equ             0    ; No hay Ram para cargar algo de 16k
RAML16K:        equ             1    ; Podemos cargar algo de 16k
RAML32K:        equ             2    ; Podemos cargar algo de 32k linealmente
RAML48K:        equ             3    ; Podemos cargar algo de 48k linealmente



BOTTOM:                 equ             0FC48h




; *** BUSQUEDA NORMAL DE 1 SLOT CON RAM PARA CADA PAGINA ***

; ---------------------------
; SEARCHRAMNORMAL
; Busca la 64k de Ram
; Independiente slot
; ---------------------------

searchramnormal:
        ld      a,RAM8K
        ld      (ramtypus),a
        ld      a,(EXPTBL)
        ld      (rampage0),a
        ld      (rampage1),a
        ld      (rampage2),a
        ld      (rampage3),a

        xor     a
        ld      (ramcheck0),a
        ld      (ramcheck1),a
        ld      (ramcheck2),a
        ld      (ramcheck3),a


        call    search_slotram  ; Cogemos la Ram de sistema,
                                ;porque el sistema ya entiende que es la mejor
        ld      a,(slotram)
        ld      (rampage3),a

                                ; Comprobar 8k o 16k

        ld      c,0C0h
        call    checkmemdirect
        jr      c,searchramnormalend

        ld      a,RAM16K
        ld      (ramtypus),a



searchramnormal00:
                                ; Buscamos Ram en las otras paginas

        ld      c,00h
        call    checkmem
        jr      c,searchramnormal40

        ld      (rampage0),a
        ld      a,1
        ld      (ramcheck0),a



searchramnormal40:

        ld      c,40h
        call    checkmem
        jr      c,searchramnormal80
        ld      (rampage1),a
        ld      a,1
        ld      (ramcheck1),a


searchramnormal80:

        ld      c,80h
        call    checkmem
        jr      c,searchramnormalend
        ld      (rampage2),a
        ld      a,1
        ld      (ramcheck2),a



searchramnormalend:
                                ; Examinar la cantidad y apuntarla

        ld      a,(ramtypus)
        cp      RAM8K
        ret     z

        ld      a,(ramcheck2)
        or      a
        ret     z

        ld      a,RAM32K
        ld      (ramtypus),a

        ld      a,(ramcheck1)
        or      a
        ret     z


        ld      a,RAM48K
        ld      (ramtypus),a

        ld      a,(ramcheck0)
        or      a
        ret     z

        ld      a,RAM64K
        ld      (ramtypus),a
        ret



; *** BUSQUEDA DE TODOS LOS SLOT CON RAM PARA CADA PAGINA ***






; *** RUTINAS GENERICAS ****


; ---------------------
; CHECKMEM
; C : Page
; Cy : NotFound
; ----------------------

checkmem:

        ld      a,0FFh
        ld      (thisslt),a
checkmem0:
        push    bc
        call    sigslot
        pop     bc
        cp      0FFh
        jr      z,checkmemend

        push    bc
        call    checkmemgen
        pop     bc
        ld      a,(thisslt)
        ret     nc
        jr      checkmem0



checkmemend:
        scf
        ret



; --------------------------
; CHECKMEMGEN
; C : Page
; A : Slot FxxxSSPP
; 00 : 0
; 40:  1
; 80 : 2
; Returns :
; Cy = 1 Not found
; -------------------------------


checkmemgen:
        push    bc
        push    hl
        ld      h,c
        ld      l,010h

checkmemgen1:

        push    af
        call    RDSLT
        cpl
        ld      e,a
        pop     af

        push    de
        push    af
        call    WRSLT
        pop     af
        pop     de

        push    af
        push    de
        call    RDSLT
        pop     bc
        ld      b,a
        ld      a,c
        cpl
        ld      e,a
        pop     af

        push    af
        push    bc
        call    WRSLT
        pop     bc
        ld      a,c
        cp      b
        jr      nz,checkmemgen2
        pop     af
        dec     l
        jr      nz,checkmemgen1
        pop     hl
        pop     bc
        or      a
        ret
checkmemgen2:
        pop     af
        pop     hl
        pop     bc
        scf
        ret


; --------------------------
; CHECKMEMDIRECT
; Chequea si hay memoria
; En pagina C
; Y 16 posiciones por arriba
; ---------------------------

checkmemdirect:

        ld      h,c
        ld      l,010h


checkmemdirect0:
        ld      a,(hl)
        cpl
        ld      c,a
        ld      (hl),a
        ld      a,(hl)
        ld      b,a
        cpl
        ld      (hl),a
        ld      a,b
        cp      c
        jr      nz,checkmemdirectno
        dec     l
        jr      nz,checkmemdirect0
        or      a
        ret
checkmemdirectno:
        scf
        ret


; ---------------------
; SEARCH_SLOTRAM
; Busca el slot de la ram
; Y almacena
; ----------------------

search_slotram:
        call    0138h
        rlca
        rlca
        and     3
        ld      c,a
        ld      b,0
        ld      hl,0FCC1h
        add     hl,bc
        ld      a,(hl)
        and     080h
        or      c
        ld      c,a
        inc     hl
        inc     hl
        inc     hl
        inc     hl
        ld      a,(hl)
        rlca
        rlca
        rlca
        rlca
        and     0Ch
        or      c
        ld      (slotram),a
        ret


; -------------------------------------------------------
; SIGSLOT
; Returns in A the next slot every time it is called.
; For initializing purposes, THISSLT has to be #FF.
; If no more slots, it returns A=#FF.
; --------------------------------------------------------

;       ; this code is programmed by Nestor Soriano aka Konamiman

sigslot:
        ld      a,(thisslt)             ; Returns the next slot, starting by
        cp      0FFh                    ; slot 0. Returns #FF when there are not more slots
        jr      nz,sigslt1              ; Modifies AF, BC, HL.
        ld      a,(EXPTBL)
        and     010000000b
        ld      (thisslt),a
        ret

sigslt1:
        ld      a,(thisslt)
        cp      010001111b
        jr      z,nomaslt
        cp      000000011b
        jr      z,nomaslt
        bit     7,a
        jr      nz,sltexp
sltsimp:
        and     000000011b
        inc     a
        ld      c,a
        ld      b,0
        ld      hl,EXPTBL
        add     hl,bc
        ld      a,(hl)
        and     010000000b
        or      c
        ld      (thisslt),a
        ret

sltexp:
        ld      c,a
        and     000001100b
        cp      000001100b
        ld      a,c
        jr      z,sltsimp
        add     a,000000100b
        ld      (thisslt),a
        ret

nomaslt:
        ld      a,0FFh
        ret
sigslotend:




; *** VARS ***


section rdata

ramcheck0:              rb              1
ramcheck1:              rb              1
ramcheck2:              rb              1
ramcheck3:              rb              1
ramtypus:               rb              1
slotram:                rb              1
thisslt:                rb              1


section code



SetIntroPages:

        call    RomSlotPage2
        xor     a
        ld      (6000h),a
        inc     a
        ld      (6800h),a
        inc     a
        ld      (7000h),a
        inc     a
        ld      (7800h),a
        ret



SetBloadPages:
        call    RomSlotPage2
        ld      a,4
        ld      (6800h),a
        inc     a
        ld      (7000h),a
        inc     a
        ld      (7800h),a
        ret



LoadFirstBload:
        ld      a,5
        call    CHGMOD
        call    VIS_OFF
        call    RomSlotPage2
        ld      hl,gaunt.2
        xor     a
        ld      de,4000h
i:      call    UnTCFV
        call    RamSlotPage2
        ld      hl,4000h
        ld      de,87d0h
        ld      bc,16433
        call    LDIRMV
        jp      87d0h



LoadSecondBload:
	call 	PutSafeInt
        ld      hl,gaunt.3
        xor     a
        ld      de,4000h
        call    UnTCFV
        call    RamSlotPage2
        ld      hl,4000h
        ld      de,8000h
        ld      bc,18977
        call    LDIRMV

        xor     a
        ld      hl,0
        ld      bc,0ffffh
        call    FILVRM
        call    vis_on
        jp      8000h


PutSafeInt:
	di
	ld	b,.code_end - .code
	ld	de,$38
	ld	hl,.code
.loop:
	push	bc
	push	de
	push	hl
	ld	l,(hl)
	ex	de,hl
	ld	a,(rampage0)
	call	WRSLT
	pop	hl
	pop	de
	pop	bc
	inc	de
	inc	hl
	djnz	.loop
	ret

.code:
	push	af
	in	a,(099h)
	pop	af
	ei
	ret
.code_end:

;;; Name:       SaveSlotC
;;; Function:   Save Slot in which cartridge is inserted
;;; Modify:     A,HL,DE


SaveSlotC:
        call    RSLREG
        rrca
        rrca
        and     11b
        ld      e,a
        ld      d,0
        ld      hl,EXPTBL
        add     hl,de
        ld      e,a
        ld      a,(hl)
        and     80h
        or      e
        ld      e,a

        inc     hl
        inc     hl
        inc     hl
        inc     hl
        ld      a,(hl)

        and     00001100b
        or      e
        ld      (romslt),a
        ret


;;; Name:       RamSlotPageX
;;; Function:   Select Slot Cartridge for the page X


RamSlotPage0:
        ld      hl,0
        ld      a,(rampage0)
        jr      slotChg

RamSlotPage1:
        ld      hl,1<<14
        ld      a,(rampage1)
        jr      slotChg

RamSlotPage2:
        ld      hl,2<<14
        ld      a,(rampage2)
        jr      slotChg

RamSlotPage3:
        ld      hl,3<<14
        ld      a,(rampage3)
        jr      slotChg


;;; Name:       RomSlotPageX
;;; Function:   Select Slot Cartridge for the page X


RomSlotPage0:
        ld      hl,0
        ld      a,(romslt)
        jr      SlotChg
RomSlotPage1:
        ld      hl,1<<14
        ld      a,(romslt)
        jr      SlotChg

RomSlotPage2:
        ld      hl,2<<14
        ld      a,(romslt)
        jr      SlotChg

RomSlotPage3:
        ld      hl,3<<14
        ld      a,(romslt)

SlotChg:
        jp      ENASLT




romslt:         equ 0f37fh
rampage0:       equ 0f37eh
rampage1:       equ 0f37dh
rampage2:       equ 0f37ch
rampage3:       equ 0f37bh
pageldir:       equ 0f37ah


section rdata
oldISR:         rb      5

