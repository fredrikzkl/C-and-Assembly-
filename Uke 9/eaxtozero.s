  .globl _eaxtozero
  .globl eaxtozero
_eaxtozero:
eaxtozero:
  addl $0, %eax #Plusse med null
  movl %0, %eax #Flytte 0 til eax
  xor %eax, %eax #Or eax med eax
  ret
