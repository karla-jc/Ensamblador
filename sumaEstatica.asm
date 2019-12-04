section .data
		mensaje db "El resultado es: ", 10
		len equ $-mensaje
		


section .bss
		suma resb 1

section .text
		global _start
_start:

		mov eax, 2
		mov ebx, 4
		add eax, ebx
		add eax,'0'

		;transformar de numero a cadena se suma '0', add registro, '0'
		;transformar de cadena a numero se resta '0', sub registro, '0'


		mov [suma], eax


		mov eax, 4
		mov ebx, 1
		mov ecx, mensaje
		mov edx, len
		int 80h

		mov eax, 4
		mov ebx, 1
		mov ecx, suma
		mov edx, 1
		int 80h


		mov eax, 1
		int 80h