  .globl _maskstuff
  .globl maskstuff
_maskstuff:
maskstuff:
  #Sette 2 siste bit i Al(8bit) til 1
  movl 4(#esp), %al Flytter første param til
  or %al, 00000011 #al reg 8 bit, or'er for å sette de to siste til 1

  #Sette 2 siste bit i Al(16bit) til 1
  movl 4(%esp), %ax #flytter param til ax registeret
  or %al, 0x02 #Bruker hex siden 16 bit

  %Eax er 32 bits
  movl 4(%esp), %eax
  or %eax, 0x0002

  #Nulle ut to øverste bit
  and %al, 00111111

  #1100 0000 = C 0
  and %ax, 0xC0

  #1100 0000 0000 0000 = C 0 0 0
  and %eax, 0xC000
