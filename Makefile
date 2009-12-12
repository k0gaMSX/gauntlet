SRC=gauntlet.asm gaunt1.asm page1.asm page234.asm page567.asm tnilogo.rle
TCF=select.tcf gtitle.tcf gaunt2.tcf gaunt3.tcf
BIN=tnilogo.rle gaunt.2 gaunt.3


test:	gauntlet.rom
	openmsx gauntlet.rom -romtype ascii8 -machine msx2 -ext debugdevice 


gauntlet.rom:	$(SRC) $(TCF) $(BIN) maze.bin
	tniasm.linux gauntlet.asm

gaunt3.tcf: gaunt3.asm deps
	rm -f gaunt.3
	cp gauntlet.3 gaunt.bin
	tniasm.linux gaunt3.asm
	dd if=gaunt.bin of=gaunt.3 bs=1 skip=7
	wine tcpack gaunt.3 gaunt3.tcf


gaunt2.tcf: gaunt2.asm deps
	rm -f gaunt.2
	cp gauntlet.2 gaunt.bin
	tniasm.linux gaunt2.asm
	dd if=gaunt.bin of=gaunt.2 bs=1 skip=7
	wine tcpack gaunt.2 gaunt2.tcf




maze.bin:	maze/maze*



deps: graphic orig data


gauntlet:
	make -C dsk

graphic: 
	make -C gfx


data: set1.col set1.pat set2.pat set3.pat 

orig: gauntlet.1 gauntlet.2 gauntlet.3 



select.tcf gtitle.tcf:	
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

