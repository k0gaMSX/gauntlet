



test:	gaunt.dsk
	openmsx gaunt.dsk -machine turbor


gaunt.dsk:	gaunt.3 gaunt.2
	rm -f gaunt.dsk
	cp gauntlet.dsk gaunt.dsk
	wrdsk gaunt.dsk gaunt.3
	wrdsk gaunt.dsk gaunt.2

gaunt.3:	gauntlet.3 gaunt1.asm
	cp gauntlet.3 gaunt.bin
	tniasm gaunt1.asm
	mv gaunt.bin gaunt.3

gaunt.2: gauntlet.2 gaunt2.asm
	cp gauntlet.2 gaunt.bin
	tniasm gaunt2.asm
	mv gaunt.bin gaunt.2
