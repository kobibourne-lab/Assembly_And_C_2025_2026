*-----------------------------------------------------------
* Title      : practical_06_part1.X68
* Written by : kobi bourne
* Date       : 25/02/26
* Description: pract 6 part 6
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

* Put program code here
     
        MOVE.L  #HEALTH, -(SP)     ; Note position in Stack

        MOVE.B  #14, D0
        MOVE.B  #14, D1

        MOVE.L  D0, -(SP)          ; Player X
        MOVE.L  D1, -(SP)          ; Enemy X

        JSR     GAME_LOOP
        BSR     HEADS_UP_DISPLAY
        BRA     END_GAME


GAME_LOOP:

        MOVE.L  4(SP), D1          ; Note depth in Stack
        MOVE.L  8(SP), D0          ; Note depth in Stack

        CMP     D0, D1
        BEQ     DAMAGE
        BRA     NO_DAMAGE


DAMAGE:
        MOVEA.L 12(SP), A1         ; Note depth in Stack
        SUB.B   #10, (A1)

NO_DAMAGE:
        RTS


HEADS_UP_DISPLAY:
        MOVE.B  HEALTH, D1
        MOVE.B  #3, D0
        TRAP    #15
        RTS


END_GAME:

        SIMHALT         ; halt simulator
        
* Put variables and constants here

HEALTH: DC.B 100

        END     START




 

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
