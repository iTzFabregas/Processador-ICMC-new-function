jmp main

;---- Inicio do Programa Principal -----

main:
	loadn r0, #420
	loadn r1, #120
	pow r0, r0, r1
	call ColocarPersonagem

	halt
	
;---- Fim do Programa Principal -----
	
;---- Inicio das Subrotinas -----
	
ColocarPersonagem:
	loadn r1, #'$'
	outchar r1, r0

	call MovimentarInicio

MovimentarInicio:
	push r0

	MovimentarLoop:

		inchar r0

		loadn r1, #'w'
		cmp r0, r1
		jeq MovimentarW

		loadn r1, #'a'
		cmp r0, r1
		jeq MovimentarA


		loadn r1, #'s'
		cmp r0, r1
		jeq MovimentarS


		loadn r1, #'d'
		cmp r0, r1
		jeq MovimentarD

		jmp MovimentarLoop


MovimentarW:
	pop r0

	loadn r1, #' '

	outchar r1, r0
	loadn r1, #40

	sub r0, r0, r1
	loadn r1, #'$'
	outchar r1, r0
	
	jmp MovimentarInicio

MovimentarA:
	pop r0

	loadn r1, #' '
	outchar r1, r0

	dec r0
	loadn r1, #'$'
	outchar r1, r0
	
	jmp MovimentarInicio

MovimentarS:
	pop r0

	loadn r1, #' '

	outchar r1, r0
	loadn r1, #40

	add r0, r0, r1
	loadn r1, #'$'
	outchar r1, r0
	
	jmp MovimentarInicio

MovimentarD:
	pop r0

	loadn r1, #' '
	outchar r1, r0

	inc r0
	loadn r1, #'$'
	outchar r1, r0
	
	jmp MovimentarInicio
	