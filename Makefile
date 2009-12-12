SRC=gauntlet.asm gaunt1.asm page1.asm page234.asm page567.asm tnilogo.rle
TCF=select.tcf gtitle.tcf gaunt2.tcf gaunt3.tcf
BIN=tnilogo.rle
SPR=elf1.spr elf2.spr war1.spr war2.spr val1.spr val2.spr wiz1.spr wiz2.spr hand.spr hand.cc2
TCPACK = wine ~/msx/pctool/tcpack



test:	gauntlet.rom
	openmsx gauntlet.rom -romtype ascii8 -machine msx2 -ext debugdevice 


gauntlet.rom:	$(SRC) $(TCF) $(BIN) maze.bin
	tniasm.linux gauntlet.asm

gaunt3.tcf: gaunt3.asm gauntlet.3 deps
	rm -f gaunt3.tmp
	cp gauntlet.3 gaunt.bin
	tniasm.linux gaunt3.asm
	dd if=gaunt.bin of=gaunt3.tmp bs=1 skip=7
	$(TCPACK) gaunt3.tmp gaunt3.tcf

gaunt2.tcf: gaunt2.asm gaunt.2 deps
	cp gaunt.2 gaunt.bin
	tniasm.linux gaunt2.asm
	dd if=gaunt.bin of=gaunt2.tmp bs=1 skip=7
	$(TCPACK) gaunt2.tmp gaunt2.tcf


gaunt.2:  deps $(SPR)
	cp gauntlet.2 gaunt.2
	dd if=war2.spr of=gaunt.2 conv=notrunc seek=55   bs=1 count=768 
	dd if=val2.spr of=gaunt.2 conv=notrunc seek=1079 bs=1 count=768
	dd if=wiz2.spr of=gaunt.2 conv=notrunc seek=2103 bs=1 count=768
	dd if=elf2.spr of=gaunt.2 conv=notrunc seek=3127 bs=1 count=768	


maze.bin:	maze/maze*



deps: graphic orig data


gauntlet:
	make -C dsk

graphic: 
	make -C gfx


data: set1.col set1.pat set2.pat set3.pat 

orig: gauntlet.1 gauntlet.2 gauntlet.3 




$(SPR):%.spr: graphic 
	cp gfx/$@ .



select.tcf gtitle.tcf:	graphic
	cp gfx/$@ .



set%: data/$@
	cp data/$@ .



gauntlet%: orig/$@
	cp orig/$@ .






.PHONY:

clean:
	rm -f *.cc2
	rm -f *.rom
	rm -f *.tcf 
	rm -f *.src
	rm -f *.bin
	rm -f *.tmp
	rm -f gaunt.?
	rm -f gauntlet.?
	rm -f *.dsk
	rm -f *.pat
	rm -f *.col
	rm -f tniasm.*
	rm -f *.spr
	make -C gfx clean
	make -C dsk clean

