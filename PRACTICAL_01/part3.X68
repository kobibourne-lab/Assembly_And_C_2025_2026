*-----------------------------------------------------------
* Title      : task 3 
* Written by : kobi bourne 
* Date       : 14/01/2026
* Description: task 3 
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

* Put program code here
    MOVE.B #$64, D1

    LEA text, A1 

    MOVE #14, D0

    TRAP #15

    MOVE #3, D0

    TRAP #15

    SIMHALT:

    text:   dc.b 'Data Register: ', 0

    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
