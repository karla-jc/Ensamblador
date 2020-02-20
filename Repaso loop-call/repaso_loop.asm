%macro escribir 2
		mov eax, 4
		mov ebx, 1
		mov ecx, %1
		mov edx, %2
		int 80h
%endmacro
section .data
		
		new_line db '',10

section .bss
		cont resb 1

section .text
	global _start


_start:
		mov ecx, 9
		
		
testLoop:
	
		push ecx
		add ecx, '0'
		mov [cont], ecx
		escribir cont, 1
		escribir new_line, 1
		pop ecx
		loop testLoop

quit:
		mov eax, 1
		int 80h

