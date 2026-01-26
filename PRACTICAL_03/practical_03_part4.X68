*-----------------------------------------------------------
* Title      :pract 3 part 4
* Written by :Kobi Bourne
* Date       :26/01/2026
* Description:show data moving in a regs and altering values within the stored add , in a game setting
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
                          
    
    LEA PLAYERPOSX, A2
    ADD.W   #13, (A2)
                           ;player moves!!
    LEA PLAYERPOSY, A3
    SUB.W   #9, (A3)
                           ;player moves close to boss!!
    
    LEA BOSSHP, A4
    SUB.L  #400, (A4)
                           ;player attcaks boss, boss health now #600
    LEA PLAYERXP, A1
    ADD.B   #%101, (A1)
                           ;player gains xp, now %1010
                          
    LEA PLAYERHP, A0
    SUB.B   #$47, (A0)
                           ;boss counters, player health now #21
    LEA PLAYERPOSX, A2
    SUB.W   #10, (A2)
                           ;player moves!
    LEA PLAYERHP, A0
    ADD.B   #$47, (A0)
                           ;player heals!! player health now #64               
    LEA BOSSPOSX, A5
    SUB.W   #10, (A5)
                           ;boss moves to player!!                                             
    LEA BOSSHP, A4
    SUB.L  #600, (A4)
                           ;player attcaks boss, boss health now #0, BOSS DEFEATED!!
        
                           
    
    
    

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

