.global main
extern printf ;use for print output
extern scanf ;use to get input 

section .data  ;var section 
    ask_input db "Enter number: ", 0 ; messages , db saves byte in mem
    input_format db "%d", 0 ;input type is %d = decimaml  
    temp_res_msg db "The sum is: %d", 10, 0 ; 10 = newline , 0 = end of string
    total_msg db "Final sum is: %d", 10, 0
    error_msg db "Invalid input!", 10, 0   ; if input not num 
    x db 0 ; first num , start at 0
    y db 0


section .text ; code part 

; add usnig stack now rsp - sp
add_func:
    push rbp
    mov rbp, rsp

    ; get parametres from stack 
    mov rax, [rbp+16]     ; first num - 2nd pushed val 
    mov rdx, [rbp+24]     ; second num - first push val

    add rax, rdx          ; add vals, 

    pop rbp           ;pop
    ret

main:
    push rbp
    mov rbp, rsp

    mov rbx, 0        ; total sum (D3 in 68k)
    mov rcx, 3        ; loop count (D4 in 68k)

GAME_LOOP:

    ; ask for first num
    lea rdi, [rel ask_input]   ;load address of input into rdi - where is prompt ?
    mov rax, 0
    call printf       ; call print or output

    lea rdi, [rel input_format]
    lea rsi, [rel x]
    mov rax, 0
    call scanf

    cmp rax, 1
    jne input_invalid     ; if input fails

    ; ask for second number
    lea rdi, [rel ask_input]
    mov rax, 0
    call printf

    lea rdi, [rel input_format] ;
    lea rsi, [rel y]
    mov rax, 0
    call scanf

    cmp rax, 1 ;compare to 1 
    jne input_invalid ; if not equal go to invalid input 

    ; use stack for parameters now  
    mov rax, [x]
    push rax          ; push first number

    mov rax, [y]
    push rax          ; push second number

    call add_func

    add rsp, 16       ; ad 16 to sp , pops both pushed vals 

    add rbx, rax      ; add to res total

    ; print result 
    mov rsi, rax
    lea rdi, [rel temp_res_msg]
    mov rax, 0
    call printf

    ; loop logic
    dec rcx   
    cmp rcx, 0
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
    mov rax, 0
    call printf

done:
    mov rsp, rbp
    pop rbp
    ret
