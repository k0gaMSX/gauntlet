SRC=gauntlet.asm gaunt1.asm page1.asm page234.asm tnilogo.rle
TCF=select.tcf gtitle.tcf
BIN=tnilogo.rle


test:	gauntlet.rom
	openmsx gauntlet.rom -machine msx2 -ext debugdevice


gauntlet.rom:	$(SRC) $(TCF) 
	tniasm.linux gauntlet.asm

gaunt.3: gaunt3.asm deps
	cp gauntlet.3 gaunt.bin
	tniasm.linux gaunt3.asm
	mv gaunt.bin gaunt.3

gaunt.2: gaunt2.asm deps
	cp gauntlet.2 gaunt.bin
	tniasm.linux gaunt2.asm
	mv gaunt.bin gaunt.2


deps: graphic orig data


gauntlet:
	make -C dsk


graphic: 
	make -C gfx


data: set1.col set1.pat set2.pat set3.pat 

orig: gauntlet.1 gauntlet.2 gauntlet.3 


%.tcf:	
	make -C gfx
	cp gfx/$@ .



set%: data/$@
	cp data/$@ .



gauntlet%: orig/$@
	cp orig/$@ .






.PHONY:

clean:
	rm -f *.tcf 
	rm -f *.src
	rm -f *.bin
	rm -f gaunt.?
	rm -f gauntlet.?
	rm -f *.dsk
	rm -f *.pat
	rm -f *.col
	rm -f tniasm.*
	make -C gfx clean
	make -C dsk clean

