%macro escribir 2
		mov eax, 4
		mov ebx, 1
		mov ecx, %1
		mov edx, %2
		int 80h

%endmacro
%macro leer 2
		mov eax, 3
		mov ebx, 2
		mov ecx, %1
		mov edx, %2
		int 80h

%endmacro

section .data

		num1 db "Ingrese el primer numero: ", 10
		tamano1 equ $-num1

		num2 db "Ingrese el segundo numero: ", 10
		tamano2 equ $-num2

		msj_negativo db "Es negativo", 10
		len_negativo equ $ - msj_negativo

		msj_positivo db "Es positivo", 10
		len_positivo equ $ - msj_positivo
		


section .bss
		n1 resb 2
		n2 resb 2

section .text
		global _start
_start:
;************ Ingreso numero 1*******************
		escribir num1, tamano1

		leer n1, 2
;************ Ingreso numero 2******************

		escribir num2, tamano2

		leer n2, 2
		

;************ Proceso de resta******************	
		
		mov ax, [n1]
		mov bx, [n2]
		sub ax,'0'
		sub bx,'0'
		sub ax, bx
		js negativo
		jmp positivo


positivo:
		escribir msj_positivo, len_positivo
		jmp salir

negativo:
		escribir msj_negativo, len_negativo
		jmp salir


salir:
		mov eax, 1
		int 80h