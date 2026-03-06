*-----------------------------------------------------------
* Title      : pract 6 part 6 
* Written by : kobi
* Date       :
* Description: 
*-----------------------------------------------------------

    
    ORG    $1000
START:                  ; first instruction of program

* Put program code here


        LEA     MSG1,A1  ;print string
        MOVE.B  #14,D0
        TRAP    #15


        MOVE.B  #2,D0  ;wait for key input
        TRAP    #15


        LEA     MSG2,A1 ;print string ask for int
        MOVE.B  #14,D0
        TRAP    #15


        MOVE.B  #4,D0 ;read int in
        TRAP    #15
        MOVE.B  D1,NUM


        LEA     MSG3,A1  ;print string
        MOVE.B  #14,D0
        TRAP    #15


        MOVE.B  NUM,D1    ;print int
        MOVE.B  #3,D0
        TRAP    #15


        LEA     MSG4,A1 ;print and wait for input
        MOVE.B  #14,D0
        TRAP    #15
        MOVE.B  #2,D0
        TRAP    #15


        MOVE.B  #11,D0 ;clear screen
        TRAP    #15

        SIMHALT  ;end of prog

*-------------------------------------------------------
*-------------------DATA DECLARATIONS--------------------
*-------------------------------------------------------

NUM:    DC.B 0
MSG1:   DC.B 'TRAP DEMO START', $0D,$0A
        DC.B 'Press any key...', $0D,$0A, 0
MSG2:   DC.B $0D,$0A,'Enter a number: ',0
MSG3:   DC.B $0D,$0A,'You entered: ',0
MSG4:   DC.B $0D,$0A,'Press key to clear screen...',0

        END START
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
