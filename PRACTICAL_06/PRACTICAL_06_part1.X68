*-----------------------------------------------------------
* Title      : practical_06_part1.X68
* Written by : kobi bourne
* Date       : 25/02/26
* Description: pract 6 part 1 
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

* Put program code here

        ; Move Trap Task to D0
        MOVE.B  #2, D0
        ; Interupt and Trap Task
        TRAP    #15

        LEA     MESSAGE, A1
        MOVE.B  #13, D0
        TRAP    #15

END_PROG:             ; halt simulator

* Put variables and constants here

MESSAGE: DC.B 'Trap Task Test', 0

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
