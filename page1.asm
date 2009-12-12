

p1size	equ	p1end-p1load
p1padd	equ	pagsize-p1size	
p1sizeT equ	p1endf-p1load		
	
		
section	code
	org	p1load

	db	'AB'
	dw	Init
	dw	0,0,0,0,0,0,0,0

Init:	
	call	SaveSlotC
	call	RomSlotPage2	
	call	ShowIntro

	ld	hl,gaunt.2
;;; call	LoadBin
	ld	hl,gaunt.3
;;; call	LoadBin
	ret


IntroPages:	db	1,2,3,0
gaunt.2:	db	4,5,0
gaunt.3:	db	6,7,0			
	
	
		


%include "sys.asm"
%include "gaunt1.asm"	

	
section		code			

p1end:	ds	p1padd,0
p1endf:		equ $	

%if p1size > pagsize
   %warn "Page 0 boundary broken"
%endif



	

	



		