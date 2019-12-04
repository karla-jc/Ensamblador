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
		;***************suma***********
		mensajeS db "El resultado de la suma es: ", 10
		lenS equ $-mensajeS
		;***************resta***********
		mensajeR db "El resultado de la resta es: ", 10
		lenR equ $-mensajeR
		;***************multiplicacion***********
		mensajeM db "El resultado de la multiplicacion es: ", 10
		lenM equ $-mensajeM
		;***************divisiom**********
		mensajeD db "El resultado de la division es: ", 10
		lenD equ $-mensajeD

		num1 db "Ingrese el primer numero: ", 10
		tamano1 equ $-num1

		num2 db "Ingrese el segundo numero: ", 10
		tamano2 equ $-num2

		new_line db 10,""

section .bss
		n1 resb 1
		n2 resb 1
		suma resb 1
		resta resb 1
		multiplicacion resb 1
		division resb 1

section .text
		global _start
_start:
;************ Ingreso numero 1*******************
		escribir num1, tamano1
		leer n1, 2

;************ Ingreso numero 2******************
		escribir num2, tamano2
		leer n2, 2
;************ Proceso de suma*****************			
		mov ax, [n1]
		mov bx, [n2]
		sub ax,'0'
		sub bx,'0'
		add ax, bx
		add ax, '0'
		mov [suma], ax
		int 80h

;************ Imprime suma****************	
		escribir mensajeS, lenS
		escribir suma, 1
		escribir new_line, 1

;************ Proceso de resta*****************			
		mov ax, [n1]
		mov bx, [n2]
		sub ax,'0'
		sub bx,'0'
		sub ax, bx
		add ax, '0'
		mov [resta], ax
		int 80h

;************ Imprime resta****************	
		escribir mensajeR, lenR
		escribir resta, 1
		escribir new_line, 1

;************ Proceso de multiplicacion*****************			
		mov ax, [n1]
		mov bx, [n2]
		sub ax,'0'
		sub bx,'0'
		mul bx
		add ax, '0'
		mov [multiplicacion], ax
		int 80h

;************ Imprime multiplicacion****************	
		escribir mensajeM, lenM
		escribir multiplicacion, 1
		escribir new_line, 1

;************ Proceso de division*****************			
		mov al, [n1]
		mov bl, [n2]
		sub al,'0'
		sub bl,'0'
		div bl
		add al, '0'
		mov [division], al
		int 80h

;************ Imprime division****************	
		escribir mensajeD, lenD
		escribir division, 1
		escribir new_line, 1



		mov eax, 1
		int 80h

;Karla Jimenez 6to A