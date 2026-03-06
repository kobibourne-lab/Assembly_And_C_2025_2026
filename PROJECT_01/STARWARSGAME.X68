*-----------------------------------------------------------
* Title      : Star wars 
* Written by : Kobi Bounre 
* Date       : 20/02/2026
* Description: STAR WARS THEMED ROOM SURVIVAL ADVENTURE 
*-----------------------------------------------------------





    ORG $1000  ;PROGRAM STARTS HERE 

*-------------------------------------------------------
*VALIDATION VALUES TO BE USED, MODIFY AS NEEDED
*-------------------------------------------------------

EXIT		EQU 0   ;CONSTANT EXIT = 0


*START OF GAME   
START:
    BSR     WELCOME             ;BRANCH TO WELCOME - PRINT MSG
    BSR     CHARACTER           ;BRANCH TO CHARACTER - PICK CHAR
    LEA     MOVE_MSG,A1         ;LOAD ADD OF MOVE_MSG INTO A1
    MOVE.B  #14,D0              ;TRAP 14 USED TO PRINT STRING IN A1
    TRAP    #15                 ;TRAP 15 EXECUTES FUNCTION
    MOVE.B  #2,D0               ;TRAP 2, INT READ FROM KEYBOARD - WAIT FOR KEY PRESS 
    TRAP    #15                 ;TRAP 15 EXECUTES FUNCTION
    MOVE.B  #1,ROOM_NUM         ;SET ROOM NUM TO 1 

*GAME LOOP
  

*-------------------------------------------------------
*-------------------GAME SUBROUTINE---------------------
*-------------------------------------------------------
GAME:
    BSR     GAME_LOOP        ;BRANCH TO GAMELOOP SUBROUTINE
    RTS                      ;RETURN FROM GAME: SUBROUTINE
          
END:                         ;IF BRANCH TO END - SIMHAULT(END PROGAM)
    SIMHALT
    
    
*-------------------------------------------------------
*-------------------WELCOME SUBROUTINE------------------
*-------------------------------------------------------
WELCOME:
    LEA     INTRO,A1        ;LOAD ADD OF INTRO INTO A1
    MOVE.B  #14,D0          ;TRAP 14 USED TO PRINT STRING IN A1
    TRAP    #15             ;TRAP 15 EXECUTES FUNCTION
    RTS                     ;RETURN TO START 


*-------------------------------------------------------
*----------------CHARACTER-------------------
*------------------------------------------------------- 
CHARACTER:
    LEA     CHAR_MSG,A1        ;LOAD ADD OF CHAR MSG INTO A1
    MOVE.B  #14,D0             ;TRAP 14 USED TO PRINT STRING IN A1
    TRAP    #15                ;TRAP 15 EXECUTES FUNCTION
    MOVE.B  #4,D0              ;TRAP 4 READ INT(SELECTION) FROM KEYBOARD
    TRAP    #15                ;TRAP 15 EXECUTES FUNCTION
    CMP.B   #1,D1              ;COMPARE 1 WITH INPUT
    BEQ     JEDI               ;IF EQUAL BRANCH TO SET JEDI 
                               ;ELSE BRANCH TO SITH(FALL THRU) 
SITH:
    LEA     SITH_MSG,A1        ;LOAD ADD OF SITH MSG INTO A1
    MOVE.B  #14,D0             ;TRAP 14 USED TO PRINT STRING IN A1
    TRAP    #15
    MOVE.B  #40,HEALTH         ;SETS SITH STATS - HEALTH = 40 
    MOVE.B  #100,POWER         ;POWER = 100
    RTS                        ;BACK TO START
JEDI:
    LEA     JEDI_MSG,A1        ;LOAD ADD OF SITH MSG INTO A1
    MOVE.B  #14,D0             ;TRAP 14 USED TO PRINT STRING IN A1
    TRAP    #15
    MOVE.B  #70,HEALTH         ;SETS JEDI STATS - HEALTH = 70 
    MOVE.B  #50,POWER          ;POWER = 50
    RTS                        ;BACK TO START

*-------------------------------------------------------
*----------------GAMELOOP (MAIN LOOP)-------------------
*------------------------------------------------------- 
    
