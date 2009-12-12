%macro LD (BC),A        \%def8 02h\%endmacro
%macro LD A,(BC)        \%def8 0Ah\%endmacro
%macro LD (DE),A        \%def8 12h\%endmacro
%macro LD A,(DE)        \%def8 1Ah\%endmacro
%macro LD (%n),HL       \%def8 22h\%def16 #1\%endmacro
%macro LD HL,(%n)       \%def8 2Ah\%def16 #1\%endmacro
%macro LD (%n),A        \%def8 32h\%def16 #1\%endmacro
%macro INC (HL)         \%def8 34h\%endmacro
%macro DEC (HL)         \%def8 35h\%endmacro
%macro LD (HL),%n       \%def8 36h,#1\%endmacro
%macro LD A,(%n)        \%def8 3Ah\%def16 #1\%endmacro
%macro LD B,(HL)        \%def8 46h\%endmacro
%macro LD C,(HL)        \%def8 4Eh\%endmacro
%macro LD D,(HL)        \%def8 56h\%endmacro
%macro LD E,(HL)        \%def8 5Eh\%endmacro
%macro LD H,(HL)        \%def8 66h\%endmacro
%macro LD L,(HL)        \%def8 6Eh\%endmacro
%macro LD (HL),B        \%def8 70h\%endmacro
%macro LD (HL),C        \%def8 71h\%endmacro
%macro LD (HL),D        \%def8 72h\%endmacro
%macro LD (HL),E        \%def8 73h\%endmacro
%macro LD (HL),H        \%def8 74h\%endmacro
%macro LD (HL),L        \%def8 75h\%endmacro
%macro LD (HL),A        \%def8 77h\%endmacro
%macro LD A,(HL)        \%def8 7Eh\%endmacro
%macro ADD A,(HL)       \%def8 86h\%endmacro
%macro ADC A,(HL)       \%def8 8Eh\%endmacro
%macro SUB (HL) 	\%def8 96h\%endmacro
%macro SBC A,(HL)       \%def8 9Eh\%endmacro
%macro AND (HL) 	\%def8 A6h\%endmacro
%macro XOR (HL) 	\%def8 AEh\%endmacro
%macro OR (HL)  	\%def8 B6h\%endmacro
%macro CP (HL)  	\%def8 BEh\%endmacro
%macro OUT (%n),A 	\%def8 D3h,#1\%endmacro
%macro IN A,(%n)        \%def8 DBh,#1\%endmacro
%macro EX (SP),HL 	\%def8 E3h\%endmacro
%macro JP (HL)  	\%def8 E9h\%endmacro

