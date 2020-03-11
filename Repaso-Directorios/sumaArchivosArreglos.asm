%macro escribir 2
        mov eax, 4
        mov ebx, 1
        mov ecx, %1
        mov edx, %2
        int 80h
%endmacro
section .data
;***********Arreglos
        msj db "Ingrese el primer arreglo de 4 numeros: ", 10
        len_msj equ $ - msj
        msj2 db "Ingrese el segundo arreglo de 4 numeros: ", 10
        len_msj2 equ $ - msj2

;****************Resultado
        msjR db "Resultado guardado ", 10
        lenR equ $ - msjR

;*******************Paths
        archivo1 db "/home/karla/PracticaExamen/Ensayo2/arreglo1.txt", 0
        archivo2 db "/home/karla/PracticaExamen/Ensayo2/arreglo2.txt", 0
        pathwrite db "/home/karla/PracticaExamen/Ensayo2/resultado.txt", 0
; ****************** Error
        msj_Error db  "Error en el archivo", 10
        len equ $ - msj_Error
;**************** Suma
        suma db "     "
        lensum equ $ - suma
        mensaje2 db "La suma es: "
        len_mensaje2 equ $ -mensaje2
        salto db "",10
        len_salto equ $ -salto

section .bss
        texto1 resb 35
        texto2 resb 35
        idarchivo1 resb 1
        idarchivo2 resb 1
        idarchivowrite resb 1

section .text
        global _start
_start:
;*************** Archivo arreglo 1
        escribir msj, len_msj
        mov eax, 3
        mov ebx, 2
        mov ecx, texto1
        mov edx, 35
        int 80h

        mov eax, 8 ;subrutina
        mov ebx, archivo1
        mov ecx, 1 ;acceso de ruta
        mov edx, 0x1FF; permiso
        int 80h

        test eax, eax
        jz error
        mov dword [idarchivo1], eax

        mov eax, 4
        mov ebx, [idarchivo1]
        mov ecx, texto1
        mov edx, 35
        int 80h

;*************** Archivo arreglo 2
        escribir msj2, len_msj2
        mov eax, 3
        mov ebx, 2
        mov ecx, texto2
        mov edx, 35
        int 80h

        mov eax, 8 ;subrutina
        mov ebx, archivo2
        mov ecx, 1 ;acceso de ruta
        mov edx, 0x1FF; permiso
        int 80h

        test eax, eax
        jz error
        mov dword [idarchivo2], eax

        mov eax, 4
        mov ebx, [idarchivo2]
        mov ecx, texto2
        mov edx, 35
        int 80h

;*************** Archivo Resultado
        mov eax, 8      
        mov ebx, pathwrite  
        mov ecx, 1      
        mov edx, 0x1FF     
        int 80h      

        test eax, eax   
        jz error

        mov dword [idarchivowrite], eax  


;***************************** Suma **********************************
        mov esi, 3
        mov ecx, 4
        clc ;instruccion sin operandos esta desactiva el carry        
    ciclo_suma:

        mov al, [texto1+esi] ; 
        adc al, [texto2+esi]
        aaa 
        pushf 
        
        or al, 30h 
        popf 
        
        mov [suma+esi], al
        dec esi
        loop ciclo_suma

        escribir mensaje2, len_mensaje2
        escribir suma, lensum
        escribir salto, len_salto

writeText:
        mov eax, 4
        mov ebx, [idarchivowrite]      
        mov ecx, suma
        mov edx, 15
        int 80h

        escribir msjR, lenR
        jmp salir

error:
        escribir msj_Error, len
salir:
        mov eax, 1
        int 80h