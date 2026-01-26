*-----------------------------------------------------------
* Title      :pract 3 part 5
* Written by :Kobi Bourne
* Date       :26/01/2026
* Description:show an Array and traversing an Array.
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

* Put program code here

    MOVEA.L #ACHIEVEMENT_POINTS, A1 ;cpoy add of ACH. into A1
    MOVE.L  #0, D0                  ;copy 0 into D0
    
    MOVE.L  (A1)+, D2               ;copy val at add in A1(5) into D0, + = move to next val sddress
    ADD.L   D2, D0                  ;ADD values at D2 TO D0 , D0 = 5 D2 = 5 
    
    MOVE.L  (A1)+, D2               ;copy val at add in A1(A) into D0, + = move to next val sddress
    ADD.L   D2, D0                  ;ADD values at D2 TO D0 , D0 = F D2 = A 
    
    MOVE.L  (A1)+, D2               ;copy val at add in A1(F) into D0, + = move to next val sddress
    ADD.L   D2, D0                  ;ADD values at D2 TO D0 , D0 = 1E D2 = F 
    
    MOVE.L  (A1)+, D2               ;copy val at add in A1(14) into D0, + = move to next val sddress
    ADD.L   D2, D0                  ;ADD values at D2 TO D0 , D0 = 32  D2 = 14 
                                    
    MOVE.L  (A1)+, D2               ;copy val at add in A1(1E) into D0, + = move to next val sddress
    ADD.L   D2, D0                  ;ADD values at D2 TO D0 , D0 = 50 D2 =  1E    
                                    ;D2 = each array element, stepped through
    
    

    SIMHALT             ; halt simulator

* Put variables and constants here
ACHIEVEMENT_POINTS:   DC.L  5, 10, 15, 20, 30

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
