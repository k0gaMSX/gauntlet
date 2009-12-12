SPR=../../sr52spr
spr= $(patsubst %.sr5,%.spr,$(wildcard *.sr5))


all: $(spr) hand.cc2


$(spr): %.spr: %.sr5
	$(SPR) $< 14
	dd if=$(subst sr5,DAT,$<) of=$@ bs=1 count=512

%.cc2: %.spr
	dd if=$< of=$@ bs=1 count=128

.PHONY:

clean:
	rm -f *.cc2
	rm -f *.CC?
	rm -f *.DAT
	rm -f *.spr

