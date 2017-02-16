
    .globl _f
    .globl f
_f:
f:
    movl 4(%esp),%eax
    addl 8(%esp),%eax
    addl 8(%esp),%eax
    addl 8(%esp),%eax
    addl 12(%esp),%eax
    ret
