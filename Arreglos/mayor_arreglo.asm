section .data
			msj db "Ingrese 6 numeros", 10
			len equ $ - msj

			msj1 db 10, "El número mayor es ", 10
			len1 equ $ - msj1

			msj2 db 10, "El número menor es ", 10
			len2 equ $ - msj2

			;definir arreglo
			arreglo db 0,0,0,0,0,0
			len_arreglo equ $ - arreglo



section .bss
			numero resb 2
			mayorNum resb 1

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
			mov esi, arreglo
			mov edi, 0
			

			mov bl, 9
			add bl, '0'

comparacion: 
			mov al, [esi]
			add al, '0'
			mov [numero], al
			sub al, '0'
			cmp al, [esi + 1]
			jg imprimir_mayor
			;jng imprimir_menor
			

			add esi, 1
			add edi, 1


			;comparar para el salto
			cmp edi, len_arreglo
			jb comparacion
			mov esi, arreglo
			mov edi, 0
			;jmp incrementar


imprimir_mayor:		
			
			mov eax, 4
			mov ebx, 1
			mov ecx, msj1
			mov edx, len1
			int 80h

			mov eax, 4
			mov ebx, 1
			mov ecx, numero
			mov edx, 1
			int 80h
			;jmp imprimir_menor
			jmp comparacionM



comparacionM: 
			mov al, [esi]
			add al, '0'
			mov [numero], al
			sub al, '0'
			cmp al, bl
			;jg imprimir_mayor
			jng imprimir_menor
			

			add esi, 1
			add edi, 1


			;comparar para el salto
			cmp edi, len_arreglo
			jb comparacionM
			



imprimir_menor:		
			mov eax, 4
			mov ebx, 1
			mov ecx, msj2
			mov edx, len2
			int 80h

			mov eax, 4
			mov ebx, 1
			mov ecx, numero
			mov edx, 1
			int 80h
			jmp salir


salir:
			mov eax, 1
			int 80h