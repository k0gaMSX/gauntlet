%include "tniasm.inc"
%include "z80r800.inc"
%include "z80().inc"
%include "msx.inc"
	


	fname	"gauntlet.rom"



orgcode	4000h
orgrdata 0c000h

	

pagsize: equ 2000h

	
p1load:	equ	4000h
p2load:	equ	6000h	

	
		
		
%include "page1.asm"
%include "page234.asm"

	
		




	