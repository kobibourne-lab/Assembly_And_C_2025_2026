*-----------------------------------------------------------
* Title      :pract 3 part 1
* Written by :Kobi Bourne
* Date       :26/01/2026
* Description:show add-reg storing address not contents/values
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

* Put program code here

    LEA $4000, A1       ;loads address $4000 into Add reg A1
    MOVE.B #100, (A1)   ;copy (B-4Bits )decimal-val 100(64Hex) into the address stored in A1 - $4000 

    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
