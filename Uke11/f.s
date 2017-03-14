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
    pushl  %ebp
    movl   %esp,%ebp

    movw  8(%ebp),%ax
    movl  $1, %eax

loop2:
    cmpw  $0,%ax
    je    done
    mull  %eax
    decw  %ax

done:
    popl  %ebp
    ret
