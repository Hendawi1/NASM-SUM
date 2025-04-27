global _start

section .data

msg: db "sum of x and y is: "
len equ $-msg

pervnum: db "Pervi nomer: "
pervnumlen equ $-pervnum

ftrnum: db "Btroi nomer: "
ftrnumlen equ $-ftrnum

x: db '0'
y: db '0'



section .text
_start:
;_____(X INPUT)_____;
	mov eax, 0x4
	mov ebx, 0x1
	mov ecx, pervnum
	mov edx, pervnumlen
	int 0x80
	
	mov eax, 0x3
	mov ebx, 0x0						; we are reading from console
	mov ecx, x
	mov edx, 2
	int 0x80 

;_____(Y INPUT)_____;
	mov eax, 0x4
	mov ebx, 0x1
	mov ecx, ftrnum
	mov edx, ftrnumlen
	int 0x80

	mov eax, 0x3
	mov ebx, 0x0						; we are reading from console
	mov ecx, y
	mov edx, 1
	int 0x80 

;__(CONVERT VSLUES)__;
	mov eax, [x]
	sub eax, '0'						;From character "0"-"9" to number 0-9 (CONVERT)
	mov ebx, [y]
	sub ebx, '0'						;From character "0"-"9" to number 0-9 (CONVERT)
	
;___(ADD VALUES)___;
	add eax, ebx
	add eax, '0'						;From number 0-9 to character "0"-"9" (re-CONVERT)
	mov [sum], eax

;____(PRINT MSG)____;
	mov eax, 0x4
	mov ebx, 0x1
	mov ecx, msg
	mov edx, len
	int 0x80
	
;____(PRENT RES)____;
	mov eax, 0x4
	mov ebx, 0x1
	mov ecx, sum
	mov edx, 1
	int 0x80

;_______(END)_______;
	mov eax, 0x1
	int 0x80

segment .bss
sum resb 1		;(Declaring Uninitialised Data) [resb = reserve bytes], resb1 = reserve 1 byte ((зарезервировать 1 байт))