%macro RLC (HL) \%def16 06CBh\%endmacro
%macro RRC (HL) \%def16 0ECBh\%endmacro
%macro RL (HL)  	\%def16 16CBh\%endmacro
%macro RR (HL)  	\%def16 1ECBh\%endmacro
%macro SLA (HL) \%def16 26CBh\%endmacro
%macro SRA (HL) \%def16 2ECBh\%endmacro
%macro SLL (HL) \%def16 36CBh\%endmacro
%macro SRL (HL) \%def16 3ECBh\%endmacro
%macro BIT %n,(HL)
  %if (#1 >= 0) & (#1 < 8)
    %def8 CBh,46h+8*#1
  %else
    %def16 0
    %error "Illegal bit number"
  %endif
%endmacro
%macro RES %n,(HL)
  %if (#1 >= 0) & (#1 < 8)
    %def8 CBh,86h+8*#1
  %else
    %def16 0
    %error "Illegal bit number"
  %endif
%endmacro
%macro SET %n,(HL)
  %if (#1 >= 0) & (#1 < 8)
    %def8 CBh,C6h+8*#1
  %else
    %def16 0
    %error "Illegal bit number"
  %endif
%endmacro
%macro IN B,(C) 	\%def16 40EDh\%endmacro
%macro OUT (C),B        \%def16 41EDh\%endmacro
%macro LD (%n),BC       \%def16 43EDh,#1\%endmacro
%macro IN C,(C) 	\%def16 48EDh\%endmacro
%macro OUT (C),C        \%def16 49EDh\%endmacro
%macro LD BC,(%n)       \%def16 4BEDh\%def16 #1\%endmacro
%macro IN D,(C) 	\%def16 50EDh\%endmacro
%macro OUT (C),D        \%def16 51EDh\%endmacro
%macro LD (%n),DE       \%def16 53EDh,#1\%endmacro
%macro IN E,(C) 	\%def16 58EDh\%endmacro
%macro OUT (C),E        \%def16 59EDh\%endmacro
%macro LD DE,(%n)       \%def16 5BEDh\%def16 #1\%endmacro
%macro IN H,(C) 	\%def16 60EDh\%endmacro
%macro OUT (C),H        \%def16 61EDh\%endmacro
%macro IN L,(C) 	\%def16 68EDh\%endmacro
%macro OUT (C),L        \%def16 69EDh\%endmacro
%macro IN F,(C) 	\%def16 70EDh\%endmacro
%macro OUT (C),0        \%def16 71EDh\%endmacro
%macro LD (%n),SP       \%def16 73EDh,#1\%endmacro
%macro IN A,(C) 	\%def16 78EDh\%endmacro
%macro OUT (C),A        \%def16 79EDh\%endmacro
%macro LD SP,(%n)       \%def16 7BEDh\%def16 #1\%endmacro
%macro LD (%n),IX       \%def16 22DDh,#1\%endmacro
%macro LD IX,(%n)       \%def16 2ADDh\%def16 #1\%endmacro
%macro INC (IX)         \%def16 34DDh\%def8 0\%endmacro
%macro INC (IX%n)       \%def16 34DDh\%def8 #1\%endmacro
%macro DEC (IX)         \%def16 35DDh\%def8 0\%endmacro
%macro DEC (IX%n)       \%def16 35DDh\%def8 #1\%endmacro
%macro LD (IX),%n       \%def16 36DDh\%def8 0,#1\%endmacro
%macro LD (IX%n),%n     \%def16 36DDh\%def8 #1,#2\%endmacro
%macro LD B,(IX)	\%def16 46DDh\%def8 0\%endmacro
%macro LD B,(IX%n)	\%def16 46DDh\%def8 #1\%endmacro
%macro LD C,(IX)	\%def16 4EDDh\%def8 0\%endmacro
%macro LD C,(IX%n)	\%def16 4EDDh\%def8 #1\%endmacro
%macro LD D,(IX)	\%def16 56DDh\%def8 0\%endmacro
%macro LD D,(IX%n)	\%def16 56DDh\%def8 #1\%endmacro
%macro LD E,(IX)	\%def16 5EDDh\%def8 0\%endmacro
%macro LD E,(IX%n)	\%def16 5EDDh\%def8 #1\%endmacro
%macro LD H,(IX)	\%def16 66DDh\%def8 0\%endmacro
%macro LD H,(IX%n)	\%def16 66DDh\%def8 #1\%endmacro
%macro LD L,(IX)	\%def16 6EDDh\%def8 0\%endmacro
%macro LD L,(IX%n)	\%def16 6EDDh\%def8 #1\%endmacro
%macro LD (IX),B	\%def16 70DDh\%def8 0\%endmacro
%macro LD (IX),C	\%def16 71DDh\%def8 0\%endmacro
%macro LD (IX),D	\%def16 72DDh\%def8 0\%endmacro
%macro LD (IX),E	\%def16 73DDh\%def8 0\%endmacro
%macro LD (IX),H	\%def16 74DDh\%def8 0\%endmacro
%macro LD (IX),L	\%def16 75DDh\%def8 0\%endmacro
%macro LD (IX),A	\%def16 77DDh\%def8 0\%endmacro
%macro LD (IX%n),B	\%def16 70DDh\%def8 #1\%endmacro
%macro LD (IX%n),C	\%def16 71DDh\%def8 #1\%endmacro
%macro LD (IX%n),D	\%def16 72DDh\%def8 #1\%endmacro
%macro LD (IX%n),E	\%def16 73DDh\%def8 #1\%endmacro
%macro LD (IX%n),H	\%def16 74DDh\%def8 #1\%endmacro
%macro LD (IX%n),L	\%def16 75DDh\%def8 #1\%endmacro
%macro LD (IX%n),A	\%def16 77DDh\%def8 #1\%endmacro
%macro LD A,(IX)	\%def16 7EDDh\%def8 0\%endmacro
%macro LD A,(IX%n)	\%def16 7EDDh\%def8 #1\%endmacro
%macro ADD A,(IX)       \%def16 86DDh\%def8 0\%endmacro
%macro ADD A,(IX%n)     \%def16 86DDh\%def8 #1\%endmacro
%macro ADC A,(IX)       \%def16 8EDDh\%def8 0\%endmacro
%macro ADC A,(IX%n)     \%def16 8EDDh\%def8 #1\%endmacro
%macro SUB (IX)         \%def16 96DDh\%def8 0\%endmacro
%macro SUB (IX%n)       \%def16 96DDh\%def8 #1\%endmacro
%macro SBC A,(IX)       \%def16 9EDDh\%def8 0\%endmacro
%macro SBC A,(IX%n)     \%def16 9EDDh\%def8 #1\%endmacro
%macro AND (IX) 	\%def16 A6DDh\%def8 0\%endmacro
%macro AND (IX%n) 	\%def16 A6DDh\%def8 #1\%endmacro
%macro XOR (IX) 	\%def16 AEDDh\%def8 0\%endmacro
%macro XOR (IX%n) 	\%def16 AEDDh\%def8 #1\%endmacro
%macro OR (IX)  	\%def16 B6DDh\%def8 0\%endmacro
%macro OR (IX%n)	\%def16 B6DDh\%def8 #1\%endmacro
%macro CP (IX)  	\%def16 BEDDh\%def8 0\%endmacro
%macro CP (IX%n)	\%def16 BEDDh\%def8 #1\%endmacro
%macro EX (SP),IX       \%def16 E3DDh\%endmacro
%macro JP (IX)  	\%def16 E9DDh\%endmacro
%macro RLC (IX)		\%def16 CBDDh\%def16 0600h\%endmacro
%macro RRC (IX)		\%def16 CBDDh\%def16 0E00h\%endmacro
%macro RL (IX)		\%def16 CBDDh\%def16 1600h\%endmacro
%macro RR (IX)		\%def16 CBDDh\%def16 1E00h\%endmacro
%macro SLA (IX)		\%def16 CBDDh\%def16 2600h\%endmacro
%macro SRA (IX)		\%def16 CBDDh\%def16 2E00h\%endmacro
%macro SLL (IX)		\%def16 CBDDh\%def16 3600h\%endmacro
%macro SRL (IX)		\%def16 CBDDh\%def16 3E00h\%endmacro
%macro RLC (IX%n)	\%def16 CBDDh\%def8 #1,06h\%endmacro
%macro RRC (IX%n)	\%def16 CBDDh\%def8 #1,0Eh\%endmacro
%macro RL (IX%n)	\%def16 CBDDh\%def8 #1,16h\%endmacro
%macro RR (IX%n)	\%def16 CBDDh\%def8 #1,1Eh\%endmacro
%macro SLA (IX%n)	\%def16 CBDDh\%def8 #1,26h\%endmacro
%macro SRA (IX%n)	\%def16 CBDDh\%def8 #1,2Eh\%endmacro
%macro SLL (IX%n)	\%def16 CBDDh\%def8 #1,36h\%endmacro
%macro SRL (IX%n)	\%def16 CBDDh\%def8 #1,3Eh\%endmacro
%macro BIT %n,(IX)	\BIT #1,(IX+0)\%endmacro
%macro RES %n,(IX)	\RES #1,(IX+0)\%endmacro
%macro SET %n,(IX)	\SET #1,(IX+0)\%endmacro
%macro BIT %n,(IX%n)
  %if (#1 >= 0) & (#1 < 8)
    %def16 CBDDh
    %def8 #2,46h+8*#1
  %else
    %def32 0
    %error "Illegal bit number"
  %endif
%endmacro
%macro RES %n,(IX%n)
  %if (#1 >= 0) & (#1 < 8)
    %def16 CBDDh
    %def8 #2,86h+8*#1
  %else
    %def32 0
    %error "Illegal bit number"
  %endif
%endmacro
%macro SET %n,(IX%n)
  %if (#1 >= 0) & (#1 < 8)
    %def16 CBDDh
    %def8 #2,C6h+8*#1
  %else
    %def32 0
    %error "Illegal bit number"
  %endif
%endmacro
%macro LD (%n),IY       \%def16 22FDh,#1\%endmacro
%macro LD IY,(%n)       \%def16 2AFDh\%def16 #1\%endmacro
%macro INC (IY)         \%def16 34FDh\%def8 0\%endmacro
%macro INC (IY%n)       \%def16 34FDh\%def8 #1\%endmacro
%macro DEC (IY)         \%def16 35FDh\%def8 0\%endmacro
%macro DEC (IY%n)       \%def16 35FDh\%def8 #1\%endmacro
%macro LD (IY),%n       \%def16 36FDh\%def8 0,#1\%endmacro
%macro LD (IY%n),%n     \%def16 36FDh\%def8 #1,#2\%endmacro
%macro LD B,(IY)	\%def16 46FDh\%def8 0\%endmacro
%macro LD B,(IY%n)	\%def16 46FDh\%def8 #1\%endmacro
%macro LD C,(IY)	\%def16 4EFDh\%def8 0\%endmacro
%macro LD C,(IY%n)	\%def16 4EFDh\%def8 #1\%endmacro
%macro LD D,(IY)	\%def16 56FDh\%def8 0\%endmacro
%macro LD D,(IY%n)	\%def16 56FDh\%def8 #1\%endmacro
%macro LD E,(IY)	\%def16 5EFDh\%def8 0\%endmacro
%macro LD E,(IY%n)	\%def16 5EFDh\%def8 #1\%endmacro
%macro LD H,(IY)	\%def16 66FDh\%def8 0\%endmacro
%macro LD H,(IY%n)	\%def16 66FDh\%def8 #1\%endmacro
%macro LD L,(IY)	\%def16 6EFDh\%def8 0\%endmacro
%macro LD L,(IY%n)	\%def16 6EFDh\%def8 #1\%endmacro
%macro LD (IY),B	\%def16 70FDh\%def8 0\%endmacro
%macro LD (IY),C	\%def16 71FDh\%def8 0\%endmacro
%macro LD (IY),D	\%def16 72FDh\%def8 0\%endmacro
%macro LD (IY),E	\%def16 73FDh\%def8 0\%endmacro
%macro LD (IY),H	\%def16 74FDh\%def8 0\%endmacro
%macro LD (IY),L	\%def16 75FDh\%def8 0\%endmacro
%macro LD (IY),A	\%def16 77FDh\%def8 0\%endmacro
%macro LD (IY%n),B	\%def16 70FDh\%def8 #1\%endmacro
%macro LD (IY%n),C	\%def16 71FDh\%def8 #1\%endmacro
%macro LD (IY%n),D	\%def16 72FDh\%def8 #1\%endmacro
%macro LD (IY%n),E	\%def16 73FDh\%def8 #1\%endmacro
%macro LD (IY%n),H	\%def16 74FDh\%def8 #1\%endmacro
%macro LD (IY%n),L	\%def16 75FDh\%def8 #1\%endmacro
%macro LD (IY%n),A	\%def16 77FDh\%def8 #1\%endmacro
%macro LD A,(IY)	\%def16 7EFDh\%def8 0\%endmacro
%macro LD A,(IY%n)	\%def16 7EFDh\%def8 #1\%endmacro
%macro ADD A,(IY)       \%def16 86FDh\%def8 0\%endmacro
%macro ADD A,(IY%n)\%def16 86FDh\%def8 #1\%endmacro
%macro ADC A,(IY)\%def16 8EFDh\%def8 0\%endmacro
%macro ADC A,(IY%n)\%def16 8EFDh\%def8 #1\%endmacro
%macro SUB (IY)\%def16 96FDh\%def8 0\%endmacro
%macro SUB (IY%n)\%def16 96FDh\%def8 #1\%endmacro
%macro SBC A,(IY)\%def16 9EFDh\%def8 0\%endmacro
%macro SBC A,(IY%n)\%def16 9EFDh\%def8 #1\%endmacro
%macro AND (IY) \%def16 A6FDh\%def8 0\%endmacro
%macro AND (IY%n) \%def16 A6FDh\%def8 #1\%endmacro
%macro XOR (IY) \%def16 AEFDh\%def8 0\%endmacro
%macro XOR (IY%n) \%def16 AEFDh\%def8 #1\%endmacro
%macro OR (IY)        \%def16 B6FDh\%def8 0\%endmacro
%macro OR (IY%n)        \%def16 B6FDh\%def8 #1\%endmacro
%macro CP (IY)        \%def16 BEFDh\%def8 0\%endmacro
%macro CP (IY%n)        \%def16 BEFDh\%def8 #1\%endmacro
%macro EX (SP),IY       \%def16 E3FDh\%endmacro
%macro JP (IY)  \%def16 E9FDh\%endmacro
%macro RLC (IY)       \%def16 CBFDh\%def16 0600h\%endmacro
%macro RRC (IY)       \%def16 CBFDh\%def16 0E00h\%endmacro
%macro RL (IY)        \%def16 CBFDh\%def16 1600h\%endmacro
%macro RR (IY)        \%def16 CBFDh\%def16 1E00h\%endmacro
%macro SLA (IY)       \%def16 CBFDh\%def16 2600h\%endmacro
%macro SRA (IY)       \%def16 CBFDh\%def16 2E00h\%endmacro
%macro SLL (IY)       \%def16 CBFDh\%def16 3600h\%endmacro
%macro SRL (IY)       \%def16 CBFDh\%def16 3E00h\%endmacro
%macro RLC (IY%n)       \%def16 CBFDh\%def8 #1,06h\%endmacro
%macro RRC (IY%n)       \%def16 CBFDh\%def8 #1,0Eh\%endmacro
%macro RL (IY%n)        \%def16 CBFDh\%def8 #1,16h\%endmacro
%macro RR (IY%n)        \%def16 CBFDh\%def8 #1,1Eh\%endmacro
%macro SLA (IY%n)       \%def16 CBFDh\%def8 #1,26h\%endmacro
%macro SRA (IY%n)       \%def16 CBFDh\%def8 #1,2Eh\%endmacro
%macro SLL (IY%n)       \%def16 CBFDh\%def8 #1,36h\%endmacro
%macro SRL (IY%n)       \%def16 CBFDh\%def8 #1,3Eh\%endmacro
%macro BIT %n,(IY)	\BIT #1,(IY+0)\%endmacro
%macro RES %n,(IY)	\RES #1,(IY+0)\%endmacro
%macro SET %n,(IY)	\SET #1,(IY+0)\%endmacro
%macro BIT %n,(IY%n)
  %if (#1 >= 0) & (#1 < 8)
    %def16 CBFDh
    %def8 #2,46h+8*#1
  %else
    %def32 0
    %error "Illegal bit number"
  %endif
%endmacro
%macro RES %n,(IY%n)
  %if (#1 >= 0) & (#1 < 8)
    %def16 CBFDh
    %def8 #2,86h+8*#1
  %else
    %def32 0
    %error "Illegal bit number"
  %endif
%endmacro
%macro SET %n,(IY%n)
  %if (#1 >= 0) & (#1 < 8)
    %def16 CBFDh
    %def8 #2,C6h+8*#1
  %else
    %def32 0
    %error "Illegal bit number"
  %endif
%endmacro
