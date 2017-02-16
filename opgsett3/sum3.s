
    .globl _sum3
    .globl sum3
_sum3:
sum3:
    movl 4(%esp),%eax
    addl 8(%esp),%eax
    addl 12(%esp),%eax
    ret
