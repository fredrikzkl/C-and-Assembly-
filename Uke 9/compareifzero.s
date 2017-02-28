  .globl compareifzero
compareifzero:
  movl %al, %eax #Må flytte al til eax
  jz       Null #Jump Zero, hopper til Null
  jnz      Annet #Jump not Zero, da hopper den til annet
Null: ret
