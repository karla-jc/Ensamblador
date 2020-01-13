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
		mensaje1 db "Numero mayor"
		len1 equ $-mensaje1
		mensaje2 db "Numero menor"
		len2 equ $-mensaje2
		mensaje3 db "Son iguales"
		len3 equ $-mensaje3
		num1 db "Ingrese un numero: ", 10
		lnum1 equ $-num1
		num2 db "Ingrese un numero: ", 10
		lnum2 equ $-num2

section .bss
		n1 resb 1
		n2 resb 1

section .text
		global _start
_start:
;******************Numero 1*************
		escribir num1, lnum1
		leer n1, 2

;****************Numero 2 **************
		escribir num2, lnum2
		leer n2, 2

		mov al, [n1]
		mov bl, [n2]
		cmp al, bl1
		jg mayor ;(ZF = 0) (CF = 0) 
		je igual
		jmp menor
		

mayor: 
		mov eax, 4
		mov ebx, 1
		mov ecx, mensaje1
		mov edx, len1
		int 80h
		jmp salir

menor: 
		mov eax, 4
		mov ebx, 1
		mov ecx, mensaje2
		mov edx, len2
		int 80h
		jmp salir

igual: 
		mov eax, 4
		mov ebx, 1
		mov ecx, mensaje3
		mov edx, len3
		int 80h

salir:
		mov eax, 1
		int 80h

;je --> igualdad
;jz --> result = 0
;jmp --> salto sin restriccion
;jg --> operando 1 > operando2
;js --> signal =>pl ng