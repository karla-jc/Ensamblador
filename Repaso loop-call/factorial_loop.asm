section .data

		msj1 db "Ingrese un numero: "
		len1 equ $-msj1
		msj2 db "El factorial del numero es: "
		len2 equ $-msj2
		nuevaLinea db " ",10
		len3 equ $-nuevaLinea

section .bss

		numero resb 1
		temp resb 1
		num resb 1
		n resb 1
		nod resb 1



section .text
  global _start

_start:
		  
		
		  mov eax, 4
		  mov ebx, 1
		  mov ecx, msj1
		  mov edx, len1
		  int 80h
		  
		 
		  mov eax, 3
		  mov ebx, 0
		  mov ecx, numero
		  mov edx, 1
		  int 80h
		  
		 
		  mov al, [numero]
		  sub al, '0'
		  mov ah,0
		  mov [n],ax

		  call factorial

		  mov [num],cx
		  mov byte[nod], 0 

		  
		  mov eax, 4
		  mov ebx, 1
		  mov ecx, msj2
		  mov edx, len2
		  int 80h 

extract_no:

		  	cmp word[num], 0
		  	je imprimir_num
		  	inc byte[nod]
		  	mov dx, 0
		  	mov ax, [num]
		  	mov bx, 10
		  	div bx
		  	push dx
		  	mov [num], ax
		  	jmp extract_no

imprimir_num:
			cmp byte[nod], 0
			je fin_imprimir
			dec byte[nod]
			pop dx
			mov [temp], dx
			add byte[temp], '0'


			mov eax, 4
			mov ebx, 1
			mov ecx, temp
			mov edx, 1
			int 80h
	
			jmp imprimir_num

fin_imprimir:
		    ; for new line
		    mov eax, 4
		    mov ebx, 1
		    mov ecx, nuevaLinea
		    mov edx, len3
		    int 80h 
		 
		    mov eax, 1
		    mov ebx, 0
		    int 80h

factorial:
  
			mov ax, [n]
			cmp ax, 0
			je term
			push word[n]

			dec word[n]
			call factorial

			pop word[n]
			mov dx, [n]

			mov ax, cx
			mul dx
			mov cx, ax
			jmp exit
  
term:
  			mov cx, 1

exit:
  			ret