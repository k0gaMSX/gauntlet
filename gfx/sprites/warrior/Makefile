SPR=../../sr52spr
spr= $(patsubst %.sr5,%.spr,$(wildcard *.sr5))


all: $(spr)

 
$(spr): %.spr: %.sr5
	$(SPR) $< 
	dd if=$(subst sr5,DAT,$<) of=$@ bs=1 count=768 


.PHONY:

clean:
	rm -f *.CC?
	rm -f *.DAT
	rm -f *.spr

