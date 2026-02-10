*-----------------------------------------------------------
* Title      :practical_5_part 5
* Written by :kobi bourne
* Date       :10/02/2026
* Description:part 5 
*-----------------------------------------------------------
        ORG     $1000

; D0 Used for Trap Codes, An Counting ENEMIES
; D1 Used for Players Health
; D2 Used for Enemy Positions
; D4 used for ENEMY count
; A0 for counting enemies
; A1 for progress messages
; A2 used for PLAYER_X
; A3 used for ENEMY_POSITIONS
; A4 POWERUP
 

DAMAGE      EQU     10      ; Damage when Collisions occur
HEAL        EQU     5       ; Health when gets power up

START:
        LEA     PLAYER_X, A2            ; Player will move along X axis
        LEA     ENEMY_POSITIONS, A3     ; Enemy positions or spawn points
        LEA     POWER_UPS, A4           ; Load power ups array first index into a4
        BRA     GAME_LOOP

GAME_LOOP:
        BSR     COUNT_ENEMIES           ; Size of the ENEMY_POSITIONS Array
        MOVE.B  D0, D4                  ; Reset Enemy count at beginning of loop

        LEA     MSG_GAMELOOP, A1        ; Load and Draw Gameloop Message
        BSR     DRAW

        BSR     UPDATE                  ; Call UPDATE
        BRA     GAME_LOOP               ; Call GAME_LOOP

UPDATE:
        MOVE.B  PLAYER_HEALTH, D1       ; Move Player Health into D1

        LEA     MSG_HEALTH, A1           ; Load and Draw Health Message
        BSR     DRAW

        MOVE.B  #3, D0                  ; Display signed number in D1.L in decimal in smallest field
        TRAP    #15

        LEA     CRLF, A1                ; Load and Carriage Return and Line Feed
        BSR     DRAW

        CMP     #0, D1                  ; Check if Health is 0
        BEQ     GAME_OVER               ; Game Over

        ADD.L   #1, PLAYER_X            ; Change X position of Player
        BSR     POWER_UP                ;check for power up
        BSR     COLLISION               ; Check for Collisions with ENEMIES
        RTS

DRAW:
        MOVE.B  #13, D0
        TRAP    #15
        RTS

COLLISION:
        MOVE.B  #1, D5                  ; Loop through Array
        LEA     ENEMY_POSITIONS, A3     ; Load ENEMY_POSITIONS Array

ITERATE:
        CMP     D5, D4                  ; Counter for ENEMY_POSITIONS
        ADD.B   #1, D5                  ; Subtract one
        BEQ     GAME_LOOP               ; If 0 goto GAME_LOOP
        BNE     CHECK_ENEMIES           ; If not Check for Enemy Collisions
        RTS

CHECK_ENEMIES:
        MOVE.L  (A3)+, D2               ; Move ENEMIES position to D2
        MOVE.L  (A2), D3                ; Move Player position to D3

        CMP.L   D2, D3                  ; Compare Player and Enemy position
        BEQ     REDUCE_HEALTH           ; If Equal reduce Health
        BNE     ITERATE                 ; Iterate to next Enemy

REDUCE_HEALTH:
        LEA     MSG_COLLISION, A1       ; Load and Draw Collision Message
        BSR     DRAW

        SUB.B   #DAMAGE, PLAYER_HEALTH

        LEA     MSG_DAMAGE, A1          ; Load and Draw Damage Message
        BSR     DRAW

        BRA     GAME_LOOP

GAME_OVER:
        LEA     MSG_GAMEOVER, A1
        BSR     DRAW
        SIMHALT

COUNT_ENEMIES:
        MOVE.B  #0, D0                  ; Initialize counter to 0
        LEA     ENEMY_POSITIONS, A0     ; Load the address of the array into A0

COUNT_ENEMIES_LOOP:
        TST.L   (A0)+                   ; Test the byte at the address in A0 (Check if 0) and increment A0
        BEQ     END_COUNTING            ; If the byte is zero, it's the end of the array

        ADD.B   #1, D0                  ; Increment the counter
        BRA     COUNT_ENEMIES_LOOP      ; Repeat the loop

END_COUNTING:
        RTS
        
POWER_UP:
        LEA POWER_UPS, A4               ;Loads POWER_UP[0] into A4
        
POWER_LOOP:
        MOVE.L  (A4)+, D6              ;cpoys A4 into D6 and increments 
        MOVE.L  PLAYER_X, D7           ;copy player pos into D7
        
        TST.L   D6                     ; Tests if (D6)=0 - end of array 
        BEQ     END_POWER              ;if d6=0 branch to end power, exit loop
        
        CMP.L  D6, D7                  ;compare vals in d6, d7
        
        BEQ     GIVE_POWER             ;if same branch to give power 
        BRA     POWER_LOOP             ; branch to power loop
       
      
GIVE_POWER:
        LEA     MSG_POWERUPS, A1       ; Load and Draw power up Message
        BSR     DRAW
        
        ADD.B   #HEAL, PLAYER_HEALTH    ;add heal val to player health
        BRA     POWER_LOOP              ;branch to power loop
    
END_POWER:
        RTS
        

PLAYER_X        DC.L    1
PLAYER_HEALTH   DC.B    100
MSG_HEALTH      DC.B    'Health : ', 0
MSG_GAMELOOP    DC.B    'Game Loop', 0
MSG_COLLISION   DC.B    'Collision', 0
MSG_GAMEOVER    DC.B    'Game Over', 0
MSG_DAMAGE      DC.B    'Taking Damage', 0
MSG_POWERUPS     DC.B    'Power Up!', 0

CRLF            DC.B    $0D, $0A, 0

ENEMY_POSITIONS DC.L    20, 30, 40, 50, 60, 70, 80, 90, 200, 300, 500, 0 ; Terminate Array with a 0
POWER_UPS       DC.L    10, 55, 220, 0                                   ; Terminate Array with a 0
     
       END     START


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
