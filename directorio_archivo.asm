%macro escribir 2
		mov eax, 4
		mov ebx, 1
		mov ecx, %1
		mov edx, %2
		int 80h
%endmacro

%macro leer 2
		mov eax, 3
		mov ebx, 2
		mov ecx, %1
		mov edx, %2
		int 80h

%endmacro

section .data
		msj db 10, "Carpeta o directorio creado",10
		len_msj equ $ - msj

		msjA db 10, "Archivo creado",10
		len_msjA equ $ - msjA

		path db "Ingresa la direccion en la que desea crear el directorio", 10
		len_path equ $ - path

		arch db "Ingresa la direccion en la que desea crear el archivo", 10
		len_arch equ $ - arch

section .bss
		direccion resb 50
		archivo resb 2


section .text
		global _start
_start:
;************ Ingreso direccion*******************
		escribir path, len_path
		leer direccion, 50

		escribir arch, len_arch
		leer archivo, 50
		
		jmp crearD


crearD:
		mov eax, 39 ;servicio para crear un directorio
		mov ebx, direccion  ;define la ruta del servicio
		mov ecx, 0x1FF ;definir permiso 777
		int 80h

		escribir msj, len_msj
		jmp crearA

crearA:
	 	mov eax, 8;servicio para crear un archivo
		mov ebx, archivo ;define la ruta del servicio
		mov ecx, 0x1FF;definir permiso 777
		int 80h

		escribir msjA, len_msjA
		jmp salir
salir:
		mov eax, 1
		int 80h

