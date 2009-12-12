


p3size	equ	p3end-p3load
p3padd	equ	3*pagsize-p3size	
p3sizeT equ	p3endf-p3load		

	

section code

org	p3load	



gaunt.2: equ $
	incbin	"gaunt2.tcf",8

gaunt.3: equ $		
	incbin	"gaunt3.tcf",8

gaunt.4: equ $	
				

section		code			

p3end:		ds	p3padd,0
p3endf:		equ $	

%if p3size > pagsize*3
   %warn "Page 567 boundary broken"
%endif
	