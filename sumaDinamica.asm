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
		mensaje db "El resultado es: ", 10
		len equ $-mensaje

		num1 db "Ingrese el primer numero: ", 10
		tamano1 equ $-num1

		num2 db "Ingrese el segundo numero: ", 10
		tamano2 equ $-num2
		


section .bss
		n1 resb 1
		n2 resb 1
		suma resb 1

section .text
		global _start
_start:
;************ Ingreso numero 1*******************
		escribir num1, tamano1

		leer n1, 2
;************ Ingreso numero 2******************

		escribir num2, tamano2

		leer n2, 2
		


;************ Proceso de suma******************	
		
		mov ax, [n1]
		mov bx, [n2]
		sub ax,'0'
		sub bx,'0'
		add ax, bx 
		add ax, '0'
		mov [suma], ax
		int 80h


;************ Imprime suma*****************	
		escribir mensaje, len

		escribir suma, 1

		mov eax, 1
		int 80h