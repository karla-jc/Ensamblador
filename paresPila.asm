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

		msj3 db "El residuo es: "
		len3 equ $-msj3
		

section .bss
		cont resb 1
		residuo resb 1


section .text
		global _start
_start:
		mov cx, 8
		


ciclo: 
		
		cmp cx, 0
		jz salir

	
		dec cx
		jmp condicion
		
		
condicion:

		mov al, 2
		div al
		;add al, '0'
		;add ch, '0'
		;mov [residuo], ch
		;escribir msj3, len3
		;escribir residuo, 1
		cmp ch, 0
		je imprimir_mensaje
		jmp ciclo



imprimir_mensaje:

		dec cx
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
