*-----------------------------------------------------------
* Title      :pract 3 part 3
* Written by :Kobi Bourne
* Date       :26/01/2026
* Description:show subtraction of HEALTH val, stored in A3
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

* Put program code here

    LEA HEALTH, A3       ;loads address of HEALTH(100E) into Add reg A3
    SUB.B  #10, (A3)     ;subtract(B-8Bits)dec-val 10(AHex) from the val of HEALTH stored in A3  
                         ; 100 - 10 =90, 90 = 5A in hex, so HEALTH is now = to 90/5A 

    SIMHALT             ; halt simulator

* Put variables and constants here
HEALTH  dc.b    $64 ;sets HEALTH val to 64 hex 

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
