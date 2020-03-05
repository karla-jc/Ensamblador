section .data
    msj db "Ingrese un Numero: ",10
    len equ $-msj
    msj1 db "Sus numeros son: "
    len1 equ $-msj1

    msj2 db "0"
    len2 equ $-msj2

    msj3 db "1"
    len3 equ $-msj3
section .bss
    n1 resb 2
    ;numero resb 1
section .text
    global _start:
_start:
;Imprimir mensaje 
    mov eax, 4
    mov ebx, 1
    mov ecx, msj
    mov edx,len
    int 80H

;leer numero ingresado
    mov eax, 3
    mov ebx, 2
    mov ecx, n1
    mov edx, 1
    int 80H

    mov eax, 4
    mov ebx, 1
    mov ecx, msj2
    mov edx, 1
    int 80H

    mov eax, 4
    mov ebx, 1
    mov ecx, msj3
    mov edx, 1
    int 80H

    mov ecx,[n1]
    sub ecx,'0'
    sub ecx,2

    mov eax,0
    mov ebx,1
    
;for para ingresar contar numeros 
    

ciclo:    
   
    push ecx
    push ebx
    push eax
    add eax,ebx
    add eax,'0' 
    mov [n1],eax

    call imprimir

    pop eax
    pop ebx
    pop ecx
    mov eax,ebx
    mov ebx,[n1]
    sub ebx,'0'


    loop ciclo
    jmp salir

imprimir:
    mov eax, 4
    mov ebx, 1
    mov ecx, n1
    mov edx, 1
    int 80H
    ret 

   
salir:
    mov eax,1
    int 80h