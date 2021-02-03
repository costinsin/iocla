extern fgets
extern printf
extern stdin
extern strlen
extern malloc

section .data
    fmt_string: db "%s", 0xd, 0xa, 0
    fmt_decimal: db "%d", 0xd, 0xa, 0

section .rodata
    len dd 128

section .bss
    arr resd 1

section .text
global main
global arr

do_something:
    push ebp
    mov ebp, esp

    mov eax, dword [ebp + 8]
    mov ebx, dword [ebp + 12]
    mov ecx, dword [ebp + 16]
    xor edx, edx
    xor ecx, ecx
repeat:
    mov dl, byte [ebx + ecx]
    cmp dl, 90
    jb upper
    sub dl, 32
    jmp continue
upper:
    add dl, 32
continue:
    mov byte[eax + ecx], dl
    inc ecx
    cmp ecx, dword [ebp + 16]
    jne repeat

    leave
    ret

main:
    enter 28, 0
    mov dword[ebp-4], 0x1234abcd
    push dword [stdin]
    push len
    lea eax, [ebp - 28]
    push eax
    call fgets
    add esp, 12

    push len
    call malloc
    add esp, 4
    mov dword[arr], eax

    lea eax, [ebp - 28]
    push eax
    call strlen
    add esp, 4
    dec eax
    mov byte [ebp + eax - 28], 0

    push eax
    lea eax, [ebp - 28]
    push eax
    push dword[arr]
    call do_something
    pop eax
    pop eax
    add esp,4

    push dword[arr]
    push fmt_string
    call printf
    add esp, 8
    xor eax, eax
    leave
    ret
