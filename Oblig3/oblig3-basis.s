	.extern	fread, fwrite

	.text
	.globl	readbyte
 # Navn:	readbyte
 # Synopsis:	Leser en byte fra en binærfil.
 # C-signatur: 	int readbyte (FILE *f)
 # Registre:

readbyte:
	pushl	%ebp		# Standard funksjonsstart
	movl	%esp,%ebp	#

rb_x:	popl	%ebp		# Standard
	ret			# retur.

	.globl	readutf8char
 # Navn:	readutf8char
 # Synopsis:	Leser et Unicode-tegn fra en binærfil.
 # C-signatur: 	long readutf8char (FILE *f)
 # Registre:

readutf8char:
	pushl	%ebp		# Standard funksjonsstart
	movl	%esp,%ebp	#

	popl	%ebp		# Standard
	ret			# retur.

	.globl	writebyte
	.globl _writebyte
 # Navn:	writebyte
 # Synopsis:	Skriver en byte til en binærfil.
 # C-signatur: 	void writebyte (FILE *f, unsigned char b)
 # Registre:

writebyte:
_writebyte:
	pushl	%ebp		# Standard funksjonsstart
	movl	%esp,%ebp	#

	pushl 8(%ebp) # Legger adressen til filen på stakken

	pushl $1 # Legger tallet 1 på stakken
	pushl	$1 # Legger tallet 1 på stakken
	# Så langt oppfylt fwrite(.., 1, 1 ,f)

	leal 12(%ebp),%eax # Henter pekeren til første parameter og flytter til eax
	pushl %eax # Legger pekeren på stakken

	call	fwrite # fwrite(&b,1,1,f);

	addl $16, %esp # Flytter pekeren 4 steg opp (fjerner parametere fra stakken)
	popl	%ebp		# Standard
	ret			# retur.

	.globl	writeutf8char
 # Navn:	writeutf8char
 # Synopsis:	Skriver et tegn kodet som UTF-8 til en binærfil.
 # C-signatur: 	void writeutf8char (FILE *f, unsigned long u)
 # Registre:

writeutf8char:
	pushl	%ebp		# Standard funksjonsstart
	movl	%esp,%ebp	#

	pushl 8(%esp) # Legger fila på første param
	
	leal 12(%ebp)%eax # Legger adressen til unicoden på eax
	andl %eax, 0x0f


	call writebyte

wu8_x:	popl	%ebp		# Standard
	ret			# retur.
