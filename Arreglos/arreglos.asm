section .data
			msj db "Ingrese 6 numeros", 10
			len equ $ - msj

			msj1 db "El número mayor es ", 10
			len1 equ $ - msj1

			;definir arreglo
			arreglo db 0,0,0,0,0,0
			len_arreglo equ $ - arreglo



section .bss
			numero resb 2

section .text
			global _start
_start:
			
			mov eax, 4
			mov ebx, 1
			mov ecx, msj
			mov edx, len
			int 80h

			;asignacion del arreglo en las posiciones efectivas
			mov esi, arreglo
			mov edi, 0

leer:
			mov eax, 3
			mov ebx, 0
			mov ecx, numero
			mov edx, 2
			int 80h

			; asignacion de un numero en el arreglo
			mov al, [numero]
			sub al , '0'
			mov [esi], al

			;incrementar una posicion en el arreglo
			add esi, 1
			add edi, 1


			;comparar para el salto
			cmp edi, len_arreglo
			jb leer
			mov esi, arreglo
			mov edi, 0

imprimir_num:
			
			mov al, [esi]
			add al, '0'
			mov [numero], al


			
			mov eax, 4
			mov ebx, 1
			mov ecx, numero
			mov edx, 1
			int 80h

			;incrementar una posicion en el arreglo
			add esi, 1
			add edi, 1


			;comparar para el salto
			cmp edi, len_arreglo
			jb imprimir_num
			


salir:
			mov eax, 1
			int 80h