GAME_LOOP:
    BSR     HUD             ;PRINT AT EACH ROOM, LINE + MESSAGE 
    BSR     ROOMS           ;SETS EFFECT/EVENT BASED ON WHAT ROOM WE IN AND WHAT PATH WE TAKE 
    
    MOVE.B  HEALTH,D1        ;MOVE HEALTH TO D1 FOR COMPARING
    CMP.B   #0,D1            ;IF HEALTH = 0
    BLE     DEAD             ;BRANCH TO DEAD/ PLAYER DEAD
    
    MOVE.B  ROOM_NUM,D1      ;MOVE ROOM NUM TO D1 FOR COMPARING
    CMP.B   #10,D1           ;IF ROOM = 10
    BEQ     WIN              ;BRANCH TO WIN

    BSR     MOVE             ;BRANCH TO MOVE
    BRA     GAME_LOOP        ;BACK TO START OF LOOP 

*-------------------------------------------------------
*----------------ROOMS + EVENTS-------------------------
*------------------------------------------------------- 
                               ;SETS WHAT ROOM TO GO IN AND WHAT EFFECT
ROOMS:                         ;ALL ROOMS BAR 1 AND 10 HAVE EFFECT/EVENT OPTIONS
    MOVE.B ROOM_NUM,D1         ;CURRENT ROOM TO D1

;-- ROOM 1 -- COMPARES 1 TO ROOM NUM, IF SAME PRINT ENTER MSG., IF NOT EQUAL BRANCH TO NEXT ROOM 
    CMP.B #1,D1                 
    BNE CHECK_ROOM_2
    LEA     ENTER_MSG,A1
    MOVE.B  #14,D0
    TRAP    #15
    RTS

;-- ROOM 2 -- COMPARES 2 TO ROOM NUM, IF SAME CMP CHOICE VAL TO 1, IF EQUAL GO TO TRAP ROOM, IF NOT GO TO SAFE ROOM

CHECK_ROOM_2:
    CMP.B #2,D1                  ;COMPARE D1 VAL WITH 2 - IS PLAYER IN ROOM 2?
    BNE CHECK_ROOM_3             ;IF NOT EQUAL, PLAYER NOT IN ROOM, BRANCH T0 NEXT ROOM CHECK
    CMP.B #1,CHOICE              ;COMPARE PLATER PATH SEL TO 1 
    BEQ TRAP_ROOM                ;IF EQUAL(PLAYER PICKS 1) GO TO TRAP ROOM 
    BSR SAFE_ROOM                ;IF NOT EQUAL(PLAYER PICKS 2) GO TO SAFE ROOM 
    RTS                          ;RETURN TO GAME LOOP

;---------------- ROOM 3 ---------------- 
CHECK_ROOM_3:
    CMP.B #3,D1
    BNE CHECK_ROOM_4
    CMP.B #1,CHOICE               ;NEXT ROOMS ARE ALL SAME LOGIC WITH DIFFERENT EVENT OPTIONS(BAR 10)
    BEQ RIDDLE
    BSR POWER_ROOM
    RTS

;---------------- ROOM 4 ---------------- 
CHECK_ROOM_4:
    CMP.B #4,D1
    BNE CHECK_ROOM_5
    CMP.B #1,CHOICE
    BEQ ENEMY
    BSR POSION_ROOM
    RTS

;---------------- ROOM 5 ---------------- 
CHECK_ROOM_5:
    CMP.B #5,D1
    BNE CHECK_ROOM_6
    CMP.B #1,CHOICE
    BEQ HEAL_ROOM
    BSR SAFE_ROOM
    RTS
    
;---------------- ROOM 6 ---------------- 
CHECK_ROOM_6:
    CMP.B #6,D1
    BNE CHECK_ROOM_7
    CMP.B #1,CHOICE
    BEQ HEAL_ROOM
    BSR RIDDLE2
    RTS
    
;---------------- ROOM 7 ---------------- 
CHECK_ROOM_7:
    CMP.B #7,D1
    BNE CHECK_ROOM_8
    CMP.B #1,CHOICE
    BEQ TRAP_ROOM
    BSR POWER_ROOM
    RTS
    
;---------------- ROOM 8 ---------------- 
CHECK_ROOM_8:
    CMP.B #8,D1
    BNE CHECK_ROOM_9
    CMP.B #1,CHOICE
    BEQ HEAL_ROOM
    BSR ENEMY2
    RTS
    
