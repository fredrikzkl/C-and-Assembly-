    .globl _f1
    .globl f1
_f1:
f1:
    movl 4(%esp), %eax #Flytter param til returnregister
    addl $1, %eax #Legger til desimal 1 til eax
    addl %eax, %eax #Ganger med 2
    addl %eax, %eax #Ganger igjen med 2
    ret

    .globl _f2
    .globl f2
_f2:
f2:
    movw 4(%esp), %ax #Flytter til ax(long er for stort)
    movl 4(%esp), %eax #Flytter også til eax
    mull %eax #Ganger med ax (standard)
    mull %eax #ganger igjen
    ret

    .globl _f3
    .globl f3
_f3:
f3:
    cmpw $0,4(%esp)
    jg  isBigger
    movl 12(%esp),%eax
    ret
isBigger:
    movl 8(%esp),%eax
    ret

    .globl f4
    .globl _f4
f4:
_f4:
    movl 4(%esp),%eax
    movw $2, %ax
    mull %eax
    movl 8(%esp),%edx
    mull %edx
    addl %edx, %eax
    divl $2, %eax
    ret
