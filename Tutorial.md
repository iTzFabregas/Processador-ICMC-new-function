## Como foi implementado essas funções

Primeiro é necessário dar git clone no repositório do processador do ICMC, usando o seguinte comando:
```bash
  git clone https://github.com/simoesusp/Processador-ICMC.git
```

No repositório, será necessário mexer em apenas 4 arquivos, 2 no ```montado``` e 2 no ```simulador```.

No montador os arquivos são: ```defs.h``` e ```monatador.c```

No simulador os arquivos são: ```Mneumonicos.h``` e ```Model.cpp```

* ```defs.h``` -> terá que criar 3 defines (FUNCAO será o nome de uma função arbitrária a ser implementada):
  * FUNCAO_CODE -> colocar um numero de 0 a 99 que está disponível
  ```bash
   #define FUNCAO_CODE 99
  ```
  * FUNCAO      -> seguir a onde dos numero binários
  ```bash
   #define FUNCAO "101010"
  ```
  * FUNCAO_STR  -> modo como a função será chamada no assembly, em CAPS
  ```bash
   #define FUNCAO "FUNCAO"
  ```

* ```montador.c``` -> mexeremos em 3 funções
  * DetectarLabels -> procurar o switch que a nova função se encaixa, baseado nos seus argumentos (numero de registradores), e colocar o case
    ```bash
      /* Instrucoes de 3 argumentos e 1 linha : instr (), (), () -> [...] */
              case ADD_CODE :
                parser_SkipUntil(',');
                parser_SkipUntil(',');
                parser_SkipUntilEnd();
                end_cnt++;
                break;
    ```
  * MontarInstrucoes -> criar um novo case e copiar o template dos outros, tendo em vista o numero de registradores da sua função
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
      end_cnt += 1; // vai para a próxima linha
      break;
    ```
  * BuscaInstrucao -> colocar um else if a mais baseado naqueles já criados
    ``` bash
      else if (strcmp(str_tmp,ADD_STR) == 0)
      {
          return ADD_CODE;
      }
    ```
