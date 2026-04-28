global main
extern printf ;use for print output
extern scanf ;use to get input 

section .data  ;var section 
    ask_input db "Enter number: ", 0 ; messages , db saves byte in mem
    input_format db "%d", 0 ;input type is %d = decimaml  
    temp_res_msg db "The sum is: %d", 10, 0 ; 10 = newline , 0 = end of string
    total_msg db "Final sum is: %d", 10, 0
    error_msg db "Invalid input!", 10, 0   ; if input not num 
    x dd 0 ; first num , start at 0
    y dd 0


section .text ; code part 

; add usnig stack now rsp - sp- for show not used 
add_func:
    push rbp
    mov rbp, rsp

    ; get parametres from stack 
    mov rax, [rbp+16]     ; first num - 2nd pushed val 
    mov rdx, [rbp+24]     ; second num - first push val
    add rax, rdx          ; add vals, 

    pop rbp           ;pop
    ret

;reg pass adding - needs to b called 
add_reg:
    mov rax, rdi      ; first parameter
    add rax, rsi      ; add first and second
    ret

main:
    push rbp
    mov rbp, rsp
    push r15          ; save r15 -use it for counter
    push rbx          ;save rbx for total
    mov rbx, 0        ;total sum (D3 in 68k)
    mov r15, 3        ; loop count- used r15 instead of rcx (D4 in 68k)
                     ;rcx gets clobbered by printf/scanf cant use
GAME_LOOP:

    ; ask for first num
    lea rdi, [rel ask_input]   ;load address of input into rdi 
    mov rax, 0
    call printf       ; call print or output

    lea rdi, [rel input_format]
    lea rsi, [rel x]  ;rel is relative addressing - safer 
    mov rax, 0
    call scanf

    cmp rax, 1
    jne input_invalid     ; if not num

    ;check range 
    mov eax, [x]         ;copy x inot eax
    cmp eax , 1
    jl input_invalid     ; if less then jump to invalid 
    cmp eax, 10000
    jg input_invalid      ;if greater then 10000 jump to invalid
   
    ;ask for second number
    lea rdi, [rel ask_input]
    mov rax, 0
    call printf

    lea rdi, [rel input_format] 
    lea rsi, [rel y]
    mov rax, 0
    call scanf

    cmp rax, 1 ;compare to 1 
    jne input_invalid ; if not num go to invalid input 

    ;check range of y 
    mov eax, [y]
    cmp eax, 1
    jl input_invalid      ;if less then
    cmp eax, 10000
    jg input_invalid      ;if greater then 

    mov edi, [x]     ;load x into edi instead of rdi - 32 bit
    mov esi, [y]
    call add_reg 

    add rbx, rax      ; add to res total

    ; print result 
    mov rsi, rax
    lea rdi, [rel temp_res_msg]
    mov rax, 0
    call printf

    ; loop logic
    dec r15            ; decrement counter (r15 is safe print doesnt break it)
    cmp r15, 0
    jne GAME_LOOP

    ; final print
    mov rsi, rbx
    lea rdi, [rel total_msg]
    mov rax, 0
    call printf
    jmp done ; jump to done

input_invalid:
    ; if input invalid
    lea rdi, [rel error_msg]
    xor rax, rax
    call printf
    jmp GAME_LOOP           ;jump so rbx and r15 get popped 

done:
    pop rbx          ;restore rbx
    pop r15          ; reset r15 
    mov rsp, rbp
    pop rbp
    ret
