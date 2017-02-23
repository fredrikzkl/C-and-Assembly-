  .globl _mul
  .globl mul
_mul:
mul:
  movl 4(%esp), %eax
  addl %eax,%eax
  addl %eax,%eax
  addl %eax,%eax
  addl 4(%esp),%eax
  addl 4(%esp),%eax
  ret
