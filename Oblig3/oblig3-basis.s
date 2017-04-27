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
/*
	db		'c'

	pushl 8(%ebp) # legger adressen til filen

	pushl $1 # Pusher arguent 3 (som skal være 1)
	pushl $1 # Pusher arguemt 2 (skal også være 1)

	pushl 'c' # Legger itl byten på stakken

	call 	fread 		 # caller på fread funksjonen, return veriden blir lagt i eax
	cmpl	$0, %eax   # sammenligner med 0
	jg		rb_greater # if > 0

	movl	$1, %eax # setter eax til 1
	neg		%eax		 # -1
	jmp rb_x 		   # returnerer -1

rb_greater:
	movl 'c', %eax # returnerer byten
	jmp rb_x
*/
rb_x:
	addl $16, %ebp # flytter opp stakk pekeren
	popl	%ebp		# Standard
	ret			# retur.

	.globl	readutf8char
 # Navn:	readutf8char
 # Synopsis:	Leser et Unicode-tegn fra en binærfil.
 # C-signatur: 	long readutf8char (FILE *f)
 # Registre:

readutf8char:
	pushl	%ebp		# Standard funksjonsstart
	movl	%esp,%ebp	#

	pushl 	8(%ebp) # legger filen som skal leses på stakken (arguemnt 1)
	call 		writebyte
	cmpl 		$0, %eax # sammenligner returverdien med 0
	jl			ru8_end # om mindre enn 0, da er den -1, da returner metoden -1



ru8_end:
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

	movl	$0, %eax
	movl	12(%ebp),%eax # Flytter andre parameter til eax

	cmpl $0x80, %eax 	 	# om mindre enn 0x7F
	jl		wu8_1byte	 	 	# ..hopp til 1 byte

	cmpl  $0x800, %eax  # om mindre enn 7FF
	jl		wu8_2byte		 	# ..hopp til 2 byte

	cmpl  $0x10000, %eax # om mindre enn FFFF
	jl		wu8_3byte		  # ..hopp til 3 byte

	jmp wu8_4byte 			# Må være 4 byte, hopp dit

wu8_1byte:
	andl $0x7f,%eax
	jmp	 wu8_x
wu8_2byte:
	orl  $0xC080,%eax  # or edx med 1100000 10000000, så de som må være 1 blir 1
	andl $0xDFBF,%eax  # and ex med 1101111 10111111, så de som skal være 0 blir 0
	jmp	 wu8_x
wu8_3byte:
	orl $0xE08080,%eax  # or edx med 1110... 10.. 10...
	andl $0xEFBFBF,%eax  # and'er for å sette nullene til null
	jmp	 wu8_x
wu8_4byte:
	orl $0xF0808080,%eax  # samme prosedyre
	andl $0xF7BFBFBF,%eax
	jmp	 wu8_x
wu8_x:

	pushl %eax
	pushl	8(%ebp)
	call writebyte

	addl	$8, %esp # flytter stakk pekeren tilbake
	popl	%ebp		# Standard
	ret						# retur.
