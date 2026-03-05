*-----------------------------------------------------------
* Title      : Star wars 
* Written by : Kobi Bounre 
* Date       : 20/02/2026
* Description: STAR WARS THEMED ROOM  many problems rn - need gap after health num**
*structure a mess need to reorganise 
*-----------------------------------------------------------
*-------------------------------------------------------
* STARTING MEMORY ADDRESS FOR THE PROGRAMME $1000
*-------------------------------------------------------
	ORG $1000

*-------------------------------------------------------
*VALIDATION VALUES TO BE USED, MODIFY AS NEEDED
*-------------------------------------------------------

EXIT		EQU 0


*START OF GAME   
START:
    BSR     WELCOME             ;BRANCH TO WELCOME 
    BSR     CHARACTER           ;BRANCH TO CHARACTER
    LEA     MOVE_MSG,A1         ;MOVE CALLS INPUT - ANY KEY
    MOVE.B  #14,D0
    TRAP    #15
    MOVE.B  #2,D0               ;WAIT FOR KEY PRESS 
    TRAP    #15
    MOVE.B  #1,ROOM_NUM        ; START ROOM = 1

*GAME LOOP
    ;ORG     $3000           ;THE REST OF THE PROGRAM IS TO BE LOCATED FROM 3000 ONWARDS - get rid 

*-------------------------------------------------------
*-------------------GAME SUBROUTINE---------------------
*-------------------------------------------------------
GAME:
    BSR     GAME_LOOP        ;BRANCH TO GAMELOOP SUBROUTINE
    RTS                     ;RETURN FROM GAME: SUBROUTINE
          
END:
    SIMHALT
    
    
*-------------------------------------------------------
*-------------------WELCOME SUBROUTINE------------------
*-------------------------------------------------------
WELCOME:
    LEA     INTRO,A1
    MOVE.B  #14,D0
    TRAP    #15
    RTS


*-------------------------------------------------------
*----------------CHARACTER-------------------
*------------------------------------------------------- 
CHARACTER:
    LEA     CHAR_MSG,A1
    MOVE.B  #14,D0
    TRAP    #15
    MOVE.B  #4,D0
    TRAP    #15                ; GET CHAR CHOOSEN 
                               ;PROBLEM - IF I PRESS ENTER=  SITH, NEEDS A 1/2 - FIX
    CMP.B   #1,D1              ;1 = JEDI 
    BEQ     JEDI               ;IF EQUAL BRANCH TO SET JEDI 
                               ;IF NOT SITH 
SITH:
    MOVE.B  #40,HEALTH
    MOVE.B  #100,POWER
    RTS
JEDI:
    MOVE.B  #70,HEALTH
    MOVE.B  #50,POWER
    RTS

*-------------------------------------------------------
*----------------GAMELOOP (MAIN LOOP)-------------------
*------------------------------------------------------- 
    
GAME_LOOP:
    BSR     DISPLAY_HUD       ;REPEATS AT ENRTRY OF EVERY ROOM 
    BSR     ROOMS             ;TRAP/ENIMIES/HEAL 
    
    MOVE.B  HEALTH,D1           ;MOVE HEALTH TO D1 
    CMP.B   #0,D1               ;IF HEALTH = 0
    BLE     DEAD                 ;BRANCH TO DEAD/ PLAYER DEAD
    
    
    MOVE.B  ROOM_NUM,D1
    CMP.B   #5,D1           ;IF WIN(ROOM = 5)
    BEQ     WIN             ;BRANCH TO WIN

    BSR     MOVE               ;PATH
    BRA     GAME_LOOP          ;BACK TO START OF LOOP 

*-------------------------------------------------------
*----------------ROOMS + LOGIC -------------------------
*------------------------------------------------------- 
ROOMS:
    MOVE.B  ROOM_NUM,D1         ;CURRENT ROOM STORED IN D1
    
                               ;ROOM 2
    CMP.B   #2,D1              ;SEE IF ITS 
    BNE     CHECK_ROOM_3       ;SHUD SENT TO TRAP - FIX 
    CMP.B   #2,CHOICE          ;SAVE CHOICE
    BEQ     TRAP_ROOM          ;IF EQUAL - TRAP 
    BSR     SAFE_ROOM          ;IF NOT SAFE 
    RTS

