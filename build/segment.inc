/;
/; tniASM segment and phase support v1.0
\; by Patriek Lesparre
\;

%macro org %n
dephase
orgcode #1
segment code
%endmacro

%macro orgcode %n
%if tniasm#currentseg = 0
%org #1
%endif
tniasm#codeseg %set #1
%endmacro

%macro orgdata %n
%if tniasm#currentseg = 1
%org #1
%endif
tniasm#dataseg %set #1
%endmacro

%macro orgbss %n
%if tniasm#currentseg = 2
%org #1
%endif
tniasm#bssseg %set #1
%endmacro

%macro segment code
tniasm#saveseg
%org tniasm#codeseg
tniasm#currentseg %set 0
%endmacro

%macro segment data
tniasm#saveseg
%org tniasm#dataseg
tniasm#currentseg %set 1
%endmacro

%macro segment bss
tniasm#saveseg
%org tniasm#bssseg
tniasm#currentseg %set 2
%endmacro

%macro phase %n
tniasm#phase %set #1 - %apos
%org #1
%endmacro

%macro dephase
%org %apos - tniasm#phase
tniasm#phase %set 0
%endmacro

; internal
%macro tniasm#saveseg
%if tniasm#currentseg = 0
tniasm#codeseg %set %apos
%else
%if tniasm#currentseg = 1
tniasm#dataseg %set %apos
%else
%if tniasm#currentseg = 2
tniasm#bssseg %set %apos
%endif
%endif
%endif
%endmacro

tniasm#currentseg %set -1
