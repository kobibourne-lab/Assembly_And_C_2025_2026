*-----------------------------------------------------------
* Title      :PRACTICAL 4 part 4 
* Written by :Kobi Bourne
* Date       :04/02/26
* Description: task 4 
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

* Put program code here
    LEA PLAYERHP, A0       ;loads address of PLAYERHP into Add reg A0
    MOVE.B  #$64, (A0)     ;copy(B-8Bits) hex-val $64 to the address stored in A0  
                           ;sets player health to 100!!
    LEA PLAYERXP, A1       ;loads address of PLAYERXP into Add reg A1
    MOVE.B   #%101, (A1)
                           ;sets player xp to 5!!
    LEA PLAYERPOSX, A2
    MOVE.W   #10, (A2)
                           ;sets player pos(x) to 10!!
    LEA PLAYERPOSY, A3
    MOVE.W   #21, (A3)
                           ;sets player pos(y) to 21!!      
    LEA BOSSHP, A4         ;loads address of boss health into Add reg A4
    MOVE.L  #1000, (A4)      
                           ;sets Boss health to 1000!! 
    LEA BOSSPOSX, A5
    MOVE.W   #24, (A5)
                           ;sets boss pos(x) to 24!!
    LEA BOSSPOSY, A6
    MOVE.W   #11, (A6)
                           ;sets boss pos(y) to 11!!    

    ;Branch To TAKING_DAMAGE
    BSR     TAKING_DAMAGE
    
BACK_IN_THE_GAME:
    ;Lets Help this player out
    BSR     HEALTH_PICKUP
    BSR     XP_PICKUP
    BSR     BLOCK_PLAYER
    BSR     CHANGE_Y
    BRA     GAME_END
    
TAKING_DAMAGE:
    ;Hit By NPC
    SUB.B   #20, (A0)
    BRA     BACK_IN_THE_GAME

HEALTH_PICKUP:
    ;Pickup Health Found
    ADD.B   #10, (A0)
    RTS
    
XP_PICKUP:
        MOVE.B  (A1), D0        ;load XP into data register
        OR.B    #1, D0          ;player +1 XP bonus
        MOVE.B  D0, (A1)        ;store XP in add reg
        RTS

BLOCK_PLAYER:
        MOVE.W  (A2), D0        ; load X position
        AND.W   #15, D0         ; AND: limit X position (0–15)
        MOVE.W  D0, (A2)        ;store X pos in a2
        RTS

CHANGE_Y:
        MOVE.W  (A3), D0        ;COPY Y pos to data reg 
        EOR.W   #1, D0          ;CHANGE Y pos
        MOVE.W  D0, (A3)        ;store Y pos A3
        RTS
    
GAME_END:
    ;Game Over
    MOVE.B #$00, (A0)
    
    
    SIMHALT             ; halt simulator

* Put variables and constants here
PLAYERHP  dc.b    $0 
PLAYERXP  dc.b    $0
PLAYERPOSX  dc.w    $0
PLAYERPOSY  dc.w    $0
BOSSHP  dc.l    $0
BOSSPOSX  dc.w    $0
BOSSPOSY  dc.w    $0

    END    START        ; last line of source



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
