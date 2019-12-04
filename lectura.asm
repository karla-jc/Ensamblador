section .data
		entrada db "Ingrese su nombre: ", 10
		tamano equ $-entrada
		mensaje1 db "El nombre ingresado es: "
		tamano1 equ $-mensaje1
section .bss

		nombre resb 5

		
section	.text
	global _start

_start:
	mov eax, 4
	mov ebx, 1
	mov ecx, entrada
	mov edx, tamano
	int 80h

	mov eax, 3
	mov ebx, 2
	mov ecx, nombre
	mov edx, 8
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, mensaje1
	mov edx, tamano1
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, nombre
	mov edx, 8
	int 80h
	


	mov eax, 1
	int 80h