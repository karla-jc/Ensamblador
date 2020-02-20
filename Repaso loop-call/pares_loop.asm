
section .data
	msj1 db 'Ingrese un numero par para continuar o impar para terminar', 10
	len equ $-msj1
	

section .bss
	num resb 5

section .text
	global _start

_start :
	jmp principal
	
principal:
		mov eax, 4 	 
		mov ebx, 1	 
		mov ecx, msj1   
		mov edx, len	
		int 80h
		jmp lectura

lectura:
		mov eax, 3
		mov ebx, 2
		mov ecx, num
		mov edx, 2
		int 80h

ciclo:
		mov al, [num]
		sub al, '0'
		mov bl, 2
		div bl
		add al, '0'
		cmp ah, 0
		jz principal
		jmp salir
		loop ciclo

salir:
		mov eax, 1
		int 80h