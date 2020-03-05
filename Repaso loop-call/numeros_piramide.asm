section .data
	lineas db "------------------------------", 10
	leng_lineas equ $ -lineas
	salto db "",10
	leng_salto equ $ -salto
	a db "Ingrese valor de a: "
	leng_a equ $ -a
	numero db 10,"Ingrese número"
	leng_numero equ $ -numero

section .bss
	dato_a resb 10
	resultado resb 10
section .text
	global _start

_start:
	mov eax, 4
	mov ebx, 1
	mov ecx, lineas
	mov edx, leng_lineas
	int 80H
	mov ecx, 5
	push ecx
	push ecx

_cuerpo:
pop eax
push eax
cmp eax, 0
	jz uno_al_cinco
jmp filas

filas:
	pop ecx
	push ecx
	add ecx, '0' 
	mov [resultado], ecx
	
	mov eax, 4
	mov ebx, 1
	mov ecx, resultado
	mov edx, 10
	int 80H
	
	pop ecx
	cmp ecx, 1
		jz restar
		
	dec ecx
	push ecx
	jmp filas

restar:
	mov eax, 4
	mov ebx, 1
	mov ecx, salto
	mov edx, leng_salto
	int 80H
		
	pop ecx
	dec ecx
	push ecx
	push ecx
	jmp _cuerpo

;-------------------------------------------------------------------------------

uno_al_cinco:
	mov eax, 4
	mov ebx, 1
	mov ecx, lineas
	mov edx, leng_lineas
	int 80H

	mov ecx, 5
	mov eax, 1
	push ecx
	push eax
	push eax
presentar:
	pop ecx
	push ecx
	add ecx, '0' 
	mov [resultado], ecx
	
	mov eax, 4
	mov ebx, 1
	mov ecx, resultado
	mov edx, 10
	int 80H
	pop ecx
	cmp ecx, 1
		jz fila
	dec ecx
	push ecx
	jmp presentar

fila:
mov eax, 4
mov ebx, 1
mov ecx, salto
mov edx, leng_salto
int 80H

pop ecx
pop eax

cmp ecx, eax
	jz uno_al_cinco_2

push eax
inc ecx
push ecx
push ecx
jmp presentar

;-------------------------------------------------------------------------

uno_al_cinco_2:
	mov eax, 4
	mov ebx, 1
	mov ecx, lineas
	mov edx, leng_lineas
	int 80H

	mov ecx, 5
	mov eax, 1
	push ecx
	push eax
	push eax
presentar_2:
	pop ecx
	push ecx
	add ecx, '0' 
	mov [resultado], ecx
	
	mov eax, 4
	mov ebx, 1
	mov ecx, resultado
	mov edx, 10
	int 80H
	pop ecx
	pop ebx
	push ebx
	cmp ecx, ebx
		jz fila_2
	inc ecx
	push ecx
	jmp presentar_2

fila_2:
mov eax, 4
mov ebx, 1
mov ecx, salto
mov edx, leng_salto
int 80H

pop ecx
pop eax

cmp ecx, eax
	jz _start2

push eax
inc ecx
push ecx
mov ecx, 1
push ecx
jmp presentar_2



;-------------------------------------------------------------------------------
_start2:
	mov eax, 4
	mov ebx, 1
	mov ecx, lineas
	mov edx, leng_lineas
	int 80H

	mov ecx, 5
	push ecx

_cuerpo2:

pop eax
push eax
cmp eax, 0
	jz terminar

mov ecx, 1
push ecx
jmp filas2

filas2:
	pop ecx
	push ecx
	add ecx, '0' 
	mov [resultado], ecx
	
	mov eax, 4
	mov ebx, 1
	mov ecx, resultado
	mov edx, 10
	int 80H
	
	pop ecx
	pop eax
	push eax

	cmp ecx, eax
		jz restar2
		
	inc ecx
	push ecx
	jmp filas2

restar2:
	mov eax, 4
	mov ebx, 1
	mov ecx, salto
	mov edx, leng_salto
	int 80H
		
	pop ecx
	dec ecx
	push ecx
	;mov ecx, 1
	;push ecx
	jmp _cuerpo2


terminar:
	call imprimir_lineas
	mov eax, 1
	int 80H

imprimir_lineas:
	mov eax, 4
	mov ebx, 1
	mov ecx, lineas
	mov edx, leng_lineas
	int 80H