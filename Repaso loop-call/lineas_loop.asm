section .data
	lineas db 10, "------------------------------", 10
	leng_lineas equ $ -lineas
	salto db "",10
	leng_salto equ $ -salto

	numero db 10,"Ingrese número"
	leng_numero equ $ -numero

section .bss
	dato_a resb 1
	dato_b resb 10

	resultado resb 10
section .text
	global _start

_start:
	mov ecx, 3

	mov eax, 4
	mov ebx, 1
	mov ecx, numero
	mov edx, leng_numero
	int 80H

	mov eax, 3
	mov ebx, 2
	mov ecx, dato_a
	mov edx, 10
	int 80H
	
	mov al, [dato_a]
	sub al, '0'

	push eax
	pop ecx
	
_cuerpo:

	push ecx
	
	mov eax, 4
	mov ebx, 1
	mov ecx, lineas
	mov edx, leng_lineas
	int 80H

	pop ecx
	loop _cuerpo
salir:
	mov eax, 1
	int 80H