

gauntlet.dsk: cont/*
	rm -f cont/gauntlet.dsk
	cd cont && wrdsk gauntlet.dsk *
	mv cont/gauntlet.dsk .
	cp gauntlet.dsk ..


.PHONY:
clean:
	rm -f gauntlet.dsk
