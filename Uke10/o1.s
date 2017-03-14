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
    shrl $1,%eax  #Bitshifte dele på 2
    ret

    .globl odd
    .globl _odd
odd:
_odd:
    pushl %ebp
    movl  %esp,%ebp #funksjonstart

    movl  8(%ebp),%eax
    andl   $0x0001, %eax

    popl  %ebp
    ret



    .globl bit_not
    .globl _bit_not
bit_not:
_bit_not:
    pushl   %ebp          #Standard
    movl    %esp,%ebp     #Funksjonstart

    movl    8(%ebp),%eax
    xorl     $0xffff,    %eax
#Kunne også brukt notl av %eax

    popl    %ebp          #Standard
    ret                   #Retur


    .globl  c_not
    .globl  _c_not
c_not:
_c_not:
    pushl %ebp
    movl  %esp,%ebp

    cmpl  $0x0, 8(%ebp)
    je    equal

#Ikke like:
    movl  $0x0,%eax
    popl  %ebp
    ret

equal:
    movl  $0x1,%eax
    popl  %ebp
    ret


    .globl  bit_and
    .globl  _bit_and
bit_and:
_bit_and:
    pushl %ebp
    movl  %esp,%ebp

    movl  8(%esp),%eax
    andl  12(%esp),%eax

    popl  %ebp
    ret



    .globl  c_and
    .globl  _c_and
c_and:
_c_and:
    pushl  %ebp
    movl   %esp,%ebp

    cmpl  $0,8(%ebp)
    je    liknull
    cmpl  $0,12(%ebp)
    je    liknull
    movl  $1,%eax
    jmp   retur
liknull:
    movl  $0,%eax
retur:
    popl  %ebp
    ret
