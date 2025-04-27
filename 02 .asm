global _start

section .data
    inone: db "a: "
    inonelen equ $ - inone

    intwo: db "b: "
    intwolen equ $ - intwo

    res: db "a+b: "
    reslen equ $ - res

    errormsg: db "input value isn't number"
    errormsglen equ $ - errormsg

    reserrormsg: db "res greater than 9"
    reserrormsglen equ $-reserrormsg

    a: db '0'
    b: db '0'


segment .bss
    sum resb 1

section .text
    _start:
        mov eax, 0x4
        mov ebx, 0x1
        mov ecx, inone
        mov edx, inonelen
        int 0x80

        mov eax, 0x3
        mov ebx, 0x0
        mov ecx, a
        mov edx, 2
        int 0x80

        mov eax, 0x4
        mov ebx, 0x1
        mov ecx, intwo
        mov edx, intwolen
        int 0x80

        mov eax, 0x3
        mov ebx, 0x0
        mov ecx, b
        mov edx, 2
        int 0x80
        
        cmp [a], byte 48
        JL error
        cmp [a], byte 57
        JG error

        cmp [b], byte 48
        JL error
        cmp [b], byte 57
        JG error

        mov eax, [a]
        sub eax, '0'
        mov ebx, [b]
        sub eax, '0'

        add eax, ebx
        add eax, '0'
        mov [sum], eax
        
        cmp [sum], byte 57
        JG reerror
        
        mov eax, 0x4
        mov ebx, 0x1
        mov ecx, res
        mov edx, reslen
        int 0x80

        mov eax, 0x4
        mov ebx, 0x1
        mov ecx, sum
        mov edx, 1
        int 0x80
        jmp exit

        error:
            mov eax, 0x4
            mov ebx, 0x1
            mov ecx, errormsg
            mov edx, errormsglen
            int 0x80
            jmp exit

        reerror:
            mov eax, 0x4
            mov ebx, 0x1
            mov ecx, reserrormsg
            mov edx, reserrormsglen
            int 0x80
            jmp exit

        exit:
            mov eax, 0x1
            int 0x80
