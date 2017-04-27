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

	movl	$0, %edx # resetter edx
	movl	$0, %eax # resetter eax
	movl	12(%ebp),%eax # Flytter andre parameter til edx

	cmpl  $0x80, %eax 	# om mindre enn 0x7F
	jl		wu8_x	 	 	# ..hopp til 1 byte

	cmpl  $0x800, %eax  # om mindre enn 7FF
	jl		wu8_2byte		 	# ..hopp til 2 byte

	cmpl  $0x10000, %eax # om mindre enn FFFF
	jl		wu8_3byte		  # ..hopp til 3 byte

	jmp wu8_4byte 			# Må være 4 byte, hopp dit

wu8_2byte:
	movl %eax, %edx # kopierer til edx
	movl $0xC080, %eax # eax er nå 110x xxxx 10xx xxxx
	andl $0x3f, %edx # henter ut de 6 første bitene abcd efgh ijkl mnop

	orl %edx, %eax # 110x xxxx 10vv vvvv

	movl	12(%ebp),%edx # legger verdiene over på edx igjen
	shrl  $6, %edx # bitshifter så de 6 første verdiene som er lagt inn i pakken går ut
	andl  $0x1f, %edx # 5 verdiene som skal med i neste byte
	sall  $8, %edx # flytter de opp opp igjen til til 9
	orl		%edx, %eax # legger de inn i eax -> 110x xxxx blir til 110v vvvv

	movl %eax, %ebx # ebx inneholder nå 'pakken', flytte til ebx siden den er urørt av fwrite
	# Nå har ebx blitt ferdig pakket. gjennstår å printe ut begge bytene
	# Starter med å skrive de 2nd byten
	movl $0, %eax # resetter eax

	movb %bh, %al # leger først til den første byten til eax
	pushl %eax # pusher eax, som skal printes (første byten)
	pushl	8(%ebp)
	call writebyte
	addl	$8, %esp # flytter stakk pekeren tilbake
	# Første byten skrevet ut, legger den førte byten til eax
	movb %bl, %al
	jmp	 wu8_x # Sender den første byten til writebyte
wu8_3byte:
	# Bruker samme prinsipp som 2 bytes, bruker direkte ebx denne gangen
	movl %eax, %edx # Legger input inn i edx
	movl $0xE08080, %ebx # Setter inn blueprint i ebx -> 1110xxxx 10xxxxxx 10xxxxxx
	# Første byten:
	andl $0x3f, %edx # Masker ut de 6 første bitene
	orl %edx, %ebx # Legger de inn i første byten
	# EBX: 1110xxxx 10xxxxxx 10vvvvvv
	# Andre byten:
	movl	12(%ebp),%edx # Legger input verdiene tilbake på edx igjen
	shrl  $6, %edx # Bitshifter vekk de 6 verdiene som er lagt inn
	andl $0x3f, %edx # Masker ut de 6 neste bitene
	sall  $8, %edx # Flytter de opp opp igjen så de er klare for å legges inn
	orl %edx, %ebx # Legger de inn i andre byten
	# EBX: 1110xxxx 10vvvvvv 10vvvvvv
	# Tredje Byten
	movl	12(%ebp),%edx # Legger input verdiene tilbake på edx igjen
	shrl  $12, %edx # Bitshifter vekk de 12 verdiene som er lagt inn
	andl $0xf, %edx # Masker ut de 4 neste bitene
	sall  $16, %edx # Flytter de opp opp igjen så de er klare for å legges inn
	orl %edx, %ebx # Legger de inn i tredje byten
	# EBX: 1110vvvv 10vvvvvv 10vvvvvv
	# Nå er ebx ferdig, kan kan printe ut. Starter med å skrive den 3rd biten
	# Siden jeg ikke har direkte tak i registeret, må jeg bitshite for å få tak i den første byten
	movl $0, %eax # Resetter eax
	movl %ebx,%edx # Kopier til edx
	shrl  $16, %edx # Fjerner de to første bytene
	movb  %dl, %al # flytter siste byten til eax, klar til å skrives
	# Standard printing:
	pushl %eax # Pusher eax
	pushl	8(%ebp) # Pusher adressen til filen, klar til å kalle metoden
	call writebyte
	addl	$8, %esp # Flytter stakk pekeren tilbake
	# Siste byte printet ut, går løs på nr.2
	movb  %bh, %al # Flytter andre byte av EBX til AL
	# Standard printing:
	pushl %eax # Pusher eax
	pushl	8(%ebp) # Pusher adressen til filen, klar til å kalle metoden
	call writebyte
	addl	$8, %esp # Flytter stakk pekeren tilbake
	# Legger første byten på eax
	movb	%bl, %al # Første byte av EBX til AL
	jmp	 wu8_x
