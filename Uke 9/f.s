    .globl	f
f:  pushl	%ebp
    movl	%esp,%ebp
    movl	$0,%eax
    movl	8(%ebp),%edx
    movb	%dl,%al
    popl	%ebp
    ret
