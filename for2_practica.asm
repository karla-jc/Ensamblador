%macro escribir 2
		mov eax, 4
		mov ebx, 1
		mov ecx, %1
		mov edx, %2
		int 80h
%endmacro
section .data
		msj db "La suma del 3 al 0",10
		len_msj equ $ - msj


section .bss
		num resb 2

section .text
		global _start

_start:

		escribir msj, len_msj

		mov eax, 0
		mov ecx, 3
		jmp loop_for

loop_for:
		add eax, ecx
		loop loop_for

		add eax, '0'

		mov [num], eax

		escribir num, 2
		

		mov eax, 1
		int 80h
