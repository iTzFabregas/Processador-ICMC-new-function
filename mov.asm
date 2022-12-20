jmp main

;Codigo principal
main:

	loadn r0, #20
	loadn r1, #2 ;400
	pow r0, r0, r1
	loadn r1, #'X'
	outchar r1, r0

	loadn r0, #2
	loadn r1, #5 ; 32
	pow r0, r0, r1
	loadn r1, #'X'
	outchar r1, r0

	loadn r0, #10
	loadn r1, #4 ; 10000
	pow r0, r0, r1
	loadn r1, #'X'
	outchar r1, r0

	halt