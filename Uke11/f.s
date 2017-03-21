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
    pushl  %ebx         #Standard
    movl   %esp,%ebp    #Start funksjon

    movl  8(%ebp),%eax  #Setter ax lik para
    movl  $1, %ebx      #sum = 1

loop2:
    cmpl  $0,%eax       #if eax == 0
    je    done          #hopp til done
    mull  %ebx          #gang eax med sum
    decl  %eax          #eax--
    jmp   loop2         #hopp til loop2
done:
    popl  %ebx          #funksjonavslutt
    popl  %ebp          #funksjonavslutt
    movl  %ebx,%eax     #retur verdi = sum
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