;---------------- ROOM 9 ---------------- 
CHECK_ROOM_9:
    CMP.B #9,D1
    BNE CHECK_ROOM_10
    CMP.B #1,CHOICE
    BEQ TRAP_ROOM
    BSR POSION_ROOM
    RTS
    
;---------------- ROOM 10 ---------------- 
CHECK_ROOM_10:             
    RTS                     ;RETURN- GAME WILL GO TO WIN AND END


    
    
*-------------------------------------------------------
*----------------EVENT STATS ------------------------- ;MOSTLY THE SAME LOGIC, DIFF EFFECTS AND MSG
*------------------------------------------------------- 
    
TRAP_ROOM:                  ;FOR TRAP
    LEA     TRAP_MSG,A1     ;PUT TRAP MESSAGE ADD IN A1 
    MOVE.B  #14,D0          ;PUT TRAP 14 INTO D0 FOR STRING PRINT
    TRAP    #15             ;CALL TRAP FUNCTION THATS IN D0
    SUB.B   #20,HEALTH      ;SUB 20 FROM HEALTH  
    RTS                     ;RTS TO ROOMS
    
POSION_ROOM:                ;FOR POSION
    LEA     POSION_MSG,A1   
    MOVE.B  #14,D0
    TRAP    #15
    SUB.B   #20,HEALTH 
    SUB.B   #10,POWER        
    RTS


HEAL_ROOM:                   ;HEALTH PICKUP
    LEA     HEAL_MSG,A1         
    MOVE.B  #14,D0        
    TRAP    #15
    ADD.B   #20,HEALTH
    RTS
    
POWER_ROOM:                   ;POWER PICKUP
    LEA     POWER_MSG,A1        
    MOVE.B  #14,D0        
    TRAP    #15
    ADD.B   #20,POWER
    RTS    
    
    
SAFE_ROOM:                    ;SAFE ROOM
    LEA     SAFE_MSG,A1
    MOVE.B  #14,D0
    TRAP    #15
    RTS
    
ENEMY:                       ;WAMPA ENCOUNTER
    LEA     WAMPA_MSG,A1    
    MOVE.B  #14,D0
    TRAP    #15
                            ;NEED POWER TO DEFEAT WAMPA
    MOVE.B  POWER,D1        ;MOVE PLAYER POWER INTO D1
    CMP.B   #70,D1          ;COMPARE 70(NEEDED POWER) TO PLAYER POWER
    BLT     TAKE_DAMAGE     ;IF POWERR < 70, TAKE DAMAGE, ELSE NO DAMAGE &&
    LEA     SAD_WAMPA,A1    ;LOAD MESSAGE ADD INTO A1
    MOVE.B  #14,D0          ;MOVE 14 TO D0 FOR PRINTING
    TRAP    #15             ;PRINT WIN MESSAGE
    RTS                     ;RETURN TO SENDER 
    
ENEMY2:                     ;WOOKIE ENCOUNTER - SAME AS WAMPA JUST DIFF POWER+MSG
    LEA     WOOKIE_MSG,A1
    MOVE.B  #14,D0
    TRAP    #15
                            ;NEED POWER DEFEAT WOOKIE
    MOVE.B  POWER,D1
    CMP.B   #50,D1          ;COMPARE 50(NEEDED POWER) TO PLAYER POWER
    BLT     TAKE_DAMAGE     ; IF POWERR < 50, TAKE DAMAGE, ELSE NO DAMAGE &&
    LEA     SAD_WOOKIE,A1   ;LOAD MESSAGE ADD INTO A1
    MOVE.B  #14,D0          ;MOVE 14 TO D0 FOR PRINTING
    TRAP    #15             ;PRINT WIN MESSAGE
    RTS                     ;RETURN TO SENDER

TAKE_DAMAGE:
    LEA     HURT_MSG,A1
    MOVE.B  #14,D0
    TRAP    #15
    SUB.B   #50,HEALTH
    RTS
    
RIDDLE:                        ;RIDDLE 1
    LEA     RIDDLE_MSG,A1      
    MOVE.B  #14,D0
    TRAP    #15                ;PRINTS RIDDLE
    MOVE.B  #4,D0              
    TRAP    #15                ;READ ANSWER FROM KEYBOARD(INT)
    CMP.B   #2,D1              ;COMPARE 2 TO D1 VAL(INT ENTERED)
    BNE     RIDDLE_FAIL        ;BRANCH TO RIDDLE FAIL IF ENTERED INT NOT 2 
    RTS
    
