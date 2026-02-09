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
    LEA PLAYERSHIELD, A1   ;loads address of PLAYERSHIELD into Add reg A1
    MOVE.B   #0, (A1)      ;sets player shield to off!!
    
    LEA PLAYERPOSX, A2
    MOVE.W   #10, (A2)
                           ;sets player pos(x) to 10!!
    LEA PLAYERPOSY, A3
    MOVE.W   #10, (A3)
                           ;sets player pos(y) to 10!!      
    LEA BOSSHP, A4         ;loads address of boss health into Add reg A4
    MOVE.L  #1000, (A4)      
                           ;sets Boss health to 1000!! 
    LEA BOSSPOSX, A5
    MOVE.W   #15, (A5)
                           ;sets boss pos(x) to 15!!
    LEA BOSSPOSY, A6
    MOVE.W   #10, (A6)
                           ;sets boss pos(y) to 10!!   
     

    ;Branch To TAKING_DAMAGE
    BSR     TAKING_DAMAGE
    
BACK_IN_THE_GAME:
    ;Lets Help this player out
    BSR     HEALTH_PICKUP
    BSR     SHIELD_PICKUP
    BSR     SHIELD_OFF:
    BSR     DODGE
    BRA     GAME_END
    
TAKING_DAMAGE:
    ADD.W   #4, (A2)        ;player moves close to boss
    SUB.B   #20, (A0)       ;Hit By NPC
    SUB.L   #350,   (A4)    ;HITS NPC
    SUB.W   #4, (A2)        ;player retreats
    BRA     BACK_IN_THE_GAME

HEALTH_PICKUP:
    ;Pickup Health Found
    ADD.B   #10, (A0)
    RTS
    
SHIELD_PICKUP:
        MOVE.B  (A1), D3        ;load shield off into data register
        OR.B    #1, D3          ;Sheild on
        MOVE.B  D3, (A1)        ;copy Shield on in add reg
        RTS

SHIELD_OFF:
        MOVE.B  (A1), D3       
        AND.B   #0, D3         ; AND - turn off shield
        MOVE.B  D3, (A1)        
        RTS

DODGE:
        SUB.W   #4, (A5)        ;boss moves to player and attacks
        MOVE.W  (A3), D1        ;copy player Y pos to data reg 
        EOR.W   #1, D1          ;player dodges
        MOVE.W  D1, (A3)        ;store pos 
        EOR.W   #1, D1          ;player moves back
        MOVE.W  D1, (A3)        ;store pos
        SUB.L   #650, (A4)      ;player counter attacks, extra damage
         
        
        RTS
    
GAME_END:
    ;Game Over
    MOVE.B #$00, (A0)
    
    
    SIMHALT             ; halt simulator

* Put variables and constants here
PLAYERHP  dc.b    $0 
PLAYERSHIELD  dc.b    $0
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
