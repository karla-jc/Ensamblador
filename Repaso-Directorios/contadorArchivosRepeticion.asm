%macro escribir 2
    mov eax, 4
	mov ebx, 1
	mov ecx, %1
	mov edx, %2
	int 80h
%endmacro

section .data
     
        msj2 db 10, 'Datos guardados en el archivo', 10
        len2 equ $ - msj2

        pedir db 10, 'De los numeros del archivo, ingrese uno:', 10
        lenpedir equ $ - pedir

        msjRes db '  =   veces    '
        lenRes equ $ - msjRes

        path db '/home/karla/PracticaExamen/Ensayo2/arreglo.txt', 0
        pathwrite db '/home/karla/PracticaExamen/Ensayo2/repeticiones.txt', 0

section .bss
    num resb 1
    texto resb 10
    cont resb 10
    idarchivo resb 1
    idarchivowrite resb 1

section .text
    global _start

_start:
    ; ##################################### READ ################################################################
    ;*****   apertura del archivo
    mov eax, 5      ;servicio para abrir el archivo
    mov ebx, path   ;servicio de direccion del archivo
    mov ecx, 0      ; modo de acceso, read only = 0
    mov edx, 0      ; permisos del archivo
    int 80H        ; igual al int 80H

    ; ** verificamos si el path es correcto o si existe
    test eax, eax
    jz salir

    ; **** archivo sin porblemas(excepciones) ****
    mov dword [idarchivo], eax  ; respaldo el id del archivo

  

    mov eax, 3
    mov ebx, [idarchivo]      ; entrada estandar. (0,1,2 ) => entrada por teclado
    mov ecx, texto
    mov edx, 14
    int 80H

    escribir texto, 14
    escribir pedir, lenpedir

    mov eax, 03
    mov ebx, 02
    mov ecx, num
    mov edx, 02
    int 80H

    ; ################################################################################################################
    ;*****   apertura del archivo
    mov eax, 8      ;servicio para crear y escribir en archivo
    mov ebx, pathwrite   ;servicio de direccion del archivo
    mov ecx, 2      ; modo de acceso, write and read = 2
    mov edx, 200h      ; permisos del archivo
    int 80h        ; igaul al int 80H

    ; ** verificamos si el path es correcto o si existe
    test eax, eax   ; test es un and sin modificar sus operandos, solo modifica  banderas
    jz salir

    ; **** archivo sin porblemas(excepciones) ****
    mov dword [idarchivowrite], eax  ; respaldo el id del archivo

    ; ##################################### END WRITE ###########################################################################

    ; inicio contador en 0
    mov ah, 0
    add ah, '0'
    mov [cont], ah

    mov ecx, 10                             ; inicio contador del bucle loop1
    mov esi, 0                              ; inicio el apuntador de la cadena del bucle loop1

loop1:
    push ecx                                 ; guardo el contador del bucle loop1

    mov al, [texto + esi]                      ; obtengo el numero de la cadena
    sub al, '0'                              ; convierto el valor en numero

    inc esi                                 ; incremento el apuntador al siguiente numero de la cadena
    push esi                                ; guardo el apuntador del bucle loop1

    mov esi, 0                              ; inicio el apuntador para el bucle loop2
    mov ecx, 10                             ; inicio el contador del bucle loop2

    call loop2                              ; llamo al bucle loop2

    add al, '0'                             ; convierto el valor al(valor acutal) en cadena
    mov [msjRes + 0], dword al                ; agrego ah en msjRest

    mov ah, [cont]                          ; obtengo contador
    mov [msjRes + 4], dword ah                ; agrego el contador en msjRes

    ;escribir msjRes, lenRes
    cmp [num], al
    jz writeText                          ; llamo a la funcion para escribir el mensaje en el archivo

    mov ah, 0                               ; reinicio el contador en 0
    add ah, '0'
    mov [cont],ah

    pop esi                                 ; rescato el valor esi(apuntador del texto) del bucle loop1
    pop ecx                                 ; rescato el valor ecx(contador del bucle) del bucle loop1
    loop loop1
    jmp cerrarArchivo

loop2:
    mov dl, [texto + esi]
    sub dl, '0'
    inc esi

    cmp al, dl
    jz incCont
    endl2:
    loop loop2
    ret

incCont:
    mov bl, [cont]
    sub bl, '0'
    inc bl
    add bl, '0'
    mov [cont], bl
    jmp endl2

writeText:
    mov eax, 4
    mov ebx, [idarchivowrite]      ; entrada estandar
    mov ecx, msjRes
    mov edx, 15
    int 80h
    escribir msj2, len2
    ret

cerrarArchivo:
    ;*****   cerrar del archivo ***********************
    mov eax, 6              ;servicio para cerrar el archivo
    mov ebx, [idarchivo]    ;servicio de direccion del archivo
    mov ecx, 0              ; no se necesita modo de acceso
    mov edx, 0              ; no se necesita permisos
    int 80h               
    

salir:
   
    mov eax, 1
    ;mov ebx, 0
    int 80h