

SPRITES = warrior valkiria elf wizard


sprites: 
	$(MAKE) -C warrior
	cp warrior/*.spr .
	$(MAKE) -C valkiria
	cp valkiria/*.spr .
	$(MAKE) -C elf
	cp elf/*.spr .
	$(MAKE) -C wizard
	cp wizard/*.spr .
	$(MAKE) -C  -C hand
	cp hand/*.spr .
	cp hand/*.cc2 .



.PHONY:

clean:
	$(MAKE) -C warrior clean
	$(MAKE) -C elf clean
	$(MAKE) -C valkiria clean
	$(MAKE) -C wizard clean
	$(MAKE) -C hand clean
	rm -f *.spr
	rm -f *.cc2