RIDDLE_FAIL:
    LEA     FAIL_MSG,A1        ;LOAD FAIL MESSAGE ADD INTO A1 
    MOVE.B  #14,D0             ;PRINT WHATS IN A1
    TRAP    #15                ;PRINT 
    SUB.B   #10,HEALTH         ;SUB 10 FROM HEALTH 
    BRA     RIDDLE             ;LOOP TILL CORRECT - BUG - AS SOON AS HEALTH = 0 SHUD STOP
                               ;CURRENTLY WAITS TILL WE GET ANSWER RIGHT, THEN STOPS             
    
RIDDLE2:                       ;RIDDLE 2 - SAME AS RIDDLE 1 JUST DIFFERENT MSG
    LEA     RIDDLE2_MSG,A1
    MOVE.B  #14,D0
    TRAP    #15
    MOVE.B  #4,D0              
    TRAP    #15
    CMP.B   #2,D1              
    BNE     RIDDLE_FAIL
    RTS

*-------------------------------------------------------
*----------------MOVE------------------
*------------------------------------------------------- 
MOVE:
    LEA     DIR_MSG,A1          ;LOAD ADD OF DIR MSG INTO A1 FOR PRINTING
    MOVE.B  #14,D0
    TRAP    #15                 ;PRINT

CHOICE_VALID:                   ;CHECK IS CHOICE IN RANGE
    MOVE.B  #4,D0               ;READ KEYBOARD INPUT
    TRAP    #15 

    CMP.B   #1,D1               ;COMPARE 1 TO INPUT IN D1
    BLT     RANGE               ;IF< 1, BRANCH TO RANGE 

    CMP.B   #2,D1               ;COMPARE 2 TO INPUT IN D1
    BGT     RANGE               ;IF > 2, BRANCH RO RANGE 

    MOVE.B  D1,CHOICE           ;SAVE CHOICE FOR NEXT ROOM
    ADD.B   #1,ROOM_NUM         ;ADD 1 TO ROOM NUM - MOVE TO NEXT ROOM 
    RTS


RANGE:
    LEA     RANGE_MSG,A1       ;LOAD AND PRINT INVALID INPUT MSG
    MOVE.B  #14,D0
    TRAP    #15
    BRA     CHOICE_VALID       ;BRANCH BACK TO CHOICE VALID TO TRY INPUT AGAIN
*-------------------------------------------------------
*---------HUD + STATUS ---------------------------------
*------------------------------------------------------- 
HUD:
    LEA     HUD_MSG,A1         ;PRINTS LINE FOR READABLILITY + REPEATED ONWARD MESSAGE 
    MOVE.B  #14,D0             ;MOVE 14 INTO DO FOR PRINTING STRING
    TRAP    #15                ;PRINTS
    
                               ;PRINTING ROOM + HEALTH 
    LEA     ROOM_MSG,A1        
    MOVE.B  #14,D0
    TRAP    #15
    MOVE.B  ROOM_NUM,D1        ;PRINTING THE ACTUAL ROOM NUM
    MOVE.B  #3,D0              ;TRAP 3 PRINTS NUMBER IN D1(ROOM NUM)
    TRAP    #15                


    LEA     HEALTH_MSG,A1
    MOVE.B  #14,D0
    TRAP    #15
    MOVE.B  HEALTH,D1 
    MOVE.B  #3,D0
    TRAP    #15
    RTS
*-------------------------------------------------------
*----------------WIN/DEAD------------------------------- ;STOP IF WIN/DEAD
*------------------------------------------------------- 
WIN:
    LEA     WIN_MSG,A1     ;PRINTS WIN MSG AND ENDS GAME
    MOVE.B  #14,D0
    TRAP    #15
    BRA     END        

DEAD:
    LEA     DEAD_MSG,A1    ;PRINTS DEAD MSG AND ENDS GAME
    MOVE.B  #14,D0
    TRAP    #15
    BRA     END

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
            DC.B    '--- HELLO THERE! --- '
            DC.B    $0D,$0A
            DC.B    '--- WELCOME TO THE STAR WARS UNIVERSE! ---'
            DC.B    $0D,$0A
            DC.B    '--- ITS TIME TO EXPLORE AND FACE THE FORCE IN ---'
            DC.B    $0D,$0A
            DC.B    '--- STAR WARS: THE ICE CAVES OF ILUM ---'
            DC.B    $0D,$0A
            DC.B    '--- CHOOSE YOUR PATH AND ALLEGIANCE CAREFULLY!! ---'
            DC.B    $0D,$0A
            DC.B    '--- THE FORCE WILL GRANT DIFFERENT BOOSTS FOR JEDI AND SITH!! ---'
            DC.B    $0D,$0A
            DC.B    '-----------------------------------------------'
            DC.B    $0D,$0A,0
                    
