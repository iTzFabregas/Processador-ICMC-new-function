## Como foi implementado essas funções

Primeiro é necessário dar git clone no repositório do processador do ICMC, usando o seguinte comando:
```bash
  git clone https://github.com/simoesusp/Processador-ICMC.git
```

No repositório, será necessário mexer em apenas 4 arquivos, 2 no ```montador``` e 2 no ```simulador```.

No montador os arquivos são: ```defs.h``` e ```montador.c```

No simulador os arquivos são: ```Mneumonicos.h``` e ```Model.cpp```

* ```defs.h``` -> criaremos 3 defines (FUNCAO será o nome de uma função arbitrária a ser implementada):
  * FUNCAO_CODE -> colocar um numero de 0 a 99 que está disponível. Exemplo:
  ```bash
   #define FUNCAO_CODE 99
  ```
  * FUNCAO      -> seguir a ordem dos números em binários. Exemplo:
  ```bash
   #define FUNCAO "101010"
  ```
  * FUNCAO_STR  -> modo como a função será chamada no assembly, em CAPS. Exemplo:
  ```bash
   #define FUNCAO_STR "FUNCAO"
  ```

* ```montador.c``` -> mexeremos em 3 funções:
  * DetectarLabels -> procurar o switch que a nova função se encaixa, baseado nos seus argumentos (numero de registradores) e colocar o case. Exemplo:
    ```bash
      /* Instrucoes de 3 argumentos e 1 linha : instr (), (), () -> [...] */
              case ADD_CODE : // add RX, RY, RZ -> 3 argumentos(registradores ou endereços)
                parser_SkipUntil(',');
                parser_SkipUntil(',');
                parser_SkipUntilEnd();
                end_cnt++;
                break;
    ```
  * MontarInstrucoes -> criar um novo case e copiar o template dos outros, tendo em vista o numero de registradores da sua função. Exemplo:
    ```bash
      case ADD_CODE :  // Add RX, RY, RZ (3 registradores de argumento)
      str_tmp1 = parser_GetItem_s(); // le o primeiro registrador
      val1 = BuscaRegistrador(str_tmp1); // transformar o registrador lido em um int para identificá-lo
      free(str_tmp1); // libera essa string
      parser_Match(','); // pula a vírgula
      str_tmp2 = parser_GetItem_s(); // le o segundo registrador
      val2 = BuscaRegistrador(str_tmp2); // transformar o registrador lido em um int para identificá-lo
      free(str_tmp2); // libera essa string
      parser_Match(','); // pula a vírgula
      str_tmp3 = parser_GetItem_s(); // le o terceiro registrador
      val3 = BuscaRegistrador(str_tmp3); // transformar o registrador lido em um int para identificá-lo
      free(str_tmp3); // libera essa string
      str_tmp1 = ConverteRegistrador(val1); // transformar o registrador X em binário
      str_tmp2 = ConverteRegistrador(val2); // transformar o registrador Y em binário
      str_tmp3 = ConverteRegistrador(val3); // transformar o registrador Z em binário
      sprintf(str_msg,"%s%s%s%s0",ADD,str_tmp1,str_tmp2,str_tmp3); // cria a string relacionada a essa linha de comando para colocar no .mif
      free(str_tmp1); //libera memória
      free(str_tmp2); //libera memória
      free(str_tmp3); //libera memória
      parser_Write_Inst(str_msg,end_cnt); // escreve a instrução transformada em binário no arquivo
      end_cnt += 1; // pula para a próxima linha
      break;
    ```
  * BuscaInstrucao -> colocar um else if a mais baseado naqueles já criados. Exemplo:
    ``` bash
      else if (strcmp(str_tmp,ADD_STR) == 0)
      {
          return ADD_CODE;
      }
    ```
* ```Mneumonicos.h``` -> criaremos 1 define:
  * FUNCAO -> criar um define com o nome da função a ser criada com o mesmo valor criado em binário no arquivo ```defs.h``` só que em decimal. Exemplo:
  ``` bash
    #define FUNCAO 42
  ```
* ``` Model.cpp ``` -> mexeremos em 1 função:
  * Model::processador -> criar um case para a nova função criada e é ai que será programado como a função funcionará. Exemplo:
  ``` bash
    case ADD:
        reg[rx] = reg[ry] + reg[rz]; // Soma sem Carry

        if(pega_pedaco(ir,0,0)) {    // Soma com Carry
        	reg[rx] += FR[4];
          FR[3] = 0; // -- FR = <...|zero|equal|lesser|greater>
          FR[4] = 0;
        }    
        
        if(!reg[rx]) { // Se resultado = 0, seta o Flag de Zero
					FR[3] = 1;
        } else {
        	if(reg[rx] > 0xffff) { 
            FR[4] = 1;  // Deu Carry
          	reg[rx] = reg[rx] - 0xffff;
        	}
        break;
  ```
  
### Observação:

Para arrumar como a função é apresentada pelo simulador, alterar no arquivo ``` View.cpp ``` na função ``` View::show_program ```. Exemplo:
```bash
  case ADD: sprintf(texto, "PC: %05d\t|	ADD R%d, R%d, R%d		|	R%d <- R%d + R%d", 		pc, _rx, _ry, _rz, _rx, _ry, _rz); break;
