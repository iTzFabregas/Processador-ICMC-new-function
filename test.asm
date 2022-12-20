jmp main

main:
    loadn r0, #4 ; numero a ser tirado raiz quadrada
    loadn r1, #0 ; posicao

    sqrt r0, r0

    loadn r2, #48
    add r0, r2, r0

    outchar r0, r1
    
    jmp main