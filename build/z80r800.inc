/;
/; tniASM Z80/R800 definition file v1.0
\; by Patriek Lesparre
\;

%include "segment.inc"

%macro DC %s
 %def8 #1 << 1
 %def8 #1 >> (%len(#1)-1) | 128
%endmacro

%macro DB\%def8 \%endmacro
%macro DW\%def16 \%endmacro
%macro DL\%def32 \%endmacro
%macro DS\%defb \%endmacro
%macro RB\%res8 \%endmacro
%macro RW\%res16 \%endmacro
%macro RL\%res32 \%endmacro
%macro EQU\%equ \%endmacro
%macro FNAME\%fname \%endmacro
%macro INCBIN\%incbin \%endmacro
%macro INCLUDE\%include \%endmacro
;%macro ORG\%org \%endmacro
%macro FORG\%forg \%endmacro
%macro $\%apos\%endmacro
%macro $$\%fpos\%endmacro

;%macro PHASE %n
;tniasm#phase %set #1 - %apos
;%org #1
;%endmacro
;%macro DEPHASE
;%org %apos - tniasm#phase
;tniasm#phase %set 0
;%endmacro

%macro NOP              \%def8 00h\%endmacro
%macro LD BC,%n         \%def8 01h\%def16 #1\%endmacro
%macro LD [BC],A        \%def8 02h\%endmacro
%macro INC BC           \%def8 03h\%endmacro
%macro INC B            \%def8 04h\%endmacro
%macro DEC B            \%def8 05h\%endmacro
%macro LD B,%n          \%def8 06h,#1\%endmacro
%macro RLCA             \%def8 07h\%endmacro
%macro EX AF,AF'        \%def8 08h\%endmacro
%macro ADD HL,BC        \%def8 09h\%endmacro
%macro LD A,[BC]        \%def8 0Ah\%endmacro
%macro DEC BC           \%def8 0Bh\%endmacro
%macro INC C            \%def8 0Ch\%endmacro
%macro DEC C            \%def8 0Dh\%endmacro
%macro LD C,%n          \%def8 0Eh,#1\%endmacro
%macro RRCA             \%def8 0Fh\%endmacro

