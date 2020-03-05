%macro escribir 2
        mov eax, 4
        mov ebx, 1
        mov ecx, %1
        mov edx, %2
        int 80h
%endmacro
section .data
    msj db "Ingrese un caracter: ",10
    len equ $-msj

    msj1 db "Es vocal"
    len1 equ $-msj1

    msj2 db "Es consonante"
    len2 equ $-msj2

    msj3 db "Caracter especial"
    len3 equ $-msj3

    msj4 db "Es numero"
    len4 equ $-msj4

    line  db '',10
    lenL equ $-line
section .bss
    caracter resb 1
    
    
section .text
    global _start:
_start:
principal:
        escribir msj, len
        jmp lectura

lectura:
        mov eax, 3
        mov ebx, 2
        mov ecx, caracter
        mov edx, 2
        int 80h

        jmp proceso



proceso:
       
        mov al,[caracter]
        sub al, '0'
        mov [caracter], al
        add al, '0'

        cmp al, 58
        jl esNumero
        
        cmp al, 48
        jle esNumero
        

        cmp al, 97
        je esVocal

        cmp al, 101
        je esVocal

        cmp al, 105
        je esVocal

        cmp al, 111
        je esVocal

        cmp al, 117
        je esVocal

        cmp al, 66
        jge esConsonante
        
        cmp al, 32
        jge esCaracterE

        

 

esNumero:
        escribir msj4, len4
        escribir line, 1
        jmp principal


esCaracterE:
        escribir msj3, len3
        escribir line, 1
        jmp principal

esConsonante:
        escribir msj2, len2
        escribir line, 1
        jmp principal
esVocal:
        escribir msj1, len1
        escribir line, 1
        jmp principal

salir:
        mov eax, 1
        int 80h