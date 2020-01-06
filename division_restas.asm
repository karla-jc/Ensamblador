; Karla Jimenez
%macro escribir 2 
        mov eax, 4
        mov ebx, 1
        mov ecx, %1
        mov edx, %2
        int 80h
%endmacro

%macro leer 2 
        mov eax, 3
        mov ebx, 0
        mov ecx, %1
        mov edx, %2
        int 80h
%endmacro

%macro presentar 1
        mov eax, 4
        mov ebx, 1
        mov ecx, %1
        mov edx, 1
        int 80h
%endmacro


section .data
        msj db 10, "Ingrese Dividendo:",10
        len1 equ $ - msj
        msj2 db 10, "Ingrese Divisor:",10
        len2 equ $ - msj2

        mensajeC db 10,"El cociente es: "
        lenC equ $ - mensajeC

        mensajeR db 10,"El residuo es: "
        lenR equ $ - mensajeR

section .bss
        n1 resb 1
        n2 resb 2
        cociente resb 1
        residuo resb 1

section .text
        global _start 
_start:

      
;******************* Dividendo****************

        escribir msj, len1 

        leer n1, 2


;**************** Divisor *****************

        escribir msj2, len2

        leer n2, 2 

        mov al, [n1]
	    mov bl, [n2]
	    mov cx,  0
	    sub al, '0'
	    sub bl, '0'

division: 
        sub al, bl
	    inc cx
	    cmp al,bl
	    jg division
        je division
	    jmp imprimir

imprimir: 
	    add al,'0'
	    add cx,'0'
	    mov [cociente], cx
	    mov [residuo], al

        escribir mensajeC, lenC
        presentar cociente

        escribir mensajeR, lenR
        presentar residuo

        jmp salir
salir: 
        mov eax, 1
        int 80h
   		
		