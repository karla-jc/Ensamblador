%macro escribir 2
		mov eax, 4
		mov ebx, 1
		mov ecx, %1
		mov edx, %2
		int 80h
%endmacro

section .data

		msj db 10, "Item: "
		len equ $ - msj
		

section .bss
		cont resb 1


section .text
		global _start
_start:
		mov cx, 9


ciclo: 
		
		cmp cx, 0
		jz salir

		dec cx
		jnz imprimir_mensaje
		


imprimir_mensaje:

		mov eax, 4
		mov ebx, 1
		push cx
		add cx, '0'
		mov [cont], cx
		mov ecx,  msj
		mov edx, len
		int 80h

		mov eax, 4
		mov ebx, 1
		mov ecx, cont
		mov edx, 1
		int 80h

		pop cx
		jmp ciclo



salir:
		mov eax, 1
		int 80h

;			CF		ZF
;cmp (5,4)	0		0
;cmp (4,5)	1		0
;cmp (5,5)	0		1