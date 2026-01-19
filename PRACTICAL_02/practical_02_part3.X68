*-----------------------------------------------------------
* Title      :pract 2 part 3
* Written by : kobi bourne
* Date       :19/01/2026
* Description:pract 2 part 3 
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

* Put program code here

    MOVE.L  #%100,  D0  ;copy binary-val into REG-D0 
    MOVE.L  #$100,  D1  ;copy hex-val into REG-D1   all long(32bits)
    MOVE.L  #100,   D2  ;copy dec-val into REG-D2
    
    MOVE.L  D0, $3000   ;copy contents of D0 into mem-add 3000
    MOVE.L  D1, $3010   ;copy contents of D1 into mem-add 3010  all long(32bits)
    MOVE.L  D2, $3020   ;copy contents of D2 into mem-add 3020
    
    MOVE.W  #100,   $3020  ;copy dec-val into mem-add 3010
    MOVE.W  #$100,  $3010  ;copy hex-val into mem-add 3020 all word(16bits)
    MOVE.W  #%100,  $3000  ;copy binary-val into mem-add 3000

    MOVE.B  #100,  $3020  ;copy DEC-val into mem-add 3020    
    MOVE.B  #$64,  $3010  ;copy HEX-val into mem-add 3010   all byte(8bits)
    MOVE.B  #%10001111,  $3000  ;copy binary-val into mem-add 3000

    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
