*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
STRING2_L EQU 18
STRING1_L EQU 18
    
    ORG    $1000
START:                  ; first instruction of program

* Put program code here

* Display Strings

    LEA STRING1, A0
    MOVE.W #STRING1_L ,D0
    TRAP #14                ; Display string - cursur next line

    LEA STRING2,A0
    MOVE.W #STRING2_L,D0
    TRAP #15                ; Display string


* Read String from Keyboard

    
    MOVE.W #80,D0           ; sets Max chars
    TRAP #10                ; Read string into D0
    TRAP #15                ; Print 




* Read + Display Integer

    TRAP #11                ; Read Age into D0
    TRAP #15                ; Print Age              



* End Program


    TRAP #0                 ; End

* Put variables and constants here

STRING1: DC.B 'Hello!, Welcome , ',0
STRING2: DC.B 'Enter name and age',0

    END    START       



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
