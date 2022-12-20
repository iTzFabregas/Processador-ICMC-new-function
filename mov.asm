jmp main

welcomestr: string 
"########################################

     BEM VINDO AO ASTEROID ATTACK!  

########################################"

startstr: string 
"         [Press ENTER to start]        "



;Msn0: string "V O C E   V E N C E U !!!"
;Msn1: string "Quer jogar novamente? <s/n>"

Letra: var #1		; Contem a letra que foi digitada

posNave: var #1			; Contem a posicao atual da Nave
posAntNave: var #1		; Contem a posicao anterior da Nave

numAleatorio: var #1
posMeteoro: var #1		; Contem a posicao atual do Meteoro
posAntMeteoro: var #1	; Contem a posicao anterior do Meteoro

posTiro: var #1			; Contem a posicao atual do Tiro
posAntTiro: var #1		; Contem a posicao anterior do Tiro
FlagTiro: var #1		; Flag para ver se Atirou ou nao (Barra de Espaco!!)


Rand: var #40    ; Variavel para numero randomico
; Geracao de numeros randomicos para o jogo

static Rand + #0, #58		
static Rand + #1, #987		
static Rand + #2, #456		
static Rand + #3, #1951		
static Rand + #4, #984		
static Rand + #5, #1984		
static Rand + #6, #13		
static Rand + #7, #147		
static Rand + #8, #258		
static Rand + #9, #326		
static Rand + #10, #178		
static Rand + #11, #157		
static Rand + #12, #15   	
static Rand + #13, #997		
static Rand + #14, #789		
static Rand + #15, #194	    
static Rand + #16, #159		
static Rand + #17, #8114	
static Rand + #18, #7032    
static Rand + #19, #3258	
static Rand + #20, #469	
static Rand + #21, #6448	
static Rand + #22, #118	
static Rand + #23, #357		
static Rand + #24, #7904	
static Rand + #25, #4880		
static Rand + #26, #4698	
static Rand + #27, #97661	
static Rand + #28, #2305		
static Rand + #29, #1990
static Rand + #30, #1955	
static Rand + #31, #1959	
static Rand + #32, #1988	
static Rand + #33, #200	
static Rand + #34, #357	
static Rand + #35, #483	
static Rand + #36, #1988	
static Rand + #37, #639	
static Rand + #38, #69	
static Rand + #39, #74589