%macro DJNZ %n
 %if (#1-($+2) <= 127) & (#1-($+2) >= -128)
  %def8 10h,#1-($+1)
 %else
  %def16 0
  %error "Relative jump out of range"
 %endif
%endmacro
%macro LD DE,%n         \%def8 11h\%def16 #1\%endmacro
%macro LD [DE],A        \%def8 12h\%endmacro
%macro INC DE           \%def8 13h\%endmacro
%macro INC D            \%def8 14h\%endmacro
%macro DEC D            \%def8 15h\%endmacro
%macro LD D,%n          \%def8 16h,#1\%endmacro
%macro RLA              \%def8 17h\%endmacro
%macro JR %n
 %if (#1-($+2) <= 127) & (#1-($+2) >= -128)
  %def8 18h
  %def8 #1-($+1)
 %else
  %def16 0
  %error "Relative jump out of range"
 %endif
%endmacro
%macro ADD HL,DE        \%def8 19h\%endmacro
%macro LD A,[DE]        \%def8 1Ah\%endmacro
%macro DEC DE           \%def8 1Bh\%endmacro
%macro INC E            \%def8 1Ch\%endmacro
%macro DEC E            \%def8 1Dh\%endmacro
%macro LD E,%n          \%def8 1Eh,#1\%endmacro
%macro RRA              \%def8 1Fh\%endmacro

%macro JR NZ,%n
 %if (#1-($+2) <= 127) & (#1-($+2) >= -128)
  %def8 20h,#1-($+1)
 %else
  %def16 0
  %error "Relative jump out of range"
 %endif
%endmacro
%macro LD HL,%n         \%def8 21h\%def16 #1\%endmacro
%macro LD [%n],HL       \%def8 22h\%def16 #1\%endmacro
%macro INC HL           \%def8 23h\%endmacro
%macro INC H            \%def8 24h\%endmacro
%macro DEC H            \%def8 25h\%endmacro
%macro LD H,%n          \%def8 26h,#1\%endmacro
%macro DAA              \%def8 27h\%endmacro
%macro JR Z,%n
 %if (#1-($+2) <= 127) & (#1-($+2) >= -128)
  %def8 28h,#1-($+1)
 %else
  %def16 0
  %error "Relative jump out of range"
 %endif
%endmacro
%macro ADD HL,HL        \%def8 29h\%endmacro
%macro LD HL,[%n]       \%def8 2Ah\%def16 #1\%endmacro
%macro DEC HL           \%def8 2Bh\%endmacro
%macro INC L            \%def8 2Ch\%endmacro
%macro DEC L            \%def8 2Dh\%endmacro
%macro LD L,%n          \%def8 2Eh,#1\%endmacro
%macro CPL              \%def8 2Fh\%endmacro

%macro JR NC,%n
 %if (#1-($+2) <= 127) & (#1-($+2) >= -128)
  %def8 30h,#1-($+1)
 %else
  %def16 0
  %error "Relative jump out of range"
 %endif
%endmacro
%macro LD SP,%n         \%def8 31h\%def16 #1\%endmacro
%macro LD [%n],A        \%def8 32h\%def16 #1\%endmacro
%macro INC SP           \%def8 33h\%endmacro
%macro INC [HL]         \%def8 34h\%endmacro
%macro DEC [HL]         \%def8 35h\%endmacro
%macro LD [HL],%n       \%def8 36h,#1\%endmacro
%macro SCF              \%def8 37h\%endmacro
%macro JR C,%n
 %if (#1-($+2) <= 127) & (#1-($+2) >= -128)
  %def8 38h,#1-($+1)
 %else
  %def16 0
  %error "Relative jump out of range"
 %endif
%endmacro
%macro ADD HL,SP        \%def8 39h\%endmacro
%macro LD A,[%n]        \%def8 3Ah\%def16 #1\%endmacro
%macro DEC SP           \%def8 3Bh\%endmacro
%macro INC A            \%def8 3Ch\%endmacro
%macro DEC A            \%def8 3Dh\%endmacro
%macro LD A,%n          \%def8 3Eh,#1\%endmacro
%macro CCF              \%def8 3Fh\%endmacro

%macro LD B,B           \%def8 40h\%endmacro
%macro LD B,C           \%def8 41h\%endmacro
%macro LD B,D           \%def8 42h\%endmacro
%macro LD B,E           \%def8 43h\%endmacro
%macro LD B,H           \%def8 44h\%endmacro
%macro LD B,L           \%def8 45h\%endmacro
%macro LD B,[HL]        \%def8 46h\%endmacro
%macro LD B,A           \%def8 47h\%endmacro
%macro LD C,B           \%def8 48h\%endmacro
%macro LD C,C           \%def8 49h\%endmacro
%macro LD C,D           \%def8 4Ah\%endmacro
%macro LD C,E           \%def8 4Bh\%endmacro
%macro LD C,H           \%def8 4Ch\%endmacro
%macro LD C,L           \%def8 4Dh\%endmacro
%macro LD C,[HL]        \%def8 4Eh\%endmacro
%macro LD C,A           \%def8 4Fh\%endmacro

%macro LD D,B   	\%def8 50h\%endmacro
%macro LD D,C   	\%def8 51h\%endmacro
%macro LD D,D   	\%def8 52h\%endmacro
%macro LD D,E   	\%def8 53h\%endmacro
%macro LD D,H   	\%def8 54h\%endmacro
%macro LD D,L   	\%def8 55h\%endmacro
%macro LD D,[HL]        \%def8 56h\%endmacro
%macro LD D,A   	\%def8 57h\%endmacro
%macro LD E,B   	\%def8 58h\%endmacro
%macro LD E,C   	\%def8 59h\%endmacro
%macro LD E,D   	\%def8 5Ah\%endmacro
%macro LD E,E   	\%def8 5Bh\%endmacro
%macro LD E,H   	\%def8 5Ch\%endmacro
%macro LD E,L   	\%def8 5Dh\%endmacro
%macro LD E,[HL]        \%def8 5Eh\%endmacro
%macro LD E,A   	\%def8 5Fh\%endmacro

%macro LD H,B   	\%def8 60h\%endmacro
%macro LD H,C   	\%def8 61h\%endmacro
%macro LD H,D   	\%def8 62h\%endmacro
%macro LD H,E   	\%def8 63h\%endmacro
%macro LD H,H   	\%def8 64h\%endmacro
%macro LD H,L   	\%def8 65h\%endmacro
%macro LD H,[HL]        \%def8 66h\%endmacro
%macro LD H,A   	\%def8 67h\%endmacro
%macro LD L,B   	\%def8 68h\%endmacro
%macro LD L,C   	\%def8 69h\%endmacro
%macro LD L,D   	\%def8 6Ah\%endmacro
%macro LD L,E   	\%def8 6Bh\%endmacro
%macro LD L,H   	\%def8 6Ch\%endmacro
%macro LD L,L   	\%def8 6Dh\%endmacro
%macro LD L,[HL]        \%def8 6Eh\%endmacro
%macro LD L,A   	\%def8 6Fh\%endmacro

%macro LD [HL],B        \%def8 70h\%endmacro
%macro LD [HL],C        \%def8 71h\%endmacro
%macro LD [HL],D        \%def8 72h\%endmacro
%macro LD [HL],E        \%def8 73h\%endmacro
%macro LD [HL],H        \%def8 74h\%endmacro
%macro LD [HL],L        \%def8 75h\%endmacro
%macro HALT             \%def8 76h\%endmacro
%macro LD [HL],A        \%def8 77h\%endmacro
%macro LD A,B   	\%def8 78h\%endmacro
%macro LD A,C   	\%def8 79h\%endmacro
%macro LD A,D   	\%def8 7Ah\%endmacro
%macro LD A,E   	\%def8 7Bh\%endmacro
%macro LD A,H   	\%def8 7Ch\%endmacro
%macro LD A,L   	\%def8 7Dh\%endmacro
%macro LD A,[HL]        \%def8 7Eh\%endmacro
%macro LD A,A   	\%def8 7Fh\%endmacro

%macro ADD A,B  	\%def8 80h\%endmacro
%macro ADD A,C  	\%def8 81h\%endmacro
%macro ADD A,D  	\%def8 82h\%endmacro
%macro ADD A,E  	\%def8 83h\%endmacro
%macro ADD A,H  	\%def8 84h\%endmacro
%macro ADD A,L  	\%def8 85h\%endmacro
%macro ADD A,[HL]       \%def8 86h\%endmacro
%macro ADD A,A  	\%def8 87h\%endmacro
%macro ADC A,B  	\%def8 88h\%endmacro
%macro ADC A,C  	\%def8 89h\%endmacro
%macro ADC A,D  	\%def8 8Ah\%endmacro
%macro ADC A,E  	\%def8 8Bh\%endmacro
%macro ADC A,H  	\%def8 8Ch\%endmacro
%macro ADC A,L  	\%def8 8Dh\%endmacro
%macro ADC A,[HL]       \%def8 8Eh\%endmacro
%macro ADC A,A  	\%def8 8Fh\%endmacro

%macro SUB B    	\%def8 90h\%endmacro
%macro SUB C    	\%def8 91h\%endmacro
%macro SUB D    	\%def8 92h\%endmacro
%macro SUB E    	\%def8 93h\%endmacro
%macro SUB H    	\%def8 94h\%endmacro
%macro SUB L    	\%def8 95h\%endmacro
%macro SUB [HL] 	\%def8 96h\%endmacro
%macro SUB A    	\%def8 97h\%endmacro
%macro SBC A,B  	\%def8 98h\%endmacro
%macro SBC A,C  	\%def8 99h\%endmacro
%macro SBC A,D  	\%def8 9Ah\%endmacro
%macro SBC A,E  	\%def8 9Bh\%endmacro
%macro SBC A,H  	\%def8 9Ch\%endmacro
%macro SBC A,L  	\%def8 9Dh\%endmacro
%macro SBC A,[HL]       \%def8 9Eh\%endmacro
%macro SBC A,A  	\%def8 9Fh\%endmacro

%macro AND B    	\%def8 A0h\%endmacro
%macro AND C    	\%def8 A1h\%endmacro
%macro AND D    	\%def8 A2h\%endmacro
%macro AND E    	\%def8 A3h\%endmacro
%macro AND H    	\%def8 A4h\%endmacro
%macro AND L    	\%def8 A5h\%endmacro
%macro AND [HL] 	\%def8 A6h\%endmacro
%macro AND A    	\%def8 A7h\%endmacro
%macro XOR B    	\%def8 A8h\%endmacro
%macro XOR C    	\%def8 A9h\%endmacro
%macro XOR D    	\%def8 AAh\%endmacro
%macro XOR E    	\%def8 ABh\%endmacro
%macro XOR H    	\%def8 ACh\%endmacro
%macro XOR L    	\%def8 ADh\%endmacro
%macro XOR [HL] 	\%def8 AEh\%endmacro
%macro XOR A    	\%def8 AFh\%endmacro

%macro OR B             \%def8 B0h\%endmacro
%macro OR C             \%def8 B1h\%endmacro
%macro OR D             \%def8 B2h\%endmacro
%macro OR E             \%def8 B3h\%endmacro
%macro OR H             \%def8 B4h\%endmacro
%macro OR L             \%def8 B5h\%endmacro
%macro OR [HL]  	\%def8 B6h\%endmacro
%macro OR A             \%def8 B7h\%endmacro
%macro CP B             \%def8 B8h\%endmacro
%macro CP C             \%def8 B9h\%endmacro
%macro CP D             \%def8 BAh\%endmacro
%macro CP E             \%def8 BBh\%endmacro
%macro CP H             \%def8 BCh\%endmacro
%macro CP L             \%def8 BDh\%endmacro
%macro CP [HL]  	\%def8 BEh\%endmacro
%macro CP A             \%def8 BFh\%endmacro

%macro RET NZ   	\%def8 C0h\%endmacro
%macro POP BC   	\%def8 C1h\%endmacro
%macro JP NZ,%n 	\%def8 C2h\%def16 #1\%endmacro
%macro JP %n    	\%def8 C3h\%def16 #1\%endmacro
%macro CALL NZ,%n       \%def8 C4h\%def16 #1\%endmacro
%macro PUSH BC  	\%def8 C5h\%endmacro
%macro ADD A,%n 	\%def8 C6h,#1\%endmacro
%macro RST 00H  	\%def8 C7h\%endmacro
%macro RET Z    	\%def8 C8h\%endmacro
%macro RET              \%def8 C9h\%endmacro
%macro JP Z,%n  	\%def8 CAh\%def16 #1\%endmacro
%macro CALL Z,%n        \%def8 CCh\%def16 #1\%endmacro
%macro CALL %n  	\%def8 CDh\%def16 #1\%endmacro
%macro ADC A,%n 	\%def8 CEh,#1\%endmacro
%macro RST 08H  	\%def8 CFh\%endmacro

%macro RET NC   	\%def8 D0h\%endmacro
%macro POP DE   	\%def8 D1h\%endmacro
%macro JP NC,%n 	\%def8 D2h\%def16 #1\%endmacro
%macro OUT [%n],A 	\%def8 D3h,#1\%endmacro
%macro CALL NC,%n       \%def8 D4h\%def16 #1\%endmacro
%macro PUSH DE  	\%def8 D5h\%endmacro
%macro SUB %n   	\%def8 D6h,#1\%endmacro
%macro RST 10H  	\%def8 D7h\%endmacro
%macro RET C    	\%def8 D8h\%endmacro
%macro EXX              \%def8 D9h\%endmacro
%macro JP C,%n  	\%def8 DAh\%def16 #1\%endmacro
%macro IN A,[%n]        \%def8 DBh,#1\%endmacro
%macro CALL C,%n        \%def8 DCh\%def16 #1\%endmacro
%macro SBC A,%n 	\%def8 DEh,#1\%endmacro
%macro RST 18H  	\%def8 DFh\%endmacro

%macro RET PO   	\%def8 E0h\%endmacro
%macro POP HL   	\%def8 E1h\%endmacro
%macro JP PO,%n 	\%def8 E2h\%def16 #1\%endmacro
%macro EX [SP],HL 	\%def8 E3h\%endmacro
%macro CALL PO,%n       \%def8 E4h\%def16 #1\%endmacro
%macro PUSH HL  	\%def8 E5h\%endmacro
%macro AND %n   	\%def8 E6h,#1\%endmacro
%macro RST 20H  	\%def8 E7h\%endmacro
%macro RET PE   	\%def8 E8h\%endmacro
%macro JP [HL]  	\%def8 E9h\%endmacro
%macro JP PE,%n 	\%def8 EAh\%def16 #1\%endmacro
%macro EX DE,HL 	\%def8 EBh\%endmacro
%macro CALL PE,%n       \%def8 ECh\%def16 #1\%endmacro
%macro XOR %n   	\%def8 EEh\%def8 #1\%endmacro
%macro RST 28H  	\%def8 EFh\%endmacro

%macro RET P    	\%def8 F0h\%endmacro
%macro POP AF   	\%def8 F1h\%endmacro
%macro JP P,%n  	\%def8 F2h\%def16 #1\%endmacro
%macro DI               \%def8 F3h\%endmacro
%macro CALL P,%n        \%def8 F4h\%def16 #1\%endmacro
%macro PUSH AF  	\%def8 F5h\%endmacro
%macro OR %n    	\%def8 F6h,#1\%endmacro
%macro RST 30H  	\%def8 F7h\%endmacro
%macro RET M    	\%def8 F8h\%endmacro
%macro LD SP,HL 	\%def8 F9h\%endmacro
%macro JP M,%n  	\%def8 FAh\%def16 #1\%endmacro
%macro EI               \%def8 FBh\%endmacro
%macro CALL M,%n        \%def8 FCh\%def16 #1\%endmacro
%macro CP %n    	\%def8 FEh,#1\%endmacro
%macro RST 38H  	\%def8 FFh\%endmacro

%macro RLC B    \%def16 00CBh\%endmacro
%macro RLC C    \%def16 01CBh\%endmacro
%macro RLC D    \%def16 02CBh\%endmacro
%macro RLC E    \%def16 03CBh\%endmacro
%macro RLC H    \%def16 04CBh\%endmacro
%macro RLC L    \%def16 05CBh\%endmacro
%macro RLC [HL] \%def16 06CBh\%endmacro
%macro RLC A    \%def16 07CBh\%endmacro
%macro RRC B    \%def16 08CBh\%endmacro
%macro RRC C    \%def16 09CBh\%endmacro
%macro RRC D    \%def16 0ACBh\%endmacro
%macro RRC E    \%def16 0BCBh\%endmacro
%macro RRC H    \%def16 0CCBh\%endmacro
%macro RRC L    \%def16 0DCBh\%endmacro
%macro RRC [HL] \%def16 0ECBh\%endmacro
%macro RRC A    \%def16 0FCBh\%endmacro

%macro RL B             \%def16 10CBh\%endmacro
%macro RL C             \%def16 11CBh\%endmacro
%macro RL D             \%def16 12CBh\%endmacro
%macro RL E             \%def16 13CBh\%endmacro
%macro RL H             \%def16 14CBh\%endmacro
%macro RL L             \%def16 15CBh\%endmacro
%macro RL [HL]  	\%def16 16CBh\%endmacro
%macro RL A             \%def16 17CBh\%endmacro
%macro RR B             \%def16 18CBh\%endmacro
%macro RR C             \%def16 19CBh\%endmacro
%macro RR D             \%def16 1ACBh\%endmacro
%macro RR E             \%def16 1BCBh\%endmacro
%macro RR H             \%def16 1CCBh\%endmacro
%macro RR L             \%def16 1DCBh\%endmacro
%macro RR [HL]  	\%def16 1ECBh\%endmacro
%macro RR A             \%def16 1FCBh\%endmacro

%macro SLA B    \%def16 20CBh\%endmacro
%macro SLA C    \%def16 21CBh\%endmacro
%macro SLA D    \%def16 22CBh\%endmacro
%macro SLA E    \%def16 23CBh\%endmacro
%macro SLA H    \%def16 24CBh\%endmacro
%macro SLA L    \%def16 25CBh\%endmacro
%macro SLA [HL] \%def16 26CBh\%endmacro
%macro SLA A    \%def16 27CBh\%endmacro
%macro SRA B    \%def16 28CBh\%endmacro
%macro SRA C    \%def16 29CBh\%endmacro
%macro SRA D    \%def16 2ACBh\%endmacro
%macro SRA E    \%def16 2BCBh\%endmacro
%macro SRA H    \%def16 2CCBh\%endmacro
%macro SRA L    \%def16 2DCBh\%endmacro
%macro SRA [HL] \%def16 2ECBh\%endmacro
%macro SRA A    \%def16 2FCBh\%endmacro

%macro SLL B    \%def16 30CBh\%endmacro
%macro SLL C    \%def16 31CBh\%endmacro
%macro SLL D    \%def16 32CBh\%endmacro
%macro SLL E    \%def16 33CBh\%endmacro
%macro SLL H    \%def16 34CBh\%endmacro
%macro SLL L    \%def16 35CBh\%endmacro
%macro SLL [HL] \%def16 36CBh\%endmacro
%macro SLL A    \%def16 37CBh\%endmacro

%macro SRL B    \%def16 38CBh\%endmacro
%macro SRL C    \%def16 39CBh\%endmacro
%macro SRL D    \%def16 3ACBh\%endmacro
%macro SRL E    \%def16 3BCBh\%endmacro
%macro SRL H    \%def16 3CCBh\%endmacro
%macro SRL L    \%def16 3DCBh\%endmacro
%macro SRL [HL] \%def16 3ECBh\%endmacro
%macro SRL A    \%def16 3FCBh\%endmacro

%macro BIT %n,B
  %if (#1 >= 0) & (#1 < 8)
    %def8 CBh,40h+8*#1
  %else
    %def16 0
    %error "Illegal bit number"
  %endif
%endmacro
%macro BIT %n,C
  %if (#1 >= 0) & (#1 < 8)
    %def8 CBh,41h+8*#1
  %else
    %def16 0
    %error "Illegal bit number"
  %endif
%endmacro
%macro BIT %n,D
  %if (#1 >= 0) & (#1 < 8)
    %def8 CBh,42h+8*#1
  %else
    %def16 0
    %error "Illegal bit number"
  %endif
%endmacro
%macro BIT %n,E
  %if (#1 >= 0) & (#1 < 8)
    %def8 CBh,43h+8*#1
  %else
    %def16 0
    %error "Illegal bit number"
  %endif
%endmacro
%macro BIT %n,H
  %if (#1 >= 0) & (#1 < 8)
    %def8 CBh,44h+8*#1
  %else
    %def16 0
    %error "Illegal bit number"
  %endif
%endmacro
%macro BIT %n,L
  %if (#1 >= 0) & (#1 < 8)
    %def8 CBh,45h+8*#1
  %else
    %def16 0
    %error "Illegal bit number"
  %endif
%endmacro
%macro BIT %n,[HL]
  %if (#1 >= 0) & (#1 < 8)
    %def8 CBh,46h+8*#1
  %else
    %def16 0
    %error "Illegal bit number"
  %endif
%endmacro
%macro BIT %n,A
  %if (#1 >= 0) & (#1 < 8)
    %def8 CBh,47h+8*#1
  %else
    %def16 0
    %error "Illegal bit number"
  %endif
%endmacro

%macro RES %n,B
  %if (#1 >= 0) & (#1 < 8)
    %def8 CBh,80h+8*#1
  %else
    %def16 0
    %error "Illegal bit number"
  %endif
%endmacro
%macro RES %n,C
  %if (#1 >= 0) & (#1 < 8)
    %def8 CBh,81h+8*#1
  %else
    %def16 0
    %error "Illegal bit number"
  %endif
%endmacro
%macro RES %n,D
  %if (#1 >= 0) & (#1 < 8)
    %def8 CBh,82h+8*#1
  %else
    %def16 0
    %error "Illegal bit number"
  %endif
%endmacro
%macro RES %n,E
  %if (#1 >= 0) & (#1 < 8)
    %def8 CBh,83h+8*#1
  %else
    %def16 0
    %error "Illegal bit number"
  %endif
%endmacro
%macro RES %n,H
  %if (#1 >= 0) & (#1 < 8)
    %def8 CBh,84h+8*#1
  %else
    %def16 0
    %error "Illegal bit number"
  %endif
%endmacro
%macro RES %n,L
  %if (#1 >= 0) & (#1 < 8)
    %def8 CBh,85h+8*#1
  %else
    %def16 0
    %error "Illegal bit number"
  %endif
%endmacro
%macro RES %n,[HL]
  %if (#1 >= 0) & (#1 < 8)
    %def8 CBh,86h+8*#1
  %else
    %def16 0
    %error "Illegal bit number"
  %endif
%endmacro
%macro RES %n,A
  %if (#1 >= 0) & (#1 < 8)
    %def8 CBh,87h+8*#1
  %else
    %def16 0
    %error "Illegal bit number"
  %endif
%endmacro

%macro SET %n,B
  %if (#1 >= 0) & (#1 < 8)
    %def8 CBh,C0h+8*#1
  %else
    %def16 0
    %error "Illegal bit number"
  %endif
%endmacro
%macro SET %n,C
  %if (#1 >= 0) & (#1 < 8)
    %def8 CBh,C1h+8*#1
  %else
    %def16 0
    %error "Illegal bit number"
  %endif
%endmacro
%macro SET %n,D
  %if (#1 >= 0) & (#1 < 8)
    %def8 CBh,C2h+8*#1
  %else
    %def16 0
    %error "Illegal bit number"
  %endif
%endmacro
%macro SET %n,E
  %if (#1 >= 0) & (#1 < 8)
    %def8 CBh,C3h+8*#1
  %else
    %def16 0
    %error "Illegal bit number"
  %endif
%endmacro
%macro SET %n,H
  %if (#1 >= 0) & (#1 < 8)
    %def8 CBh,C4h+8*#1
  %else
    %def16 0
    %error "Illegal bit number"
  %endif
%endmacro
%macro SET %n,L
  %if (#1 >= 0) & (#1 < 8)
    %def8 CBh,C5h+8*#1
  %else
    %def16 0
    %error "Illegal bit number"
  %endif
%endmacro
%macro SET %n,[HL]
  %if (#1 >= 0) & (#1 < 8)
    %def8 CBh,C6h+8*#1
  %else
    %def16 0
    %error "Illegal bit number"
  %endif
%endmacro
%macro SET %n,A
  %if (#1 >= 0) & (#1 < 8)
    %def8 CBh,C7h+8*#1
  %else
    %def16 0
    %error "Illegal bit number"
  %endif
%endmacro

%macro IN B,[C] 	\%def16 40EDh\%endmacro
%macro OUT [C],B        \%def16 41EDh\%endmacro
%macro SBC HL,BC        \%def16 42EDh\%endmacro
%macro LD [%n],BC       \%def16 43EDh,#1\%endmacro
%macro NEG              \%def16 44EDh\%endmacro
%macro RETN             \%def16 45EDh\%endmacro
%macro IM 0             \%def16 46EDh\%endmacro
%macro LD I,A   	\%def16 47EDh\%endmacro
%macro IN C,[C] 	\%def16 48EDh\%endmacro
%macro OUT [C],C        \%def16 49EDh\%endmacro
%macro ADC HL,BC        \%def16 4AEDh\%endmacro
%macro LD BC,[%n]       \%def16 4BEDh\%def16 #1\%endmacro
%macro RETI             \%def16 4DEDh\%endmacro
%macro LD R,A   	\%def16 4FEDh\%endmacro

%macro IN D,[C] 	\%def16 50EDh\%endmacro
%macro OUT [C],D        \%def16 51EDh\%endmacro
%macro SBC HL,DE        \%def16 52EDh\%endmacro
%macro LD [%n],DE       \%def16 53EDh,#1\%endmacro
%macro IM 1             \%def16 56EDh\%endmacro
%macro LD A,I   	\%def16 57EDh\%endmacro
%macro IN E,[C] 	\%def16 58EDh\%endmacro
%macro OUT [C],E        \%def16 59EDh\%endmacro
%macro ADC HL,DE        \%def16 5AEDh\%endmacro
%macro LD DE,[%n]       \%def16 5BEDh\%def16 #1\%endmacro
%macro IM 2             \%def16 5EEDh\%endmacro
%macro LD A,R   	\%def16 5FEDh\%endmacro

%macro IN H,[C] 	\%def16 60EDh\%endmacro
%macro OUT [C],H        \%def16 61EDh\%endmacro
%macro SBC HL,HL        \%def16 62EDh\%endmacro
%macro RRD              \%def16 67EDh\%endmacro
%macro IN L,[C] 	\%def16 68EDh\%endmacro
%macro OUT [C],L        \%def16 69EDh\%endmacro
%macro ADC HL,HL        \%def16 6AEDh\%endmacro
%macro RLD              \%def16 6FEDh\%endmacro

%macro IN F,[C] 	\%def16 70EDh\%endmacro
%macro OUT [C],0        \%def16 71EDh\%endmacro
%macro SBC HL,SP        \%def16 72EDh\%endmacro
%macro LD [%n],SP       \%def16 73EDh,#1\%endmacro
%macro IN A,[C] 	\%def16 78EDh\%endmacro
%macro OUT [C],A        \%def16 79EDh\%endmacro
%macro ADC HL,SP        \%def16 7AEDh\%endmacro
%macro LD SP,[%n]       \%def16 7BEDh\%def16 #1\%endmacro

%macro LDI              \%def16 A0EDh\%endmacro
%macro CPI              \%def16 A1EDh\%endmacro
%macro INI              \%def16 A2EDh\%endmacro
%macro OUTI             \%def16 A3EDh\%endmacro
%macro LDD              \%def16 A8EDh\%endmacro
%macro CPD              \%def16 A9EDh\%endmacro
%macro IND              \%def16 AAEDh\%endmacro
%macro OUTD             \%def16 ABEDh\%endmacro

%macro LDIR             \%def16 B0EDh\%endmacro
%macro CPIR             \%def16 B1EDh\%endmacro
%macro INIR             \%def16 B2EDh\%endmacro
%macro OTIR             \%def16 B3EDh\%endmacro
%macro LDDR             \%def16 B8EDh\%endmacro
%macro CPDR             \%def16 B9EDh\%endmacro
%macro INDR             \%def16 BAEDh\%endmacro
%macro OTDR             \%def16 BBEDh\%endmacro

%macro MULUB A,B        \%def16 C1EDh\%endmacro
%macro MULUW HL,BC	\%def16 C3EDh\%endmacro
%macro MULUB A,C        \%def16 C9EDh\%endmacro
%macro MULUB A,D        \%def16 D1EDh\%endmacro
%macro MULUW HL,DE	\%def16 D3EDh\%endmacro
%macro MULUB A,E        \%def16 D9EDh\%endmacro
%macro MULUB A,H        \%def16 E1EDh\%endmacro
%macro MULUW HL,HL	\%def16 E3EDh\%endmacro
%macro MULUB A,L        \%def16 E9EDh\%endmacro
%macro MULUW HL,SP	\%def16 F3EDh\%endmacro
%macro MULUB A,A        \%def16 F9EDh\%endmacro

%macro ADD IX,BC        \%def16 09DDh\%endmacro
%macro ADD IX,DE        \%def16 19DDh\%endmacro
%macro LD IX,%n		\%def16 21DDh,#1\%endmacro
%macro LD [%n],IX       \%def16 22DDh,#1\%endmacro
%macro INC IX   	\%def16 23DDh\%endmacro
%macro INC IXH  	\%def16 24DDh\%endmacro
%macro DEC IXH  	\%def16 25DDh\%endmacro
%macro LD IXH,%n        \%def16 26DDh\%def8 #1\%endmacro
%macro ADD IX,IX        \%def16 29DDh\%endmacro
%macro LD IX,[%n]       \%def16 2ADDh\%def16 #1\%endmacro
%macro DEC IX   	\%def16 2BDDh\%endmacro
%macro INC IXL  	\%def16 2CDDh\%endmacro
%macro DEC IXL  	\%def16 2DDDh\%endmacro
%macro LD IXL,%n        \%def16 2EDDh\%def8 #1\%endmacro
%macro INC [IX]         \%def16 34DDh\%def8 0\%endmacro
%macro INC [IX%n]       \%def16 34DDh\%def8 #1\%endmacro
%macro DEC [IX]         \%def16 35DDh\%def8 0\%endmacro
%macro DEC [IX%n]       \%def16 35DDh\%def8 #1\%endmacro
%macro LD [IX],%n       \%def16 36DDh\%def8 0,#1\%endmacro
%macro LD [IX%n],%n     \%def16 36DDh\%def8 #1,#2\%endmacro
%macro ADD IX,SP        \%def16 39DDh\%endmacro

%macro LD B,IXH 	\%def16 44DDh\%endmacro
%macro LD B,IXL 	\%def16 45DDh\%endmacro
%macro LD B,[IX]	\%def16 46DDh\%def8 0\%endmacro
%macro LD B,[IX%n]	\%def16 46DDh\%def8 #1\%endmacro
%macro LD C,IXH 	\%def16 4CDDh\%endmacro
%macro LD C,IXL 	\%def16 4DDDh\%endmacro
%macro LD C,[IX]	\%def16 4EDDh\%def8 0\%endmacro
%macro LD C,[IX%n]	\%def16 4EDDh\%def8 #1\%endmacro
%macro LD D,IXH 	\%def16 54DDh\%endmacro
%macro LD D,IXL 	\%def16 55DDh\%endmacro
%macro LD D,[IX]	\%def16 56DDh\%def8 0\%endmacro
%macro LD D,[IX%n]	\%def16 56DDh\%def8 #1\%endmacro
%macro LD E,IXH 	\%def16 5CDDh\%endmacro
%macro LD E,IXL 	\%def16 5DDDh\%endmacro
%macro LD E,[IX]	\%def16 5EDDh\%def8 0\%endmacro
%macro LD E,[IX%n]	\%def16 5EDDh\%def8 #1\%endmacro

%macro LD IXH,B 	\%def16 60DDh\%endmacro
%macro LD IXH,C 	\%def16 61DDh\%endmacro
%macro LD IXH,D 	\%def16 62DDh\%endmacro
%macro LD IXH,E 	\%def16 63DDh\%endmacro
%macro LD IXH,IXH       \%def16 64DDh\%endmacro
%macro LD IXH,IXL       \%def16 65DDh\%endmacro
%macro LD H,[IX]	\%def16 66DDh\%def8 0\%endmacro
%macro LD H,[IX%n]	\%def16 66DDh\%def8 #1\%endmacro
%macro LD IXH,A 	\%def16 67DDh\%endmacro
%macro LD IXL,B 	\%def16 68DDh\%endmacro
%macro LD IXL,C		\%def16 69DDh\%endmacro
%macro LD IXL,D 	\%def16 6ADDh\%endmacro
%macro LD IXL,E 	\%def16 6BDDh\%endmacro
%macro LD IXL,IXH       \%def16 6CDDh\%endmacro
%macro LD IXL,IXL       \%def16 6DDDh\%endmacro
%macro LD L,[IX]	\%def16 6EDDh\%def8 0\%endmacro
%macro LD L,[IX%n]	\%def16 6EDDh\%def8 #1\%endmacro
%macro LD IXL,A 	\%def16 6FDDh\%endmacro

%macro LD [IX],B	\%def16 70DDh\%def8 0\%endmacro
%macro LD [IX],C	\%def16 71DDh\%def8 0\%endmacro
%macro LD [IX],D	\%def16 72DDh\%def8 0\%endmacro
%macro LD [IX],E	\%def16 73DDh\%def8 0\%endmacro
%macro LD [IX],H	\%def16 74DDh\%def8 0\%endmacro
%macro LD [IX],L	\%def16 75DDh\%def8 0\%endmacro
%macro LD [IX],A	\%def16 77DDh\%def8 0\%endmacro
%macro LD [IX%n],B	\%def16 70DDh\%def8 #1\%endmacro
%macro LD [IX%n],C	\%def16 71DDh\%def8 #1\%endmacro
%macro LD [IX%n],D	\%def16 72DDh\%def8 #1\%endmacro
%macro LD [IX%n],E	\%def16 73DDh\%def8 #1\%endmacro
%macro LD [IX%n],H	\%def16 74DDh\%def8 #1\%endmacro
%macro LD [IX%n],L	\%def16 75DDh\%def8 #1\%endmacro
%macro LD [IX%n],A	\%def16 77DDh\%def8 #1\%endmacro
%macro LD A,IXH 	\%def16 7CDDh\%endmacro
%macro LD A,IXL 	\%def16 7DDDh\%endmacro
%macro LD A,[IX]	\%def16 7EDDh\%def8 0\%endmacro
%macro LD A,[IX%n]	\%def16 7EDDh\%def8 #1\%endmacro

%macro ADD A,IXH        \%def16 84DDh\%endmacro
%macro ADD A,IXL        \%def16 85DDh\%endmacro
%macro ADD A,[IX]       \%def16 86DDh\%def8 0\%endmacro
%macro ADD A,[IX%n]     \%def16 86DDh\%def8 #1\%endmacro
%macro ADC A,IXH        \%def16 8CDDh\%endmacro
%macro ADC A,IXL        \%def16 8DDDh\%endmacro
%macro ADC A,[IX]       \%def16 8EDDh\%def8 0\%endmacro
%macro ADC A,[IX%n]     \%def16 8EDDh\%def8 #1\%endmacro
%macro SUB IXH          \%def16 94DDh\%endmacro
%macro SUB IXL          \%def16 95DDh\%endmacro
%macro SUB [IX]         \%def16 96DDh\%def8 0\%endmacro
%macro SUB [IX%n]       \%def16 96DDh\%def8 #1\%endmacro
%macro SBC A,IXH        \%def16 9CDDh\%endmacro
%macro SBC A,IXL        \%def16 9DDDh\%endmacro
%macro SBC A,[IX]       \%def16 9EDDh\%def8 0\%endmacro
%macro SBC A,[IX%n]     \%def16 9EDDh\%def8 #1\%endmacro

%macro AND IXH  	\%def16 A4DDh\%endmacro
%macro AND IXL  	\%def16 A5DDh\%endmacro
%macro AND [IX] 	\%def16 A6DDh\%def8 0\%endmacro
%macro AND [IX%n] 	\%def16 A6DDh\%def8 #1\%endmacro
%macro XOR IXH  	\%def16 ACDDh\%endmacro
%macro XOR IXL  	\%def16 ADDDh\%endmacro
%macro XOR [IX] 	\%def16 AEDDh\%def8 0\%endmacro
%macro XOR [IX%n] 	\%def16 AEDDh\%def8 #1\%endmacro
%macro OR IXH   	\%def16 B4DDh\%endmacro
%macro OR IXL   	\%def16 B5DDh\%endmacro
%macro OR [IX]  	\%def16 B6DDh\%def8 0\%endmacro
%macro OR [IX%n]	\%def16 B6DDh\%def8 #1\%endmacro
%macro CP IXH   	\%def16 BCDDh\%endmacro
%macro CP IXL   	\%def16 BDDDh\%endmacro
%macro CP [IX]  	\%def16 BEDDh\%def8 0\%endmacro
%macro CP [IX%n]	\%def16 BEDDh\%def8 #1\%endmacro

%macro POP IX   	\%def16 E1DDh\%endmacro
%macro EX [SP],IX       \%def16 E3DDh\%endmacro
%macro PUSH IX  	\%def16 E5DDh\%endmacro
%macro JP [IX]  	\%def16 E9DDh\%endmacro
%macro LD SP,IX 	\%def16 F9DDh\%endmacro

%macro RLC [IX]		\%def16 CBDDh\%def16 0600h\%endmacro
%macro RRC [IX]		\%def16 CBDDh\%def16 0E00h\%endmacro
%macro RL [IX]		\%def16 CBDDh\%def16 1600h\%endmacro
%macro RR [IX]		\%def16 CBDDh\%def16 1E00h\%endmacro
%macro SLA [IX]		\%def16 CBDDh\%def16 2600h\%endmacro
%macro SRA [IX]		\%def16 CBDDh\%def16 2E00h\%endmacro
%macro SLL [IX]		\%def16 CBDDh\%def16 3600h\%endmacro
%macro SRL [IX]		\%def16 CBDDh\%def16 3E00h\%endmacro
%macro RLC [IX%n]	\%def16 CBDDh\%def8 #1,06h\%endmacro
%macro RRC [IX%n]	\%def16 CBDDh\%def8 #1,0Eh\%endmacro
%macro RL [IX%n]	\%def16 CBDDh\%def8 #1,16h\%endmacro
%macro RR [IX%n]	\%def16 CBDDh\%def8 #1,1Eh\%endmacro
%macro SLA [IX%n]	\%def16 CBDDh\%def8 #1,26h\%endmacro
%macro SRA [IX%n]	\%def16 CBDDh\%def8 #1,2Eh\%endmacro
%macro SLL [IX%n]	\%def16 CBDDh\%def8 #1,36h\%endmacro
%macro SRL [IX%n]	\%def16 CBDDh\%def8 #1,3Eh\%endmacro

%macro BIT %n,[IX]	\BIT #1,[IX+0]\%endmacro
%macro RES %n,[IX]	\RES #1,[IX+0]\%endmacro
%macro SET %n,[IX]	\SET #1,[IX+0]\%endmacro
%macro BIT %n,[IX%n]
  %if (#1 >= 0) & (#1 < 8)
    %def16 CBDDh
    %def8 #2,46h+8*#1
  %else
    %def32 0
    %error "Illegal bit number"
  %endif
%endmacro
%macro RES %n,[IX%n]
  %if (#1 >= 0) & (#1 < 8)
    %def16 CBDDh
    %def8 #2,86h+8*#1
  %else
    %def32 0
    %error "Illegal bit number"
  %endif
%endmacro
%macro SET %n,[IX%n]
  %if (#1 >= 0) & (#1 < 8)
    %def16 CBDDh
    %def8 #2,C6h+8*#1
  %else
    %def32 0
    %error "Illegal bit number"
  %endif
%endmacro

%macro ADD IY,BC        \%def16 09FDh\%endmacro
%macro ADD IY,DE        \%def16 19FDh\%endmacro
%macro LD IY,%n 	\%def16 21FDh,#1\%endmacro
%macro LD [%n],IY       \%def16 22FDh,#1\%endmacro
%macro INC IY   	\%def16 23FDh\%endmacro
%macro INC IYH  	\%def16 24FDh\%endmacro
%macro DEC IYH  	\%def16 25FDh\%endmacro
%macro LD IYH,%n        \%def16 26FDh\%def8 #1\%endmacro
%macro ADD IY,IY        \%def16 29FDh\%endmacro
%macro LD IY,[%n]       \%def16 2AFDh\%def16 #1\%endmacro
%macro DEC IY   	\%def16 2BFDh\%endmacro
%macro INC IYL  	\%def16 2CFDh\%endmacro
%macro DEC IYL  	\%def16 2DFDh\%endmacro
%macro LD IYL,%n        \%def16 2EFDh\%def8 #1\%endmacro
%macro INC [IY]         \%def16 34FDh\%def8 0\%endmacro
%macro INC [IY%n]       \%def16 34FDh\%def8 #1\%endmacro
%macro DEC [IY]         \%def16 35FDh\%def8 0\%endmacro
%macro DEC [IY%n]       \%def16 35FDh\%def8 #1\%endmacro
%macro LD [IY],%n       \%def16 36FDh\%def8 0,#1\%endmacro
%macro LD [IY%n],%n     \%def16 36FDh\%def8 #1,#2\%endmacro
%macro ADD IY,SP        \%def16 39FDh\%endmacro

%macro LD B,IYH 	\%def16 44FDh\%endmacro
%macro LD B,IYL 	\%def16 45FDh\%endmacro
%macro LD B,[IY]	\%def16 46FDh\%def8 0\%endmacro
%macro LD B,[IY%n]	\%def16 46FDh\%def8 #1\%endmacro
%macro LD C,IYH 	\%def16 4CFDh\%endmacro
%macro LD C,IYL 	\%def16 4DFDh\%endmacro
%macro LD C,[IY]	\%def16 4EFDh\%def8 0\%endmacro
%macro LD C,[IY%n]	\%def16 4EFDh\%def8 #1\%endmacro
%macro LD D,IYH 	\%def16 54FDh\%endmacro
%macro LD D,IYL 	\%def16 55FDh\%endmacro
%macro LD D,[IY]	\%def16 56FDh\%def8 0\%endmacro
%macro LD D,[IY%n]	\%def16 56FDh\%def8 #1\%endmacro
%macro LD E,IYH 	\%def16 5CFDh\%endmacro
%macro LD E,IYL 	\%def16 5DFDh\%endmacro
%macro LD E,[IY]	\%def16 5EFDh\%def8 0\%endmacro
%macro LD E,[IY%n]	\%def16 5EFDh\%def8 #1\%endmacro

%macro LD IYH,B 	\%def16 60FDh\%endmacro
%macro LD IYH,C 	\%def16 61FDh\%endmacro
%macro LD IYH,D 	\%def16 62FDh\%endmacro
%macro LD IYH,E 	\%def16 63FDh\%endmacro
%macro LD IYH,IYH       \%def16 64FDh\%endmacro
%macro LD IYH,IYL       \%def16 65FDh\%endmacro
%macro LD H,[IY]	\%def16 66FDh\%def8 0\%endmacro
%macro LD H,[IY%n]	\%def16 66FDh\%def8 #1\%endmacro
%macro LD IYH,A 	\%def16 67FDh\%endmacro
%macro LD IYL,B 	\%def16 68FDh\%endmacro
%macro LD IYL,C 	\%def16 69FDh\%endmacro
%macro LD IYL,D 	\%def16 6AFDh\%endmacro
%macro LD IYL,E 	\%def16 6BFDh\%endmacro
%macro LD IYL,IYH       \%def16 6CFDh\%endmacro
%macro LD IYL,IYL       \%def16 6DFDh\%endmacro
%macro LD L,[IY]	\%def16 6EFDh\%def8 0\%endmacro
%macro LD L,[IY%n]	\%def16 6EFDh\%def8 #1\%endmacro
%macro LD IYL,A 	\%def16 6FFDh\%endmacro

%macro LD [IY],B	\%def16 70FDh\%def8 0\%endmacro
%macro LD [IY],C	\%def16 71FDh\%def8 0\%endmacro
%macro LD [IY],D	\%def16 72FDh\%def8 0\%endmacro
%macro LD [IY],E	\%def16 73FDh\%def8 0\%endmacro
%macro LD [IY],H	\%def16 74FDh\%def8 0\%endmacro
%macro LD [IY],L	\%def16 75FDh\%def8 0\%endmacro
%macro LD [IY],A	\%def16 77FDh\%def8 0\%endmacro
%macro LD [IY%n],B	\%def16 70FDh\%def8 #1\%endmacro
%macro LD [IY%n],C	\%def16 71FDh\%def8 #1\%endmacro
%macro LD [IY%n],D	\%def16 72FDh\%def8 #1\%endmacro
%macro LD [IY%n],E	\%def16 73FDh\%def8 #1\%endmacro
%macro LD [IY%n],H	\%def16 74FDh\%def8 #1\%endmacro
%macro LD [IY%n],L	\%def16 75FDh\%def8 #1\%endmacro
%macro LD [IY%n],A	\%def16 77FDh\%def8 #1\%endmacro
%macro LD A,IYH 	\%def16 7CFDh\%endmacro
%macro LD A,IYL 	\%def16 7DFDh\%endmacro
%macro LD A,[IY]	\%def16 7EFDh\%def8 0\%endmacro
%macro LD A,[IY%n]	\%def16 7EFDh\%def8 #1\%endmacro

%macro ADD A,IYH        \%def16 84FDh\%endmacro
%macro ADD A,IYL        \%def16 85FDh\%endmacro
%macro ADD A,[IY]       \%def16 86FDh\%def8 0\%endmacro
%macro ADD A,[IY%n]\%def16 86FDh\%def8 #1\%endmacro
%macro ADC A,IYH        \%def16 8CFDh\%endmacro
%macro ADC A,IYL        \%def16 8DFDh\%endmacro
%macro ADC A,[IY]\%def16 8EFDh\%def8 0\%endmacro
%macro ADC A,[IY%n]\%def16 8EFDh\%def8 #1\%endmacro
%macro SUB IYH  \%def16 94FDh\%endmacro
%macro SUB IYL  \%def16 95FDh\%endmacro
%macro SUB [IY]\%def16 96FDh\%def8 0\%endmacro
%macro SUB [IY%n]\%def16 96FDh\%def8 #1\%endmacro
%macro SBC A,IYH        \%def16 9CFDh\%endmacro
%macro SBC A,IYL        \%def16 9DFDh\%endmacro
%macro SBC A,[IY]\%def16 9EFDh\%def8 0\%endmacro
%macro SBC A,[IY%n]\%def16 9EFDh\%def8 #1\%endmacro

%macro AND IYH  \%def16 A4FDh\%endmacro
%macro AND IYL  \%def16 A5FDh\%endmacro
%macro AND [IY] \%def16 A6FDh\%def8 0\%endmacro
%macro AND [IY%n] \%def16 A6FDh\%def8 #1\%endmacro
%macro XOR IYH  \%def16 ACFDh\%endmacro
%macro XOR IYL  \%def16 ADFDh\%endmacro
%macro XOR [IY] \%def16 AEFDh\%def8 0\%endmacro
%macro XOR [IY%n] \%def16 AEFDh\%def8 #1\%endmacro
%macro OR IYH   \%def16 B4FDh\%endmacro
%macro OR IYL   \%def16 B5FDh\%endmacro
%macro OR [IY]        \%def16 B6FDh\%def8 0\%endmacro
%macro OR [IY%n]        \%def16 B6FDh\%def8 #1\%endmacro
%macro CP IYH   \%def16 BCFDh\%endmacro
%macro CP IYL   \%def16 BDFDh\%endmacro
%macro CP [IY]        \%def16 BEFDh\%def8 0\%endmacro
%macro CP [IY%n]        \%def16 BEFDh\%def8 #1\%endmacro

%macro POP IY   \%def16 E1FDh\%endmacro
%macro EX [SP],IY       \%def16 E3FDh\%endmacro
%macro PUSH IY  \%def16 E5FDh\%endmacro
%macro JP [IY]  \%def16 E9FDh\%endmacro
%macro LD SP,IY \%def16 F9FDh\%endmacro

%macro RLC [IY]       \%def16 CBFDh\%def16 0600h\%endmacro
%macro RRC [IY]       \%def16 CBFDh\%def16 0E00h\%endmacro
%macro RL [IY]        \%def16 CBFDh\%def16 1600h\%endmacro
%macro RR [IY]        \%def16 CBFDh\%def16 1E00h\%endmacro
%macro SLA [IY]       \%def16 CBFDh\%def16 2600h\%endmacro
%macro SRA [IY]       \%def16 CBFDh\%def16 2E00h\%endmacro
%macro SLL [IY]       \%def16 CBFDh\%def16 3600h\%endmacro
%macro SRL [IY]       \%def16 CBFDh\%def16 3E00h\%endmacro
%macro RLC [IY%n]       \%def16 CBFDh\%def8 #1,06h\%endmacro
%macro RRC [IY%n]       \%def16 CBFDh\%def8 #1,0Eh\%endmacro
%macro RL [IY%n]        \%def16 CBFDh\%def8 #1,16h\%endmacro
%macro RR [IY%n]        \%def16 CBFDh\%def8 #1,1Eh\%endmacro
%macro SLA [IY%n]       \%def16 CBFDh\%def8 #1,26h\%endmacro
%macro SRA [IY%n]       \%def16 CBFDh\%def8 #1,2Eh\%endmacro
%macro SLL [IY%n]       \%def16 CBFDh\%def8 #1,36h\%endmacro
%macro SRL [IY%n]       \%def16 CBFDh\%def8 #1,3Eh\%endmacro

%macro BIT %n,[IY]	\BIT #1,[IY+0]\%endmacro
%macro RES %n,[IY]	\RES #1,[IY+0]\%endmacro
%macro SET %n,[IY]	\SET #1,[IY+0]\%endmacro
%macro BIT %n,[IY%n]
  %if (#1 >= 0) & (#1 < 8)
    %def16 CBFDh
    %def8 #2,46h+8*#1
  %else
    %def32 0
    %error "Illegal bit number"
  %endif
%endmacro
%macro RES %n,[IY%n]
  %if (#1 >= 0) & (#1 < 8)
    %def16 CBFDh
    %def8 #2,86h+8*#1
  %else
    %def32 0
    %error "Illegal bit number"
  %endif
%endmacro
%macro SET %n,[IY%n]
  %if (#1 >= 0) & (#1 < 8)
    %def16 CBFDh
    %def8 #2,C6h+8*#1
  %else
    %def32 0
    %error "Illegal bit number"
  %endif
%endmacro
%macro RST %n
  %if #1 & C7h
    %error "Illegal RST"
    %def8 0
  %else
    %def8 C7h|#1
  %endif
%endmacro
