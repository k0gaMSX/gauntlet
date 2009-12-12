



test:	gaunt.dsk
	openmsx gaunt.dsk -machine msx2 -ext debugdevice


gaunt.dsk: gaunt.3 gaunt.2 gaunt.1
	rm -f gaunt.dsk
	cp gauntlet.dsk gaunt.dsk
	wrdsk gaunt.dsk gaunt.3
	wrdsk gaunt.dsk gaunt.2
	wrdsk gaunt.dsk gaunt.1


gaunt.3: gaunt3.asm all-deps
	cp gauntlet.3 gaunt.bin
	tniasm.linux gaunt3.asm
	mv gaunt.bin gaunt.3

gaunt.2: gaunt2.asm all-deps
	cp gauntlet.2 gaunt.bin
	tniasm.linux gaunt2.asm
	mv gaunt.bin gaunt.2

gaunt.1: gaunt1.asm all-deps
	tniasm.linux gaunt1.asm
	mv tniasm.out gaunt.1



all-deps: graphic orig data gauntlet

gauntlet:
	make -C ../dsk

graphic: select.tcf gtitle.tcf


%.tcf:
	make -C ../gfx/ $@
	cp ../gfx/$@ .


%.asm: ../src/$@
	cp ../src/$@ .


orig: ../orig/gauntlet.1 ../orig/gauntlet.2 ../orig/gauntlet.3
	cp ../orig/gauntlet.1 .
	cp ../orig/gauntlet.2 .
	cp ../orig/gauntlet.3 .
	touch orig


data: ../data/set1.col ../data/set1.pat ../data/set2.pat ../data/set3.pat 
	cp ../data/set1.col .
	cp ../data/set1.pat .
	cp ../data/set2.pat .
	cp ../data/set3.pat .
	touch data


.PHONY:

clean:
	rm -f data
	rm -f orig
	rm -f src
	rm -f graphic
	rm -f *.tcf 
	rm -f *.src
	rm -f *.bin
	rm -f gaunt.?
	rm -f gauntlet.?
	rm -f *.dsk
	rm -f *.asm
	rm -f .??*
	rm -f tniasm.*
	make -C ../gfx clean
	make -C ../dsk clean