CHECK_ROOM_3:
                             ;ROOM 3 - RIDDLE
    CMP.B   #3,D1
    BEQ     RIDDLE
    
                             ;ROOM 4 - WAMPA
    CMP.B   #4,D1
    BEQ     ENEMY
    RTS

NEXT_CHECK:
    CMP.B   #4,D2           ; IF ROOM = 4 
    BEQ     ENEMY           ; BRANCH EQUAL TO ENEMY 
    RTS
    
TRAP_ROOM:                  ;FOR TRAP
    LEA     TRAP_MSG,A1   
    MOVE.B  #14,D0
    TRAP    #15
    SUB.B   #20,HEALTH         
    RTS

HEAL_ROOM:                      ;HEALTH PICKUP
    LEA     HEAL_MSG,A1         ;WE NEVER ENCOUNTER THIS ? - FIX 
    MOVE.B  #14,D0        
    TRAP    #15
    ADD.B   #20,HEALTH
    RTS
    
SAFE_ROOM:
    LEA     SAFE_MSG,A1
    MOVE.B  #14,D0
    TRAP    #15
    RTS

*-------------------------------------------------------
*----------------MOVE------------------
*------------------------------------------------------- 
MOVE:
    LEA     DIR_MSG,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    MOVE.B  #4,D0
    TRAP    #15                ; FOR 1/2
    MOVE.B  D1,CHOICE       ; SAVE CHOICE
    
    ADD.B   #1,ROOM_NUM        ; ADD 1 TO ROOM - MOVE TO NEXT RIOM 
    RTS

*-------------------------------------------------------
*-----------------EVENTS - DAMAGE/HEAL/RIDDLE)--------------
*------------------------------------------------------- 
ENEMY:
    LEA     WAMPA_MSG,A1
    MOVE.B  #14,D0
    TRAP    #15
                            ;NEED POWER DEFEAT WAMPA
    MOVE.B  POWER,D1
    CMP.B   #70,D1          ;COMPARE 70(NEEDED POWER) TO PLAYER POWER
    BLT     TAKE_DAMAGE     ; IF POWERR < 70, TAKE DAMAGE, ELSE NO DAMAGE &&
    LEA     WIN_WAMPA,A1          ;LOAD MESSAGE ADD INTO A1
    MOVE.B  #14,D0          ;MOVE 14 TO D0 FOR PRINTING
    TRAP    #15             ;PRINT WIN MESSAGE
    RTS                     ;RETURN TO SENDER 

TAKE_DAMAGE:
    LEA     HURT_MSG,A1
    MOVE.B  #14,D0
    TRAP    #15
    SUB.B   #50,HEALTH
    RTS

RIDDLE:                     ;RIDDLE ROOM 
    LEA     RIDDLE_MSG,A1
    MOVE.B  #14,D0
    TRAP    #15
    MOVE.B  #4,D0              
    TRAP    #15
    CMP.B   #2,D1              ; SHUD BE 2 - I HAD 2 INSTEAD OF 4 TRAP  
    BNE     RIDDLE_FAIL
    RTS
    
RIDDLE_FAIL:
    LEA     FAIL_MSG,A1        ;LOAD FAIL MESSAGE ADD INTO A1 
    MOVE.B  #14,D0             ; FOR PRINT WHATS IN A1
    TRAP    #15                ;PRINT 
    SUB.B   #10,HEALTH         ;SUB 10 FROM HEALTH 
    BRA     RIDDLE             ;LOOP IF TILL CORRECT - FIX- AS SOON AS HEALTH = 0 SHUD STOP


