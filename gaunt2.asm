%include "z80r800.inc"
%include "z80__.inc"


LdAddress:	equ	87d0h-7

   

	fname	"gaunt.bin",0
	
	forg	9800h-LdAddress
	incbin  "set1.col"
	incbin  "set1.pat"
	incbin  "set2.pat"
	incbin  "set3.pat"
