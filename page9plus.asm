p5size	equ	p5end-p5load
p5padd	equ	16*pagsize-p5size	
p5sizeT equ	p5endf-p5load		

	

section code

org	p5load



section		code			


maze00:		
incbin	"maze/maze00"	
maze01:
incbin	"maze/maze01"
maze02:	
incbin	"maze/maze02"
maze03:	
incbin	"maze/maze03"
maze04:	
incbin	"maze/maze04"
maze05:	
incbin	"maze/maze05"
maze06:	
incbin	"maze/maze06"
maze07:	
incbin	"maze/maze07"
maze08:	
incbin	"maze/maze08"
maze09:	
incbin	"maze/maze09"
maze10:	
incbin	"maze/maze10"
maze11:	
incbin	"maze/maze11"
maze12:	
incbin	"maze/maze12"
maze13:	
incbin	"maze/maze13"
maze14:	
incbin	"maze/maze14"
maze15:	
incbin	"maze/maze15"
maze16:	
incbin	"maze/maze16"
maze17:	
incbin	"maze/maze17"
maze18:	
incbin	"maze/maze18"
maze19:	
incbin	"maze/maze19"
maze20:	
incbin	"maze/maze20"
maze21:	
incbin	"maze/maze21"
maze22:	
incbin	"maze/maze22"
maze23:	
incbin	"maze/maze23"
maze24:	
incbin	"maze/maze24"
maze25:	
incbin	"maze/maze25"
maze26:	
incbin	"maze/maze26"
maze27:	
incbin	"maze/maze27"
maze28:	
incbin	"maze/maze28"
maze29:	
incbin	"maze/maze29"
maze30:	
incbin	"maze/maze30"
	

	
p5end:		ds	p5padd,0
p5endf:		equ $	

%if p5size > pagsize*16
   %warn "Page 9-16 boundary broken"
%endif
	