global main     
extern printf ;use for print output - 14 in 68k 
extern scanf ;use to get input - 4 in 68k

section .data  ;var section 
    ask_input db "Enter number: ", 0 ; messages , db saves byte in mem
    input_format db "%d", 0 ;input type is %d = decimaml  
    temp_res_msg db "The sum is: %d", 10, 0 ; 10 = newline , 0 = end of string
    total_msg db "Final sum is: %d", 10, 0 ;final total message 
    error_msg db "Invalid input!", 10, 0   ; if input not num message 
    clear_char db "%c", 0
    x dd 0 ; first num , start at 0
    y dd 0


section .text ; code part 

; add usnig stack now rsp - sp- for show not used yet
add_func:
    push rbp            ;save base pointer
    mov rbp, rsp        ;load sp into bp for reading parameters

    ; get parametres from stack 
    mov rax, [rbp+16]     ; first num - 2nd pushed val 
    mov rdx, [rbp+24]     ; second num - first push val
    add rax, rdx          ; add vals, result store in rax, 

    pop rbp           ;restore base pointer
    ret               ;return

;reg pass adding -adds 2 ints in registers rdi and rsi 
add_reg:
    mov rax, rdi      ; first parameter passed ftom reg rdi to rax
    add rax, rsi      ; add first and second
    ret               ;return to sender

main:
    push rbp          ;save base pointer before we use
    mov rbp, rsp      ;set stack frame 
    push r15          ; save r15 -use it for loop counter
    push rbx          ;save rbx for total
    mov rbx, 0        ;total set to 0 
    mov r15, 1        ; loop counter set to 0 
                      ;changed to r15 from rcx as it gets overwritten by printf/scanf 
GAME_LOOP:            ;start loop

    ; ask for first num
    lea rdi, [rel ask_input]   ;load address of input string into rdi 
    mov rax, 0                 ;set rax to 0- no float argumeents 
    call printf                ; call print string

    lea rdi, [rel input_format]    ;loadd add of format, tells scanf ints 
    lea rsi, [rel x]               ;load x add into rsi 
    mov rax, 0                     ;set arx to 0 , must do or causes issue 
    call scanf                     ;read int , stored in add of x

    cmp rax, 1                     ;if scanf reads anything other then 1
    jne input_invalid              ;jump to invlid(if not num - letter etc)

    ;check range for x
    mov eax, [x]         ;copy x into eax (e regs = 32 bit , x is dd = 32 bit)
    cmp eax , 1          ;compare x to 1
    jl input_invalid     ; if less then jump to invalid 
    cmp eax, 10000       ;compares x to 10000
    jg input_invalid     ;if greater then 10000 jump to invalid
   
    ;ask for second number
    lea rdi, [rel ask_input]     ;load input string into rdi
    mov rax, 0                   ;set rax to 0 befoe print
    call printf                  ;print input string 

    lea rdi, [rel input_format]   ;load format for ints 
    lea rsi, [rel y]              ;load y into rsi
    mov rax, 0                    ;set rax to 0 
    call scanf                    ;read int- y

    cmp rax, 1                    ;if scanf reads not 1, go to invalid 
    jne input_invalid             ; if not num go to invalid input 

    ;check range of y 
    mov eax, [y]          ;load y into eax
    cmp eax, 1            ;compare y to 1
    jl input_invalid      ;if less then 1 - jump to invalid
    cmp eax, 10000        ;compare y to 100000
    jg input_invalid      ;if greater then 10000 jump to invalid

    ;use add reg on x and y
    mov edi, [x]     ;load x into edi instead of rdi - 32 bit
    mov esi, [y]     ;load y into esi
    call add_reg     ;call add, results stored in rax

    add rbx, rax      ; add result to current total

    ; print this result 
    mov rsi, rax                      ;load result into rsi reg
    lea rdi, [rel temp_res_msg]       ;load res message intp rdi- string first then int
    mov rax, 0                        ;set rax to 0 before print
    call printf                       ;print res message 

    ; loop logic
    inc r15            ; increment counter (r15 doesnt break it)
    cmp r15, 4         ;compare to 3 , if counter = 3 end 
    jne GAME_LOOP      ;if not 3 loop again 

    ; print overall total
    mov rsi, rbx                       ;load total in rsi 
    lea rdi, [rel total_msg]           ;load total message add
    mov rax, 0                         ;set rax to 0 
    call printf                        ;print total message 
    jmp done                           ; jump to done

input_invalid:
    ; if input invalid
    lea rdi, [rel error_msg]     ;load error message 
    mov rax, 0                   ;set rax to 0
    call printf                  ;print invalid message
    
    ; clear char out of buffer
    ; without this repeats invalid message 
    lea rdi, [rel clear_char]    ;read char
    lea rsi, [rel x]             ;use x as bin , gets overwritten in loop 
    mov rax, 0
    call scanf            ; reads + deletes char

    jmp GAME_LOOP                ;jump back to loop  

done:
    ;exit
    pop rbx          ;restore rbx 
    pop r15          ; restore r15  
    mov rsp, rbp     ;restore stack pointer 
    pop rbp          ;restore base pointer
    ret              ;return from main
