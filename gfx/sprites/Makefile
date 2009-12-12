

sprites: 
	make -C warrior
	cp warrior/*.spr .
	make -C valkiria
	cp valkiria/*.spr .
	make -C elf
	cp elf/*.spr .
	make -C wizard
	cp wizard/*.spr .


.PHONY:

clean:
	make -C warrior clean
	make -C elf clean
	make -C valkiria clean
	make -C wizard clean
	rm -f *.spr

