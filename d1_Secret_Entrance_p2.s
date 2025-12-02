.section .data
scanfString: .asciz "%11s"
printfString: .asciz "%s\n"
printfNum: .asciz "%d\n"
charArr: .space 12
.section .text
.globl main
main:
    mov $0, %edi
    mov $50, %ecx
    
// edi is the answer, ecx is the current number
readAndSolve:
    // push %ecx
    // push %ecx
    // push $printfNum
    // call printf
    // addl $8, %esp
    // pop %ecx

    // subl $4, %esp
    push %ecx
    push $charArr
    push $scanfString
    call scanf
    addl $8, %esp
    pop %ecx
    // addl $4, %esp

    cmp $-1, %eax
    je exit
    
    // subl $8, %esp
    push %ecx
    push $charArr
    call strlen
    addl $4, %esp
    pop %ecx
    // addl $8, %esp

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
    // add quotient to edi
    add %eax, %edi
    pop %ecx
    // if remainder = 0 we skip
    cmp $0, %edx
    jz readAndSolve

    // ecx = ecx + ebx 
    add %ebx, %ecx
    // - 100 if >= 100
    cmp $100, %ecx
    jl checkAnswer

    sub $100, %ecx
    cmp $0, %ecx
    jz checkAnswer
    add $1, %edi

    jmp readAndSolve

minus:
    push %ecx
    // we do ebx % 100 first
    mov %ebx, %eax
    mov $0, %edx
    mov $100, %ebx
    idiv %ebx
    mov %edx, %ebx
    add %eax, %edi
    pop %ecx
    // if remainder = 0 we skip
    cmp $0, %edx
    jz readAndSolve

    // if ecx == 0 we shouldnt add extra number to answer!
    movl $0, %esi
    xor %ecx, %esi

    // ecx = ecx - ebx 
    sub %ebx, %ecx
    // + 100 if negative
    cmp $0, %ecx
    jge checkAnswer

    add $100, %ecx
    cmp $0, %ecx
    jz checkAnswer

    cmp $0, %esi
    jz readAndSolve
    add $1, %edi

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
    push %edi
    push $printfNum
    call printf
    addl $8, %esp

    movl $1, %eax
    movl $0, %ebx
    int $0x80