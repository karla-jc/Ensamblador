section .data
	    asterisco db '*'
	    nueva_linea db '',10
	    espacio db ' '
section .bss
    	cont_aux resb 1
section .text
    	global _start
_start:

    	mov ecx, 9
l1:
	    push ecx
	    push ecx
	    call imprimir_linea
	    pop ecx
	    mov eax, 10
	    sub eax, ecx

l2:
	    push ecx
	    push eax
	    call imprimir_espacio
	    pop eax
	    dec al
	    pop ecx
	    cmp al, 0
	    je l3
	    jmp l2
    

l3: 
	    push ecx
	    call imprimir_asterisco
	    pop ecx
	    loop l3

	    pop ecx

	    loop l1

	    jmp salir

imprimir_espacio:
	    mov eax, 4
	    mov ebx, 1
	    mov ecx, espacio
	    mov edx, 1
	    int 80h
	    ret 

imprimir_linea:
	    mov eax, 4
	    mov ebx, 1
	    mov ecx, nueva_linea
	    mov edx, 1
	    int 80h
	    ret 

imprimir_asterisco:
	    mov eax, 4
	    mov ebx, 1
	    mov ecx, asterisco
	    mov edx, 1
	    int 80h
	    ret 


salir:
	    call imprimir_linea
	    mov eax, 1
	    int 80h