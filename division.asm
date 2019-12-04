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
		mensaje db "El cociente es: ", 10
		len equ $-mensaje
		mensaje2 db "El residuo es: ", 10
		len2 equ $-mensaje2

		num1 db "Ingrese el primer numero: ", 10
		tamano1 equ $-num1

		num2 db "Ingrese el segundo numero: ", 10
		tamano2 equ $-num2

		new_line db 10,""
		
section .bss
		n1 resb 1
		n2 resb 1
		cociente resb 1
		residuo resb 1

section .text
		global _start
_start:
;************ Ingreso numero 1*******************
		escribir num1, tamano1
		leer n1, 2

;************ Ingreso numero 2******************
		escribir num2, tamano2
		leer n2, 2

;************ Proceso de division*****************			
		mov al, [n1]
		mov bl, [n2]
		sub al,'0'
		sub bl,'0'
		div bl
		add al, '0'
		mov [cociente], al
		add ah, '0'
		mov [residuo], ah
		int 80h

;************ Imprime division****************	
		escribir mensaje, len
		escribir cociente, 1
		escribir new_line, 1

		escribir mensaje2, len2
		escribir residuo, 1
		escribir new_line, 1

		mov eax, 1
		int 80h