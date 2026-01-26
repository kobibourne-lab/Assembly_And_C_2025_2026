*-----------------------------------------------------------
* Title      :pract 3 part 2
* Written by :Kobi Bourne
* Date       :26/01/2026
* Description:show subtraction in an address, stored in an address registor 
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

* Put program code here

    LEA $4000, A2       ;loads address $4000 into Add reg A2
    MOVE.B #100, (A2)   ;copy(B-8Bits)dec-val 100(64Hex) into the address stored in A1 - $4000
    SUB.B #10, (A2)     ;subtract(B-8Bits)dec-val 10(AHex) from the val at add stored in A1  
                        ;100 - 10 = 90, 90 in hex = 90/16 = 5 r10, 5/16 = 0 r 5 = 5A 

    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
