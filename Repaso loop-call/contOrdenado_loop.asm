
section .bss
			num resb 1

section .text

			global _start
_start:
	mov ecx, 9
	mov eax,'1'
	
	l1:
		mov [num],eax
		mov eax,4
		mov ebx,1
		push ecx
		mov ecx,num
		mov edx,1
		int 80h

		mov eax,[num]
		sub eax,'0'
		inc eax
		add eax,'0'
		pop ecx
		loop l1


	mov eax,1
	int 80h

