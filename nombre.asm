section	.data
		mensajeN db "Karla "
		tamano equ $-mensajeN
		mensajeN2 db "Yacely "
		tamano2 equ $-mensajeN2
		mensajeA db "Jimenez "
		tamanoA equ $-mensajeA
		mensajeA2 db "Cueva "
		tamanoA2 equ $-mensajeA2

section	.text
	global _start

_start:
	mov eax, 4 ;movimiento en el reg eax el valor 4
	mov ebx, 1
	mov ecx, mensajeN
	mov edx, tamano
	int 80h ;envia 1 señar al s.o para ejecutar una subrutina

	mov eax, 4
	mov ebx, 1
	mov ecx, mensajeN2 ;lo que se va a imprimir
	mov edx, tamano2 ;numero de caracteres
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, mensajeA
	mov edx, tamanoA
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, mensajeA2
	mov edx, tamanoA2
	int 80h

	mov eax, 1
	int 80h