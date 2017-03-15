    .globl  n_ones
    .globl  _n_ones
n_ones:
_n_ones:
    pushl %ebp
    movl  %esp,%ebp

    movl  $0,%eax
    movl  $0,%edx

loop1:
    bt    %edx,8(%ebp) #sett flagget 1 om biten er 1
    jc    lik1      #flagget c = 1
    jmp   end

lik1:
    incl  %eax
    jmp   end

end:
    incl  %edx
    cmp   $32,%edx  #sjekker om ferdig
    jne    loop1

    popl  %ebp
    ret


    .globl  fak
    .globl  _fak
fak:
_fak:
    pushl  %ebp         #Standard
    movl   %esp,%ebp    #Start funksjon

    movw  8(%ebp),%ax   #Setter ax lik para
    movl  $1, %eax      #sum = 1

loop2:
    cmpw  $0,%ax        #if ax == 0
    je    done          #hopp til done
    mull  %eax          #gang eax med ax
    decw  %ax           #ax--
    jmp   loop2         #hopp til start

done:
    popl  %ebp          #funksjonavslutt
    ret                 #retur eax



    .globl tester
    .globl _tester
tester:
_tester:
    movw  4(%esp),%ax
    movl  $0,%eax
hey:
    cmpw  $0x0000,%ax
    je    fin
    incl  %eax
    jmp   hey
fin:
    ret
