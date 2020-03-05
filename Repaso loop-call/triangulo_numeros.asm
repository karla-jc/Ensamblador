section .data

    num1 db "Ingrese un numero: "
    len1 equ $-num1

    asterisco db "*"

    nueva_linea db 10, " "
section .bss
    num resb 1
    pres_num resb 1
    
section .text
    global _start
    

section .text
    global _start
    
_start:
    
    mov eax, 4 
    mov ebx, 1
    mov ecx, num1
    mov edx, len1
    int 80H
        
    mov eax, 3
    mov ebx, 2
    mov ecx, pres_num
    mov edx, 10
    int 80H


    mov al,[pres_num]
    sub al,'0'
    
    push eax

    pop ecx

    mov ebx, 1

l1:
    push ecx
    push ebx

    call imprimir_enter

    pop ecx
    mov ebx, ecx
    push ebx


l2:
    push ecx 


    call imprimir_numero;

    pop ecx 
    loop l2    
    pop ebx
    pop ecx
    inc ebx
    loop l1  
    int 80H

    
imprimir_numero:
    mov eax, ecx
    add eax,'0'
    mov [num],eax

    mov eax, 4
    mov ebx, 1
    mov ecx, num
    mov edx, 1
    int 80H
    ret 


imprimir_enter:
    mov eax, 4
    mov ebx, 1
    mov ecx, nueva_linea
    mov edx, 1
    int 80H
    ret 