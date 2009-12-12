


all:	select.tcf gtitle.tcf

select.dat:  o.sr5 g-chars.sr5
	rm -f g-chars.dat
	dd if=g-chars.sr5 of=g-chars.dat skip=7 bs=1 count=27136
	dd if=o.sr5 skip=7 bs=1 count=5504 | dd of=g-chars.dat seek=27136 bs=1 count=5504
	mv g-chars.dat select.dat 


select.tcf: select.dat
	wine tcpack select.dat select.tcf
	cp select.tcf ..


gtitle.tcf: g-title.sr5
	rm -f g-title.dat
	dd if=g-title.sr5 of=g-title.dat bs=1 count=27136 skip=7
	wine tcpack g-title.dat gtitle.tcf
	cp gtitle.tcf ..


.PHONY:	

clean:
	rm -f *.tcf  
	rm -f *.dat
	rm -f .??
