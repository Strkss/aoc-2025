.section .data
scanfString: .asciz "%s"
printfString: .asciz "%s\n"
printfNum: .asciz "%d\n"
charArr: .space 105
.section .text
.globl main
// eax = accumulator
// edi = max number generated in row
// ebx = max digit until now
// ecx = index of char array
main:
    xor %eax, %eax

readAndSolve:
    xor %edi, %edi

    push %eax   
    push $charArr
    push $scanfString
    call scanf
    addl $8, %esp

    // eof
    cmp $-1, %eax
    pop %eax
    je exit
    
    push %eax
    // get strlen
    push $charArr
    call strlen
    addl $4, %esp

    mov %eax, %ecx
    pop %eax

    push %eax
    dec %ecx
    // ebx will be max until now
    movb charArr(, %ecx, 1), %al
    sub $'0', %al
    mov %al, %bl
    call charArrToArr

    // push %edi
    // push $printfNum
    // call printf
    // addl $8, %esp

    pop %eax
    add %edi, %eax

    jmp readAndSolve

charArrToArr:
    // current digit
    dec %ecx
    
    // push %eax
    // push %ecx
    // push %edi
    // push %ecx
    // push $printfNum
    // call printf
    // addl $8, %esp
    // pop %edi
    // pop %ecx
    // pop %eax

    xor %eax, %eax
    movb charArr(, %ecx, 1), %al
    sub $'0', %al
    // update max num
    push %eax
    call updateMaxNum
    pop %eax
    call updateMaxDigit
    cmp $0, %ecx
    jnz charArrToArr
    ret

updateMaxNum:
    // eax * 10 + ebx
    push %ebx
    mov %eax, %ebx
    shl $3, %eax
    shl $1, %ebx
    add %ebx, %eax
    pop %ebx
    add %ebx, %eax

    // push %eax
    // push %edi
    // push $printfNum
    // call printf
    // addl $8, %esp
    // pop %eax

    cmp %eax, %edi
    jl updateMaxNumElse
    ret

updateMaxNumElse:
    mov %eax, %edi
    ret

updateMaxDigit:
    cmp %eax, %ebx
    jl updateMaxDigitElse
    ret

updateMaxDigitElse:
    mov %eax, %ebx
    ret

exit:
    push %eax
    push $printfNum
    call printf
    addl $8, %esp

    movl $1, %eax
    movl $0, %ebx
    int $0x80