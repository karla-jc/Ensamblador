%macro escribir 2
        mov eax, 4
        mov ebx, 1
        mov ecx, %1
        mov edx, %2
        int 80h
%endmacro
section .data
;***********Arreglos
        msj db 10, "Ingrese el primer arreglo de 4 numeros: ", 10
        len_msj equ $ - msj
        msj2 db "Ingrese el segundo arreglo de 4 numeros: ", 10
        len_msj2 equ $ - msj2

;****************Resultado
        msjR db "Resultado guardado ", 10
        lenR equ $ - msjR

;*******************Paths
        directorio db "/home/karla/PracticaExamen/Ensayo2/CarpetaSR", 0
        archivo1 db "/home/karla/PracticaExamen/Ensayo2/CarpetaSR/arreglo1.txt", 0
        archivo2 db "/home/karla/PracticaExamen/Ensayo2/CarpetaSR/arreglo2.txt", 0
        pathwrite db "/home/karla/PracticaExamen/Ensayo2/CarpetaSR/resultadoSuma.txt", 0
        pathwrite2 db "/home/karla/PracticaExamen/Ensayo2/CarpetaSR/resultadoResta.txt", 0
; ****************** Error
        msj_Error db  "Error en el archivo", 10
        len equ $ - msj_Error
;**************** Operaciones
        suma db "     "
        lensum equ $ -suma
        resta db "     "
        lenres equ $ -resta
        mensaje2 db "La suma es: "
        len_mensaje2 equ $ -mensaje2
        mensaje3 db "El resultado de la resta es: "
        len_mensaje3 equ $ -mensaje3
        salto db "",10
        len_salto equ $ -salto
        msj3 db  10, "Carpeta creada con exito", 10
        len3 equ $ - msj3


section .bss
        texto1 resb 35
        texto2 resb 35
        idarchivo1 resb 1
        idarchivo2 resb 1
        idarchivowrite resb 1
        idarchivowrite2 resb 1

section .text
        global _start
_start:
;**************** Crear directorio
        mov eax, 39
        mov ebx, directorio
        mov ecx, 0x1FF
        int 80h

        escribir msj3, len3
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

        mov al, [texto1+esi] 
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
        mov edx, lensum
        int 80h

        escribir msjR, lenR
        escribir salto, len_salto

;***************************** Resta**********************************
        mov esi, 3
        mov ecx, 4
        clc ;instruccion sin operandos esta desactiva el carry        
ciclo_resta:

        mov al, [texto1+esi] 
        sbb al, [texto2+esi]
        aas 
        pushf 
        
        or al, 30h 
        popf 
        
        mov [resta+esi], al
        dec esi
        loop ciclo_resta

        escribir mensaje3, len_mensaje3
        escribir resta, lenres
        escribir salto, len_salto
       
        mov eax, 8      
        mov ebx, pathwrite2  
        mov ecx, 1      
        mov edx, 0x1FF     
        int 80h      

        test eax, eax   
        jz error

        mov dword [idarchivowrite2], eax  
writeTextR:
        mov eax, 4
        mov ebx, [idarchivowrite2]      
        mov ecx, resta
        mov edx, lenres
        int 80h

        escribir msjR, lenR
        escribir salto, len_salto



     

        jmp salir

error:
        escribir msj_Error, len
salir:
        mov eax, 1
        int 80h