CHAR_MSG:   DC.B    'Choose Path: 1. Jedi (High HP) | 2. Sith (High Power): ', $0D,$0A,0
JEDI_MSG:   DC.B    'YOU CHOOSE THE LIGHT SIDE!! I KNEW YOU LIKED THE HIGH GROUND ', $0D,$0A,0
SITH_MSG:   DC.B    'YOU CHOOSE THE DARK SIDE!! UNLIMITED POWER ', $0D,$0A,0
HUD_MSG:    DC.B    'ONWARD'
            DC.B    $0D,$0A
            DC.B    '----------------------------------' 
            DC.B    $0D,$0A,0
ROOM_MSG:   DC.B    'ROOM: ',0
HEALTH_MSG: DC.B    ' | HEALTH: ',0
MOVE_MSG:   DC.B    'Press any key to venture into the cave: ', $0D,$0A,0 ;needs an input added 
ENTER_MSG:  DC.B    $0D,$0A,'It appears that there is a many rooms ahead!'
            DC.B    $0D,$0A
            DC.B    'Time to explore!!', $0D,$0A, 0

SAFE_MSG:   DC.B    $0D,$0A,'This path seems to be quiet.... for now', $0D,$0A, 0
TRAP_MSG:   DC.B    $0D,$0A,'SAND!! YOU HATE SAND -50 HEALTH.', $0D,$0A,0
HEAL_MSG:   DC.B    $0D,$0A,'You found some bacta!. Health +20!', $0D,$0A,0
POWER_MSG:  DC.B    $0D,$0A,'You found a holocron. Power +20!', $0D,$0A,0
POSION_MSG: DC.B    $0D,$0A,'TRIPWIRE! YOU GOT HIT WITH A POSION DART', $0D,$0A,0
RIDDLE_MSG: DC.B    $0D,$0A,'RIDDLE: How many Suns does Tatooine have? (Hint: 1+1): ', $0D,$0A,0
FAIL_MSG:   DC.B    $0D,$0A,'WRONG. The Force repels you. -10 HP.', $0D,$0A,0
RIDDLE2_MSG: DC.B    $0D,$0A,'RIDDLE: How many DEATH STARS were built? (Hint: 1+7-3+1-4-1): ', $0D,$0A,0

DIR_MSG:    DC.B    $0D,$0A,' THE PATH SPLITS - 1: Go Left | 2: Go Right: ', $0D,$0A,0
WAMPA_MSG:  DC.B    $0D,$0A,'A WAMPA ATTACKS! You need 70 Power to defeat it!', $0D,$0A, 0
SAD_WAMPA:  DC.B    $0D,$0A,'You Cut its arm off!!', $0D,$0A, 0
HURT_MSG:   DC.B    $0D,$0A,'YOU NEED MORE POWER! THE WAMPA ATTACKS! -50 HP', $0D,$0A, 0
WOOKIE_MSG:  DC.B    $0D,$0A,'ITS THE ABOMINABLE WOOKIE!! You need 50 Power to defeat it!', $0D,$0A, 0
SAD_WOOKIE:  DC.B    $0D,$0A,'You aquired a new rug!!', $0D,$0A, 0
HURT2_MSG:   DC.B    $0D,$0A,'YOU NEED MORE POWER! THE WOOKIE STEALS YOUR JACKET! -50 HP', $0D,$0A, 0

RANGE_MSG:  DC.B $0D,$0A,'Invalid choice! 1 or 2.', $0D,$0A,0
WIN_MSG:    DC.B $0D,$0A,'CONGRATULATOINS!! You have found the Kyber Crystal!'
            DC.B    $0D,$0A
            DC.B    'You are now ready to bulit your lightsaber!', $0D,$0A, 0
DEAD_MSG:   DC.B    'You have become one with the Force', $0D,$0A,0

    END START
   

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