wu8_4byte:
	# Bruker Samme metode som i wu8_3byte
	movl %eax, %edx # Legger input inn i edx
	movl $0xF0808080, %ebx # Setter inn blueprint i ebx -> 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
	# Første byten:
	andl $0x3f, %edx # Masker ut de 6 første bitene
	orl %edx, %ebx # Legger de inn i første byten
	# Andre byten:
	movl	12(%ebp),%edx # Legger input verdiene tilbake på edx igjen
	shrl  $6, %edx # Bitshifter vekk de 6 verdiene som er lagt inn
	andl $0x3f, %edx # Masker ut de 6 neste bitene
	sall  $8, %edx # Flytter de opp opp igjen så de er klare for å legges inn
	orl %edx, %ebx # Legger de inn i andre byten
	# Tredje Byten:
	movl	12(%ebp),%edx # Legger input verdiene tilbake på edx igjen
	shrl  $12, %edx # Bitshifter vekk de 12 verdiene som er lagt inn
	andl $0x3f, %edx # Masker ut de 6 neste bitene
	sall  $16, %edx # Flytter de opp opp igjen så de er klare for å legges inn
	orl %edx, %ebx # Legger de inn i andre byten
	# Fjerde Byten:
	movl	12(%ebp),%edx # Legger input verdiene tilbake på edx igjen
	shrl  $18, %edx # Bitshifter vekk de 6 verdiene som er lagt inn
	andl $0x7, %edx # Masker ut de siste 3 neste bitene
	sall  $24, %edx # Flytter de opp opp igjen så de er klare for å legges inn
	orl %edx, %ebx # Legger de inn i andre byten
	# Ferdig med å legge inn i ebx
	# Starter med å skrive den 4rd biten
	movl $0, %eax # Resetter eax
	movl %ebx,%edx # Kopier til edx
	shrl  $24, %edx # Fjerner de tre første bytene
	movb  %dl, %al # flytter siste byten til eax, klar til å skrives
	# Standard printing:
	pushl %eax # Pusher eax
	pushl	8(%ebp) # Pusher adressen til filen, klar til å kalle metoden
	call writebyte
	addl	$8, %esp # Flytter stakk pekeren tilbake
	# 3. Byten:
	movl $0, %eax # Resetter eax
	movl %ebx,%edx # Kopier til edx
	shrl  $16, %edx # Fjerner de to første bytene
	movb  %dl, %al # flytter siste byten til eax, klar til å skrives
	# Standard printing:
	pushl %eax # Pusher eax
	pushl	8(%ebp) # Pusher adressen til filen, klar til å kalle metoden
	call writebyte
	addl	$8, %esp # Flytter stakk pekeren tilbake
	# 2. byten
	movb  %bh, %al # Flytter andre byte av EBX til AL
	# Standard printing:
	pushl %eax # Pusher eax
	pushl	8(%ebp) # Pusher adressen til filen, klar til å kalle metoden
	call writebyte
	addl	$8, %esp # Flytter stakk pekeren tilbake
	# Legger første byten på eax
	movb	%bl, %al # Første byte av EBX til AL

	jmp	 wu8_x
wu8_x:

	pushl %eax
	pushl	8(%ebp)
	call writebyte

	addl	$8, %esp # flytter stakk pekeren tilbake
	popl	%ebp		# Standard
	ret						# retur.