*-------------------------------------------------------
*---------HEADS UP DISPLAY + STATUS --------------------
*------------------------------------------------------- 
DISPLAY_HUD:
    LEA     HUD_LINE,A1        ;PRINTS LINE FOR READABLILITY 
    MOVE.B  #14,D0             ;MOVE 14 INTO DO FOR PRINTING STRING
    TRAP    #15                ;PRINTS HUD LINE
    
                                
    LEA     ROOM_MSG,A1         ;PRINTING ROOM + HEALTH 
    MOVE.B  #14,D0
    TRAP    #15
    MOVE.B  ROOM_NUM,D1
    MOVE.B  #3,D0
    TRAP    #15


    LEA     HEALTH_MSG,A1
    MOVE.B  #14,D0
    TRAP    #15
    MOVE.B  HEALTH,D1 
    MOVE.B  #3,D0
    TRAP    #15
    RTS
*-------------------------------------------------------
*----------------WIN/DEAD-------------------------------
*------------------------------------------------------- 
WIN:
    LEA     WIN_MSG,A1
    MOVE.B  #14,D0
    TRAP    #15
    SIMHALT        ;STOP IF WIN/DEAD

DEAD:
    LEA     DEAD_MSG,A1
    MOVE.B  #14,D0
    TRAP    #15
    SIMHALT

*-------------------------------------------------------
*-------------------DATA DECLARATIONS--------------------
*-------------------------------------------------------
 
HEALTH:     DC.B    0
POWER:      DC.B    0
ROOM_NUM:   DC.B    0
CHOICE:     DC.B    0

CRLF:       DC.B    $0D,$0A,0
INTRO:      DC.B    '-----------------------------------------------'
            DC.B    $0D,$0A
            DC.B    'WELCOME TO THE STAR WARS UNIVERSE! '
            DC.B    $0D,$0A
            DC.B    'ITS TIME TO EXPLORE AND FACE THE FORCE IN '
            DC.B    $0D,$0A
            DC.B    '--- STAR WARS: THE ICE CAVES OF ILUM ---'
            DC.B    $0D,$0A
            DC.B    'CHOOSE YOUR PATHS AND ALEGENCE CAREFULLY!!:'
            DC.B    $0D,$0A
            DC.B    '-----------------------------------------------'
            DC.B    $0D,$0A,0
                    
CHAR_MSG:   DC.B    'Choose Path: 1. Jedi (High HP) | 2. Sith (High Power): ', $0D,$0A,0
HUD_LINE:   DC.B    'ONWARD'
            DC.B    $0D,$0A
            DC.B    '----------------------------------' 
            DC.B    $0D,$0A,0
ROOM_MSG:   DC.B    'ROOM: ',0
HEALTH_MSG: DC.B    ' | HEALTH: ',0
MOVE_MSG:   DC.B    'Press any key to venture into the cave: ', $0D,$0A,0 ;needs an input added 

SAFE_MSG:   DC.B    $0D,$0A,'This path seems to be quiet.... for now', $0D,$0A, 0
TRAP_MSG:   DC.B    $0D,$0A,'Gravity spike! You hit the ceiling.', $0D,$0A,0
HEAL_MSG:   DC.B    $0D,$0A,'You find a discarded medpac. Health restored!', $0D,$0A,0
RIDDLE_MSG: DC.B    $0D,$0A,'RIDDLE: How many Suns does Tatooine have? (Hint: 1+1): ', $0D,$0A,0
FAIL_MSG:   DC.B    $0D,$0A,'WRONG. The Force repels you. -10 HP.', $0D,$0A,0
DIR_MSG:    DC.B    $0D,$0A,' THE PATH SPLITS - 1: Go Left | 2: Go Right: ', $0D,$0A,0
WAMPA_MSG:  DC.B    $0D,$0A,'A WAMPA ATTACKS! You need 70 Power to defeat it!', $0D,$0A, 0
WIN_WAMPA:  DC.B    $0D,$0A,'You Cut its arm off!!', $0D,$0A, 0
HURT_MSG:   DC.B    $0D,$0A,'YOU NEED MORE POWER! THE WAMPA ATTACKS! -50 HP', $0D,$0A, 0


WIN_MSG:    DC.B    'CONGRATULATOINS!! You have found the Kyber Crystal!'
            DC.B    $0D,$0A
            DC.B    'You are now ready to bulit your lightsaber!', $0D,$0A, 0
DEAD_MSG:   DC.B    'You have become one with the Force', $0D,$0A,0

    END START
   
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
