;Suma de archivos solo leyendo txt
section .data
        mensaje2 db "La suma es: "
        leng_mensaje2 equ $ -mensaje2
        salto db "",10
        leng_salto equ $ -salto
        pathNum1 db "/home/karla/PracticaExamen/RepeticionE/numero1.txt", 0
        pathNum2 db "/home/karla/PracticaExamen/RepeticionE/numero2.txt", 0

        suma db "   "

section .bss
        n1 resb 3
        n2 resb 3
        idarchivo resd 1

section .text
        global _start
%macro escribir 2
        mov eax, 4
        mov ebx, 1
        mov ecx, %1
        mov edx, %2
        int 80H
%endmacro

_start:
        mov eax, 5      
        mov ebx, pathNum1   
        mov ecx, 0      
        mov edx, 0      
        int 80H

        test eax, eax 
            jz salir

        mov dword [idarchivo], eax
        mov eax, 3
        mov ebx, [idarchivo]
        mov ecx, n1
        mov edx, 3
        int 80H

        mov eax, 5      
        mov ebx, pathNum2   
        mov ecx, 0      
        mov edx, 0      
        int 80H

        test eax, eax
            jz salir

        mov dword [idarchivo], eax
        mov eax, 3
        mov ebx, [idarchivo]
        mov ecx, n2
        mov edx, 3
        int 80H

        mov ecx, 3
        mov esi, 2  
        clc         
    ciclo_suma:

        mov al, [n1+esi] ; 
        adc al, [n2+esi]
        aaa 
        pushf 
        
        or al, 30h 
        popf 
        
        mov [suma+esi], al
        dec esi
        loop ciclo_suma

        escribir mensaje2, leng_mensaje2
        escribir suma, 3
        escribir salto, leng_salto

salir: 
        mov eax, 1
        int 80h