

SPRITES = warrior valkiria elf wizard


sprites: 
	make -C warrior
	cp warrior/*.spr .
	make -C valkiria
	cp valkiria/*.spr .
	make -C elf
	cp elf/*.spr .
	make -C wizard
	cp wizard/*.spr .
	make -C hand
	cp hand/*.spr .
	cp hand/*.cc2 .



.PHONY:

clean:
	make -C warrior clean
	make -C elf clean
	make -C valkiria clean
	make -C wizard clean
	make -C hand clean
	rm -f *.spr
	rm -f *.cc2

