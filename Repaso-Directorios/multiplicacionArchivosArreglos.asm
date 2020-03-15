%macro escribir 2
    mov eax, 4
    mov ebx, 2
    mov ecx, %1
    mov edx, %2
    int 80H
%endmacro

section .data
;***********Arreglos
        msj db "Ingrese el primer arreglo de 5 numeros: ", 10
        len_msj equ $ - msj
        msj2 db "Ingrese el segundo arreglo de 5 numeros: ", 10
        len_msj2 equ $ - msj2

        msj_multiplicaciones db 10,'Multiplicaciones: ', 10
        len_multi equ $-msj_multiplicaciones

        msj_resultado db '0*0=0, 0*0=0, 0*0=0, 0*0=0, 0*0=0'
        len_resultado equ $-msj_resultado

        salto_linea db " ", 10
        len_salto db $-salto_linea



        path1 db "/home/karla/PracticaExamen/Ensayo2/arregloMD1.txt", 0
        path2 db "/home/karla/PracticaExamen/Ensayo2/arregloMD2.txt", 0
        path3 db "/home/karla/PracticaExamen/Ensayo2/resultadoMD.txt", 0

        cadena db  "     "
    len_cadena equ $-cadena

    mov [msj_resultado + ecx], bl

section .bss
        texto1 resb 30
        texto2 resb 30

        idarchivo1 resd 1
        idarchivo2 resd 1
        idarchivo3 resd 1

        aux1 resb 2
        

        numero1 resb 2
        numero2 resb 2

        indicador resb 12

section .text
        global _start

_start:

        mov al, 0

        mov [indicador], al

;                
;~***************Archivo arreglo 1***************
        escribir msj, len_msj
        mov eax, 3   
        mov ebx, 2  
        mov ecx, texto1  
        mov edx, 35  
        int 80h

        mov eax, 8 ;subrutina
        mov ebx, path1
        mov ecx, 1 ;acceso de ruta
        mov edx, 0x1FF; permiso
        int 80h
        
        ;~ test == and --> el test solo modifica el estado de las banderas y define un 0
        test eax, eax
        jz salir

        ;~ **********archivo sin excepciones************
        mov dword [idarchivo1], eax ; respaldo el id del archivo

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
        mov ebx, path2
        mov ecx, 1 ;acceso de ruta
        mov edx, 0x1FF; permiso
        int 80h

        test eax, eax
        jz salir
        mov dword [idarchivo2], eax

        mov eax, 4
        mov ebx, [idarchivo2]
        mov ecx, texto2
        mov edx, 35
        int 80h

        mov al, 0

ciclo1:
        mov [aux1], al
        cmp al, len_cadena
        jz salir
        
        mov bl, [aux1]
        mov al, [texto1 + ebx]
        mov bl, [texto2 + ebx] 

        mov ecx, [indicador]
        mov [msj_resultado + ecx], al

        add ecx, 2

        mov [msj_resultado + ecx], bl

        sub al, '0'
        sub bl, '0' ;'0*0=0, 0*0=0, 0*0=0, 0*0=0, 0*0=0'

        mul bl

        add al, '0'
        add ecx, 2

        mov [msj_resultado + ecx], al

        add ecx, 3
        mov [indicador], ecx

finCiclo1:

    mov al, [aux1]
    inc al
    jmp ciclo1

salir:
        ;escribir msj_resultado, len_resultado
        call escribirTexto
    mov eax, 1
    mov ebx, 0
    int 80H

escribirTexto:
;                 ESCRITURA EN EL ARCHIVO
        mov eax, 8   
        mov ebx, path3 
        mov ecx, 2  
        mov edx, 200H  
        int 80H
        
        
        test eax, eax  
        jz salir
        
        ;~ **********archivo sin excepciones************
        mov dword [idarchivo3], eax 
        escribir msj_multiplicaciones, len_multi

        escribir msj_resultado, len_resultado
        
        mov eax, 4 
        mov ebx, [idarchivo3]  
        mov ecx, msj_resultado    
        mov edx, len_resultado    
        int 80H 
        
;~****************cierre del archivo****************
        mov eax, 6                
        mov ebx, [idarchivo3]  
        mov ecx, 0                        
        mov edx, 0               
        int 80H
        ret 