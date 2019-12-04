section	.data
		mensaje db "Hola ensamblador"
		tamano equ $-mensaje

section	.text
	global _start

_start:
	mov eax, 4
	mov ebx, 1
	mov ecx, mensaje
	mov edx, tamano
	int 80h


	mov eax, 1
	int 80h