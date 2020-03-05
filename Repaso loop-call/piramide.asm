section .data
    msj_a: db 10, ''
    ln_a equ $ - msj_a

    nlinea db 10, 10, 0
    lnlinea equ $ - nlinea

section .bss
    num resb 1

section .text
    global _start

_start:
    mov ecx, 9
    mov ebx, 1

vertical:
    push ecx
    push ebx
    call enter
    pop ecx
    push ecx

horizontal:
    push ecx
    
    add ecx, '0'
    mov [num], ecx
    call numero
    
    pop ecx
    loop horizontal
    
    pop ebx
    inc ebx
    
    pop ecx
    loop vertical
    
    jmp salir

enter:
    mov eax, 4
	mov ebx, 1
	mov ecx, nlinea
	mov edx, lnlinea
	int 80h
    ret
    
numero:
    mov eax, 4
	mov ebx, 1
	mov ecx, num
	mov edx, 2
	int 80h
    ret

salir:
	mov eax, 4
	mov ebx, 1
	mov ecx, nlinea
	mov edx, lnlinea
	int 80h

	mov eax, 1
	mov ebx, 0
	int 80h
