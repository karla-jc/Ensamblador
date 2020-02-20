
section .data
	msj1 db 'Ingrese un numero: ', 10
	len equ $ - msj1

	espar db 'El numero es par', 10
	lenP equ $ - espar

	esimpar db 'El numero es impar(el programa termino porque ingreso un impar)', 10
	lenI equ $ - esimpar


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
		je par
		jmp impar
		loop ciclo

par:
		mov eax, 4 	 
		mov ebx, 1	 
		mov ecx, espar  
		mov edx, lenP	
		int 80h
		jmp principal



impar:
		mov eax, 4 	 
		mov ebx, 1	 
		mov ecx, esimpar 
		mov edx, lenI	
		int 80h
		jmp salir


salir:
		mov eax, 1
		int 80h