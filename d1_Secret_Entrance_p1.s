.section .data
scanfString: .asciz "%s"
printfString: .asciz "%s\n"
printfNum: .asciz "%d\n"
charArr: .space 8
.section .text
.globl main
main:
    mov $0, %edi
    mov $50, %ecx
    
// edi is the answer, ecx is the current number
readAndSolve:
    push %ecx
    push %edi
    push $printfNum
    call printf
    addl $8, %esp
    pop %ecx

    push %ecx
    push $charArr
    push $scanfString
    call scanf
    addl $8, %esp
    pop %ecx

    cmp $0, %eax
    jz exit
    
    push %ecx
    push $charArr
    call strlen
    addl $4, %esp
    pop %ecx

    mov %eax, %esi

    push %edi
    push %ecx

    mov $0, %edi 
    mov $0, %ebx

    call loopEndOfString
    pop %ecx
    pop %edi

    push %edi
    mov $0, %edi
    cmpb $'L', charArr(, %edi, 1)
    pop %edi
    je minus

    push %ecx
    mov %ebx, %eax
    mov $0, %edx
    mov $100, %ebx
    idiv %ebx
    mov %edx, %ebx
    // ecx = ecx + ebx 
    pop %ecx

    add %ebx, %ecx
    // - 100 if >= 100
    cmp $100, %ecx
    jl checkAnswer
    sub $100, %ecx
    jmp checkAnswer

    jmp readAndSolve

minus:
    push %ecx
    // we do ebx % 100 first
    mov %ebx, %eax
    mov $0, %edx
    mov $100, %ebx
    idiv %ebx
    mov %edx, %ebx
    pop %ecx
    // ecx = ecx - ebx 
    sub %ebx, %ecx

    // + 100 if negative
    cmp $0, %ecx
    jge checkAnswer
    add $100, %ecx
    jmp readAndSolve

checkAnswer:
    cmp $0, %ecx
    jz addToAnswer
    jmp readAndSolve

addToAnswer:
    add $1, %edi
    jmp readAndSolve

loopEndOfString:
    // edi is the index
    inc %edi
    // if edi = length, return
    cmp %edi, %esi
    jz returnFromLoop

    // get char at index edi
    mov $0, %edx
    mov charArr(, %edi, 1), %dl
    // dl = dl - '0'
    sub $'0', %dl

    // ebx = ebx * 10
    push %edx
    mov $10, %ecx
    mov %ebx, %eax
    mul %ecx
    mov %eax, %ebx
    pop %edx

    // eax = eax + edx
    add %edx, %ebx

    jmp loopEndOfString

returnFromLoop:
    ret

exit:
    push $0
    call exit
