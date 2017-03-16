
	.globl	mod60
  .globl  _mod60
# Navn:		mod60.
# Synopsis:	Beregner v % 60.
# C-signatur:	unsigned long mod60 (unsigned long v)
# Registre:	%eax 	  - funksjonens returverdi
#		%eax:%edx - v
#		%edx	  - resten av divisjonen

mod60:
_mod60:
	pushl	%ebp					# Standard
	movl	%esp,%ebp			# funksjonsstart

	movl	8(%ebp),%edx	# Hent v
	movl	$0,%eax				# og utvid til 32 bit.
	idivl	v60						# Del på 60
	movl	%edx,%eax			# og hent resten.

	popl	%ebp					# Standard
	ret									# retur.

	.data
v60:	.long 60				# Konstanten 60
