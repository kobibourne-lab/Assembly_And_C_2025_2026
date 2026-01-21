*-----------------------------------------------------------
* Title      :pract 2 part 4
* Written by : kobi bourne
* Date       :19/01/2026
* Description:pract 2 part 4 
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

* Put program code here

    MOVE.L  #%101,  $2000  ;copy binary-val into REG-D0 
    MOVE.W  #$120,  $2000  ;copy hex-val into REG-D1   all long(32bits)
    MOVE.B  #100,   $2000  ;copy dec-val into REG-D2
    
    MOVE.L  #90,    $2010  ;copy dec-val into mem-add 3010  MOVING DATA TO MEMORY
    MOVE.W  #$121,  $2010  ;copy hex-val into mem-add 3020 all word(16bits)
    MOVE.B  #%1010, $2010  ;copy binary-val into mem-add 3000
    
    MOVE.L  #111,   $2020  ;copy dec-val into mem-add 3010
    MOVE.W  #$111,  $2020  ;copy hex-val into mem-add 3020 all word(16bits)
    MOVE.B  #%111,  $2020  ;copy binary-val into mem-add 3000
    
    MOVE.L  $2000, D0   ;copy contents in memory address $2000 into D0 L(32bits)
    MOVE.W  $2010, D1   ;copy contents in memory address $2010 into data register D1 W(16bits) 
    MOVE.B  $2020, D2  ;copy contents in memory address $2020 into data register D2 B(8bits) 
     
    MOVE.L  $2000, $3000   ;copy contents in memory address $2000 into memory address $3000 L(32bits) 
    MOVE.W  $2000, $3010   ;copy contents in memory address $2000 into memory address $3010 W(16bits)     
    MOVE.B  $2000, $3020   ;copy contents in memory address $2000 into memory address $3020 B(8bits)
     
    MOVE.L  #%1010, D3   ;move binary val #%1010 into data register D3 L(32bits)
    MOVE.W  #$76, D4     ;move hex val #$76 into data register D4 W(16bits)
    MOVE.B  #23, D5      ;move dec val #23 into data register D5 B(8bits)
    
    

   

    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