;Codigo principal
main:

	call ApagaTela

	;; PRINTA TELA INICIAL
	; printa welcomestr
	loadn r0, #0 ; posicao inicial da string
	loadn r1, #welcomestr ; armazena string
	loadn r2, #0 ; cor da string (branca)
	call print

	; printa startstr
    	loadn r5, #440
	add r0, r0, r5
	loadn r1, #startstr
	loadn r2, #0
	call print

	call waitForBegin

	;call ApagaTela

	;loadn R1, #tela1Linha0	; Endereco onde comeca a primeira linha do cenario!!
	;loadn R2, #1536  			; cor branca!
	;call ImprimeTela2   		;  Rotina de Impresao de Cenario na Tela Inteira
    
	;loadn R1, #tela2Linha0	; Endereco onde comeca a primeira linha do cenario!!
	;loadn R2, #512  			; cor branca!
	;call ImprimeTela2   		;  Rotina de Impresao de Cenario na Tela Inteira
    
	;loadn R1, #tela3Linha0	; Endereco onde comeca a primeira linha do cenario!!
	;loadn R2, #2816   			; cor branca!
	;call ImprimeTela2   		;  Rotina de Impresao de Cenario na Tela Inteira

	;loadn R1, #tela4Linha0	; Endereco onde comeca a primeira linha do cenario!!
	;loadn R2, #256   			; cor branca!
	;call ImprimeTela2   		;  Rotina de Impresao de Cenario na Tela Inteira

	Loadn R0, #500			
	store posNave, R0		; Zera Posicao Atual da Nave
	store posAntNave, R0	; Zera Posicao Anterior da Nave
	
	store FlagTiro, R0		; Zera o Flag para marcar que ainda nao Atirou!
	store posTiro, R0		; Zera Posicao Atual do Tiro
	store posAntTiro, R0	; Zera Posicao Anterior do Tiro
	
	Loadn R0, #0
	store posMeteoro, R0	; Zera Posicao Atual do Meteoro
	store posAntMeteoro, R0	; Zera Posicao Anterior do Meteoro
	
	Loadn R0, #0			; Contador para os Mods	= 0
	loadn R2, #0			; Para verificar se (mod(c/10)==0

	;loadn R5, #0
	;store posInicialMeteoro, R5
	;loadn R6, #0			; Incrementador para a geração do meteoro
	;loadn R7, #65535		; Valor máximo que o incrementador chega

	Loop:
	
		loadn R1, #10
		mod R1, R0, R1
		cmp R1, R2			; if (mod(c/10)==0
		ceq MoveNave		; Chama Rotina de movimentacao da Nave
	
		loadn R1, #100		; velocidade de spawn e do meteoro
		mod R1, R0, R1
		cmp R1, R2			; if (mod(c/30)==0
		ceq moveMeteoro		; Chama Rotina de movimentacao do Meteoro
	
		loadn R1, #75		; velocidade do tiro
		mod R1, R0, R1
		cmp R1, R2			; if (mod(c/2)==0
		ceq MoveTiro		; Chama Rotina de movimentacao do Tiro


		call Delay
		inc R0 	;c++
		
		jmp Loop

;--------------------------FUNÇÕES------------------------


;; COMPLETAMENTE ERRADO

;======================METEORO===========================

geraMeteoro:
	
	store posMeteoro, r0

	loadn r1, #'!' ; coloca oa exclamacao de aviso
	outchar r1, r0

	store posAntMeteoro, r0
	loadn r1, #40
	add r0, r0, r1
	store posMeteoro, r0

	jmp moveMeteoro_Apaga

moveMeteoro:
	push fr
	push r0
	push r1
	push r2
	push r3
	push r4
	push r6
	push r7

	load r0, posMeteoro
	loadn r1, #0
	cmp r0, r1
	jeq geraMeteoro
	
	loadn r1, #1000 		; v c o meteoro chegou no fim da tela
	cmp r0, r1
	jgr apagaMeteoro

	loadn r1, #' ' 		; apaga o meteoro
	outchar r1, r0

	store posAntMeteoro, r0
	loadn r1, #40 		; movimenta o meteoro
	add r0, r0, r1
	store posMeteoro, r0

	loadn r1, #'*' 		; coloca o meteoro
	outchar r1, r0


;	loadn r1, #0
;	push r0
;	push r1

;	loadn r0, #0 ; volta o contador a 0
;	loadn r1, #65535

	load r1, posNave
	cmp r1, r0
	jeq fimJogo
	
	jmp verificaColisao_MetTiro

	moveMeteoro_Apaga:
		pop r7
		pop r6
		pop r4
		pop r3
		pop r2
		pop r1
		pop r0
		pop fr
		rts

apagaMeteoro:

	loadn r1, #' ' ; apaga o meteoro
	outchar r1, r0

	loadn r1, #40
	mod r0, r0, r1 ; volta ate a posicao da exclamacao

	loadn r1, #' '
	outchar r1, r0 ; apaga a exclamacao

	loadn r2, #0
	store posAntMeteoro, r2
	store posMeteoro, r2

	jmp geraNumero

geraNumero:

	load r1, posNave
	loadn r0, #Rand
	add r0, r0, r1

	load r1, posAntMeteoro
	add r0, r0, r1

	loadn r1, #40
	mod r0, r0, r1
	store numAleatorio, r0

	;push r0
	jmp geraMeteoro

;; ====================== COLISAO ======================

verificaColisao_MetTiro:


	load r0, posAntTiro
	load r1, posMeteoro
	load r2, posAntMeteoro
	load r3, posTiro

	cmp r1, r0			;
	jeq destroiMet		; faz varias comparacoes pq em velocidades altas ele nao detecta colisao
					
	cmp r0, r2			;
	jeq destroiMet		;

	cmp r3, r0			;
	jeq destroiMet		;

	cmp r3, r2			;
	jeq destroiMet		;

	jmp moveMeteoro_Apaga

	destroiMet:
		load r0, posAntTiro
		loadn r1, #' '
		outchar r1, r0
		loadn r7, #0
		store FlagTiro, r7

		load r0, posMeteoro
		jmp apagaMeteoro	

fimJogo:
	loadn r2, #' '		; apaga o meteoro
	outchar r2, r0		; e apaga a nave
	outchar r2, r1

	loadn r2, #40
	mod r0, r0, r2		; volta até a posição da exclamação

	loadn r2, #' '
	outchar r2, r0

	halt				; para o jogo

	jmp moveMeteoro_Apaga



;===========================NAVE==============================
MoveNave:
	push r0
	push r1

	call MoveNave_RecalculaPos		; Recalcula Posicao da Nave

; So' Apaga e Redezenha se (pos != posAnt)
;	If (posNave != posAntNave)	{
	load r0, posNave
	load r1, posAntNave
	cmp r0, r1
	jeq MoveNave_Skip
		call MoveNave_Apaga
		call MoveNave_Desenha		;}
  MoveNave_Skip:

	pop r1
	pop r0
	rts

;--------------------------------

MoveNave_Apaga:		; Apaga a Nave preservando o Cenario!
	push R0
	push R1
	push R2
	push R3
	push R4
	push R5

	load R0, posAntNave	; R0 = posAnt

	; --> R2 = Tela1Linha0 + posAnt + posAnt/40  ; tem que somar posAnt/40 no ponteiro pois as linas da string terminam com /0 !!

	loadn R1, #tela0Linha0	; Endereco onde comeca a primeira linha do cenario!!
	add R2, R1, r0	; R2 = Tela1Linha0 + posAnt
	loadn R4, #40
	div R3, R0, R4	; R3 = posAnt/40
	add R2, R2, R3	; R2 = Tela1Linha0 + posAnt + posAnt/40

	loadi R5, R2	; R5 = Char (Tela(posAnt))

	outchar R5, R0	; Apaga o Obj na tela com o Char correspondente na memoria do cenario

	pop R5
	pop R4
	pop R3
	pop R2
	pop R1
	pop R0
	rts
;----------------------------------

MoveNave_RecalculaPos:		; Recalcula posicao da Nave em funcao das Teclas pressionadas
	push R0
	push R1
	push R2
	push R3

	load R0, posNave

	inchar R1				; Le Teclado para controlar a Nave
	loadn R2, #'a'
	cmp R1, R2
	jeq MoveNave_RecalculaPos_A

	loadn R2, #'d'
	cmp R1, R2
	jeq MoveNave_RecalculaPos_D

	loadn R2, #'w'
	cmp R1, R2
	jeq MoveNave_RecalculaPos_W

	loadn R2, #'s'
	cmp R1, R2
	jeq MoveNave_RecalculaPos_S

	loadn R2, #' '
	cmp R1, R2
	jeq MoveNave_RecalculaPos_Tiro

  MoveNave_RecalculaPos_Fim:	; Se nao for nenhuma tecla valida, vai embora
	store posNave, R0
	pop R3
	pop R2
	pop R1
	pop R0
	rts

  MoveNave_RecalculaPos_A:	; Move Nave para Esquerda
	loadn R1, #40
	loadn R2, #0
	mod R1, R0, R1		; Testa condicoes de Contorno
	cmp R1, R2
	jeq MoveNave_RecalculaPos_Fim
	dec R0	; pos = pos -1
	jmp MoveNave_RecalculaPos_Fim

  MoveNave_RecalculaPos_D:	; Move Nave para Direita
	loadn R1, #40
	loadn R2, #39
	mod R1, R0, R1		; Testa condicoes de Contorno
	cmp R1, R2
	jeq MoveNave_RecalculaPos_Fim
	inc R0	; pos = pos + 1
	jmp MoveNave_RecalculaPos_Fim

  MoveNave_RecalculaPos_W:	; Move Nave para Cima
	loadn R1, #40
	cmp R0, R1		; Testa condicoes de Contorno
	jle MoveNave_RecalculaPos_Fim
	sub R0, R0, R1	; pos = pos - 40
	jmp MoveNave_RecalculaPos_Fim

  MoveNave_RecalculaPos_S:	; Move Nave para Baixo
	loadn R1, #1159
	cmp R0, R1		; Testa condicoes de Contorno
	jgr MoveNave_RecalculaPos_Fim
	loadn R1, #40
	add R0, R0, R1	; pos = pos + 40
	jmp MoveNave_RecalculaPos_Fim

  MoveNave_RecalculaPos_Tiro:
	loadn R1, #1			; Se Atirou:
	store FlagTiro, R1		; FlagTiro = 1
	store posTiro, R0		; posTiro = posNave
	jmp MoveNave_RecalculaPos_Fim
;----------------------------------
MoveNave_Desenha:	; Desenha caractere da Nave
	push R0
	push R1

	Loadn R1, #'X'	; Nave
	load R0, posNave
	outchar R1, R0
	store posAntNave, R0	; Atualiza Posicao Anterior da Nave = Posicao Atual

	pop R1
	pop R0
	rts



;======================MOVE TIRO==========================
MoveTiro:
	push fr
	push r0
	push r1
	push r2
	push r3
	push r4
	push r6
	push r7

	load r0, FlagTiro
	loadn r1, #0
	cmp r0, r1
	jeq MoveTiro_Final

	
	load r2, posTiro
	loadn r3, #40
	;loadn r6, #0
	;mod r7, r2, r3
	cmp r2, r3
	jle MoveTiro_Apaga
		
	load r0, posAntTiro
	loadn r1, #' '
	outchar r1, r0
	
	load r4, posTiro
	store posAntTiro, r4
		
	loadn r1, #'^'
	outchar r1, r4
	sub r4, r4, r3
	store posTiro, r4
	jmp MoveTiro_Final


;------
	;load r2, PosTiro
	;loadn r3, #40
	;loadn r6, #39
	;mod r7, r2, r3
	;cmp r7, r6
	;jeq MoveTiro_Apaga

	;load r0, PosAntTiro
	;loadn r1, #' '
	;outchar r1, r0       ;apaga a posicao anterior do tiro

	;load r4, PosTiro
	;store PosAntTiro, r4

	;loadn r1, #'o'      ;imprimi o caracter do tiro
	;outchar r1, r4
	;inc r4
	;store PosTiro, r4
	;jmp MoveTiro_Final


	


	MoveTiro_Apaga:
		load r0, posAntTiro
		loadn r1, #' '
		outchar r1, r0
		loadn r7, #0
		store FlagTiro, r7
		jmp MoveTiro_Final

	MoveTiro_Final:
		pop r7
		pop r6
		pop r4
		pop r3
		pop r2
		pop r1
		pop r0
		pop fr
		rts


;********************************************************
;                       DELAY
;********************************************************		


Delay:
						;Utiliza Push e Pop para nao afetar os Ristradores do programa principal
	Push R0
	Push R1
	
	Loadn R1, #5  ; a
   Delay_volta2:				;Quebrou o contador acima em duas partes (dois loops de decremento)
	Loadn R0, #3000	; b
   Delay_volta: 
	Dec R0					; (4*a + 6)b = 1000000  == 1 seg  em um clock de 1MHz
	JNZ Delay_volta	
	Dec R1
	JNZ Delay_volta2
	
	Pop R1
	Pop R0
	
	RTS							;return

;********************************************************
;                       IMPRIME TELA
;********************************************************	

ImprimeTela: 	;  Rotina de Impresao de Cenario na Tela Inteira
		;  r1 = endereco onde comeca a primeira linha do Cenario
		;  r2 = cor do Cenario para ser impresso

	push r0	; protege o r3 na pilha para ser usado na subrotina
	push r1	; protege o r1 na pilha para preservar seu valor
	push r2	; protege o r1 na pilha para preservar seu valor
	push r3	; protege o r3 na pilha para ser usado na subrotina
	push r4	; protege o r4 na pilha para ser usado na subrotina
	push r5	; protege o r4 na pilha para ser usado na subrotina

	loadn R0, #0  	; posicao inicial tem que ser o comeco da tela!
	loadn R3, #40  	; Incremento da posicao da tela!
	loadn R4, #41  	; incremento do ponteiro das linhas da tela
	loadn R5, #1200 ; Limite da tela!

   ImprimeTela_Loop:
		call ImprimeStr
		add r0, r0, r3  	; incrementaposicao para a segunda linha na tela -->  r0 = R0 + 40
		add r1, r1, r4  	; incrementa o ponteiro para o comeco da proxima linha na memoria (40 + 1 porcausa do /0 !!) --> r1 = r1 + 41
		cmp r0, r5			; Compara r0 com 1200
		jne ImprimeTela_Loop	; Enquanto r0 < 1200

	pop r5	; Resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

;********************************************************
;                   IMPRIME STRING
;********************************************************
	
ImprimeStr:	;  Rotina de Impresao de Mensagens:    r0 = Posicao da tela que o primeiro caractere da mensagem sera' impresso;  r1 = endereco onde comeca a mensagem; r2 = cor da mensagem.   Obs: a mensagem sera' impressa ate' encontrar "/0"
	push r0	; protege o r0 na pilha para preservar seu valor
	push r1	; protege o r1 na pilha para preservar seu valor
	push r2	; protege o r1 na pilha para preservar seu valor
	push r3	; protege o r3 na pilha para ser usado na subrotina
	push r4	; protege o r4 na pilha para ser usado na subrotina
	
	loadn r3, #'\0'	; Criterio de parada

   ImprimeStr_Loop:	
		loadi r4, r1
		cmp r4, r3		; If (Char == \0)  vai Embora
		jeq ImprimeStr_Sai
		add r4, r2, r4	; Soma a Cor
		outchar r4, r0	; Imprime o caractere na tela
		inc r0			; Incrementa a posicao na tela
		inc r1			; Incrementa o ponteiro da String
		jmp ImprimeStr_Loop
	
   ImprimeStr_Sai:	
	pop r4	; Resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r3
	pop r2
	pop r1
	pop r0
	rts


;********************************************************
;                       IMPRIME TELA2
;********************************************************

ImprimeTela2: 	;  Rotina de Impresao de Cenario na Tela Inteira
		;  r1 = endereco onde comeca a primeira linha do Cenario
		;  r2 = cor do Cenario para ser impresso

	push r0	; protege o r3 na pilha para ser usado na subrotina
	push r1	; protege o r1 na pilha para preservar seu valor
	push r2	; protege o r1 na pilha para preservar seu valor
	push r3	; protege o r3 na pilha para ser usado na subrotina
	push r4	; protege o r4 na pilha para ser usado na subrotina
	push r5	; protege o r5 na pilha para ser usado na subrotina
	push r6	; protege o r6 na pilha para ser usado na subrotina

	loadn R0, #0  	; posicao inicial tem que ser o comeco da tela!
	loadn R3, #40  	; Incremento da posicao da tela!
	loadn R4, #41  	; incremento do ponteiro das linhas da tela
	loadn R5, #1200 ; Limite da tela!
	loadn R6, #tela0Linha0	; Endereco onde comeca a primeira linha do cenario!!

   ImprimeTela2_Loop:
		call ImprimeStr2
		add r0, r0, r3  	; incrementaposicao para a segunda linha na tela -->  r0 = R0 + 40
		add r1, r1, r4  	; incrementa o ponteiro para o comeco da proxima linha na memoria (40 + 1 porcausa do /0 !!) --> r1 = r1 + 41
		add r6, r6, r4  	; incrementa o ponteiro para o comeco da proxima linha na memoria (40 + 1 porcausa do /0 !!) --> r1 = r1 + 41
		cmp r0, r5			; Compara r0 com 1200
		jne ImprimeTela2_Loop	; Enquanto r0 < 1200

	pop r6	; Resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

;********************************************************
;                   IMPRIME STRING2
;********************************************************

ImprimeStr2:	;  Rotina de Impresao de Mensagens:    r0 = Posicao da tela que o primeiro caractere da mensagem sera' impresso;  r1 = endereco onde comeca a mensagem; r2 = cor da mensagem.   Obs: a mensagem sera' impressa ate' encontrar "/0"
	push r0	; protege o r0 na pilha para preservar seu valor
	push r1	; protege o r1 na pilha para preservar seu valor
	push r2	; protege o r1 na pilha para preservar seu valor
	push r3	; protege o r3 na pilha para ser usado na subrotina
	push r4	; protege o r4 na pilha para ser usado na subrotina
	push r5	; protege o r5 na pilha para ser usado na subrotina
	push r6	; protege o r6 na pilha para ser usado na subrotina


	loadn r3, #'\0'	; Criterio de parada
	loadn r5, #' '	; Espaco em Branco

   ImprimeStr2_Loop:
		loadi r4, r1
		cmp r4, r3		; If (Char == \0)  vai Embora
		jeq ImprimeStr2_Sai
		cmp r4, r5		; If (Char == ' ')  vai Pula outchar do espaco para na apagar outros caracteres
		jeq ImprimeStr2_Skip
		add r4, r2, r4	; Soma a Cor
		outchar r4, r0	; Imprime o caractere na tela
		storei r6, r4
   ImprimeStr2_Skip:
		inc r0			; Incrementa a posicao na tela
		inc r1			; Incrementa o ponteiro da String
		inc r6			; Incrementa o ponteiro da String da Tela 0
		jmp ImprimeStr2_Loop

   ImprimeStr2_Sai:
	pop r6	; Resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts


;; ====================== PRINT ======================

print:

	; r0 posicao inicial
	; r1 string
	; r2 é a cor

	push r1	
	push r2	
	push r3	
	push r4	
	
	loadn r3, #'\0'	; criterio de parada

	printLoop:	
		loadi r4, r1    ; r4 <-- r1
		cmp r4, r3      ; r4 == r3?
		jeq printOut    ; se sim, sai da funcao
		add r4, r2, r4  ; coloca cor 
		outchar r4, r0  ; printa
		inc r0   	    ; anda pelo mapa
		inc r1	        ; anda pela string
		jmp printLoop   ;

	printOut:
		pop r4	
		pop r3
		pop r2
		pop r1

		rts

;; ====================== ESPERA INPUT CORRETO PARA COMEÇAR ======================

waitForBegin:

	push r0 
	push r1

	loadn r1, #13

	loopInput:
		inchar r0 ; le input do usuário

		cmp r0, r1 ; compara input com char estabelecido
		
		jne loopInput

		call clearScreen 
	
	pop r1
	pop r0

	rts


;; ====================== CLEAR SCREEN ======================
clearScreen:

	push r5
	push r6

	loadn r5, #1200
	loadn r6, #' '

	clearScreenLoop:
		dec r5
		outchar r6, r5
		jnz clearScreenLoop
	
	pop r6
	pop r5

	rts


;********************************************************
;                   DIGITE UMA LETRA
;********************************************************

DigLetra:	; Espera que uma tecla seja digitada e salva na variavel global "Letra"
	push r0
	push r1
	loadn r1, #255	; Se nao digitar nada vem 255

   DigLetra_Loop:
		inchar r0			; Le o teclado, se nada for digitado = 255
		cmp r0, r1			;compara r0 com 255
		jeq DigLetra_Loop	; Fica lendo ate' que digite uma tecla valida

	store Letra, r0			; Salva a tecla na variavel global "Letra"

	pop r1
	pop r0
	rts


;********************************************************
;                       APAGA TELA
;********************************************************
ApagaTela:
	push r0
	push r1

	loadn r0, #1200		; apaga as 1200 posicoes da Tela
	loadn r1, #' '		; com "espaco"

	   ApagaTela_Loop:	;;label for(r0=1200;r3>0;r3--)
		dec r0
		outchar r1, r0
		jnz ApagaTela_Loop

	pop r1
	pop r0
	rts


;------------------------
; Declara uma tela vazia para ser preenchida em tempo de execussao:

tela0Linha0  : string "                                        "
tela0Linha1  : string "                                        "
tela0Linha2  : string "                                        "
tela0Linha3  : string "                                        "
tela0Linha4  : string "                                        "
tela0Linha5  : string "                                        "
tela0Linha6  : string "                                        "
tela0Linha7  : string "                                        "
tela0Linha8  : string "                                        "
tela0Linha9  : string "                                        "
tela0Linha10 : string "                                        "
tela0Linha11 : string "                                        "
tela0Linha12 : string "                                        "
tela0Linha13 : string "                                        "
tela0Linha14 : string "                                        "
tela0Linha15 : string "                                        "
tela0Linha16 : string "                                        "
tela0Linha17 : string "                                        "
tela0Linha18 : string "                                        "
tela0Linha19 : string "                                        "
tela0Linha20 : string "                                        "
tela0Linha21 : string "                                        "
tela0Linha22 : string "                                        "
tela0Linha23 : string "                                        "
tela0Linha24 : string "                                        "
tela0Linha25 : string "                                        "
tela0Linha26 : string "                                        "
tela0Linha27 : string "                                        "
tela0Linha28 : string "                                        "
tela0Linha29 : string "                                        "

; Declara e preenche tela linha por linha (40 caracteres):
tela1Linha0  : string "                                        "
tela1Linha1  : string "                                        "
tela1Linha2  : string "                                        "
tela1Linha3  : string "                                        "
tela1Linha4  : string "                                        "
tela1Linha5  : string "                                        "
tela1Linha6  : string "                                        "
tela1Linha7  : string "                                        "
tela1Linha8  : string "                        @@@@            "
tela1Linha9  : string "                      @@@@@@@@@@        "
tela1Linha10 : string "                       @@@@@@@@@@@@     "
tela1Linha11 : string "                         @@@            "
tela1Linha12 : string "                                        "
tela1Linha13 : string "                                        "
tela1Linha14 : string "                                        "
tela1Linha15 : string "                                        "
tela1Linha16 : string "                                        "
tela1Linha17 : string "                                        "
tela1Linha18 : string "                                        "
tela1Linha19 : string "                                        "
tela1Linha20 : string "                                        "
tela1Linha21 : string "                                        "
tela1Linha22 : string "                                        "
tela1Linha23 : string "                                        "
tela1Linha24 : string "                                        "
tela1Linha25 : string "                                        "
tela1Linha26 : string "                                        "
tela1Linha27 : string "                                        "
tela1Linha28 : string "                                        "
tela1Linha29 : string "                                        "



; Declara e preenche tela linha por linha (40 caracteres):
tela2Linha0  : string "                                        "
tela2Linha1  : string "                                        "
tela2Linha2  : string "                                        "
tela2Linha3  : string "                                        "
tela2Linha4  : string "                                        "
tela2Linha5  : string "                                        "
tela2Linha6  : string "                                        "
tela2Linha7  : string "                                        "
tela2Linha8  : string "                                        "
tela2Linha9  : string "                                        "
tela2Linha10 : string "                                        "
tela2Linha11 : string "                                        "
tela2Linha12 : string "                                        "
tela2Linha13 : string "                                        "
tela2Linha14 : string "                                        "
tela2Linha15 : string "                                        "
tela2Linha16 : string "                                        "
tela2Linha17 : string "                     :  :               "
tela2Linha18 : string "          :  :     :      :             "
tela2Linha19 : string "       :       : :          :           "
tela2Linha20 : string "     :        :    :         :          "
tela2Linha21 : string "            :         :                 "
tela2Linha22 : string "          :             :               "
tela2Linha23 : string "         :                :             "
tela2Linha24 : string "         :                 :            "
tela2Linha25 : string "          :               :             "
tela2Linha26 : string "                                        "
tela2Linha27 : string "                                        "
tela2Linha28 : string "                                        "
tela2Linha29 : string "                                        "


; Declara e preenche tela linha por linha (40 caracteres):
tela3Linha0  : string "                                        "
tela3Linha1  : string "                                        "
tela3Linha2  : string "                                        "
tela3Linha3  : string "                                        "
tela3Linha4  : string "    .  |  .                             "
tela3Linha5  : string "      OOO                               "
tela3Linha6  : string "   - OOOOO -                            "
tela3Linha7  : string "      OOO                               "
tela3Linha8  : string "    .  |  .                             "
tela3Linha9  : string "                                        "
tela3Linha10 : string "                                        "
tela3Linha11 : string "                                        "
tela3Linha12 : string "                                        "
tela3Linha13 : string "                                        "
tela3Linha14 : string "                                        "
tela3Linha15 : string "                                        "
tela3Linha16 : string "                                        "
tela3Linha17 : string "                                        "
tela3Linha18 : string "                                        "
tela3Linha19 : string "                                        "
tela3Linha20 : string "                **                      "
tela3Linha21 : string "                                        "
tela3Linha22 : string "                                        "
tela3Linha23 : string "                                        "
tela3Linha24 : string "                                        "
tela3Linha25 : string "                                        "
tela3Linha26 : string "                                        "
tela3Linha27 : string "                                        "
tela3Linha28 : string "                                        "
tela3Linha29 : string "                                        "



tela4Linha0  : string "                                        "
tela4Linha1  : string "                                        "
tela4Linha2  : string "                                        "
tela4Linha3  : string "                                        "
tela4Linha4  : string "                                        "
tela4Linha5  : string "                                        "
tela4Linha6  : string "                                        "
tela4Linha7  : string "                                        "
tela4Linha8  : string "                                        "
tela4Linha9  : string "                                        "
tela4Linha10 : string "                                        "
tela4Linha11 : string "                                        "
tela4Linha12 : string "                                        "
tela4Linha13 : string "                                        "
tela4Linha14 : string "                                        "
tela4Linha15 : string "                                        "
tela4Linha16 : string "                                        "
tela4Linha17 : string "                                        "
tela4Linha18 : string "                                        "
tela4Linha19 : string "                                        "
tela4Linha20 : string "                                        "
tela4Linha21 : string "                 ..                     "
tela4Linha22 : string "                  ..                    "
tela4Linha23 : string "                   ..                   "
tela4Linha24 : string "                   ..                   "
tela4Linha25 : string "                  ...                   "
tela4Linha26 : string "                 ...                    "
tela4Linha27 : string "                ...                     "
tela4Linha28 : string "               ....                     "
tela4Linha29 : string "              .....                     "

