      *>---------------------------------------------------------------*
      *> MANGRP.COB - MANUTENCAO DE GRUPOS DE PRODUTOS                 *
      *>---------------------------------------------------------------*
       IDENTIFICATION DIVISION.
       PROGRAM-ID. MANGRP.
       AUTHOR. MARCAL SANTAREM.
      *>---------------------------------------------------------------*
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.
      *>---------------------------------------------------------------*
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           COPY                   ARQSELEC.CPY
                           REPLACING ==XARQARQ== BY ==ARQ-GRP==
                                        ==XNOM== BY =="DADOSGRP.DAD"==
                                        ==XKEY== BY ==GRP-CODIGO==
                                      ==XFSARQ== BY ==FS-GRP==.
      *>---------------------------------------------------------------*
       DATA DIVISION.
       FILE SECTION.
      *>-> Registro do arquivo de grupos de produtos
           COPY                   ARQREGFD.CPY
                                REPLACING ==XARQARQ== BY ==ARQ-GRP==
                                             ==XREG== BY ==REG-GRUPO==.
          05 GRP-CODIGO           PIC 9(04).
          05 GRP-DESCRICAO        PIC X(40).
          05 GRP-ATIVO            PIC X(01).
      *>---------------------------------------------------------------*
       WORKING-STORAGE SECTION.
       01 WS-WORKING.
      *>-> Variáveis para manipulação de opções do menu e controle de loop 
          05 WS-OPCAO             PIC X  VALUE SPACES.
      *>-> Variáveis para manipulação de grupos de produtos 
          05 WS-GRPPRD.
             10 WS-GRPPRD-COD     PIC 9(04) VALUE ZEROS.
             10 WS-GRPPRD-DES     PIC X(30) VALUE SPACES.
             10 WS-GRPPRD-SIT     PIC X(01) VALUE SPACES.
                88 GRPPRD-SITATI            VALUE 'S'.
                88 GRPPRD-SITINA            VALUE 'N'.       
      *>-> Variável para controle de validade dos dados
          05 WS-VALIDO            PIC 9(1).
             88 VALIDO-SIM                 VALUE 1.
             88 VALIDO-NAO                 VALUE 0.
          05 WS-ERROR-MSG         PIC X(50) VALUE SPACES.
      *>-> File status do arquivo de grupos de produtos
           COPY                   ARQFILES.CPY
                           REPLACING ==XFSARQ== BY ==FS-GRP==
                                     ==XFSOK==  BY ==FS-GRP-OK==
                                     ==XFSDUP== BY ==FS-GRP-DUPLICADO==
                                      ==XFSNF== BY ==FS-GRP-NOT-FOUND==
                                      ==XFSNE== BY ==FS-GRP-NOT-EXIST==
                                     ==XFSEOF== BY ==FS-GRP-EOF==.
      *>---------------------------------------------------------------*
       SCREEN SECTION.
      *>---------------------------------------------------------------*
      *>-> Tela limpa para inicialização
       01 TELA-LIMPA
          BLANK SCREEN.
      *>---------------------------------------------------------------*
      *>-> Tela base com layout e opções de menu    
       01 TELA-BASE.                           
          COPY                    MANUBASE.CPY 
                REPLACING ==(MANUTENCAO)== BY =="GRUPOS DE PRODUTOS"==.
          05 LINE 15 COL  2 VALUE "Codigo    :".
          05 LINE 16 COL  2 VALUE "Descricao :".
          05 LINE 17 COL  2 VALUE "Ativo(S/N):".
          05 LINE 18 COL  1 VALUE
             "--------------------------------------------------".
      *>---------------------------------------------------------------*
      *>-> Tela para entrada de opções do menu       
       01 TELA-OPCAO.
          05 LINE  9 COL  9
             PIC X(1)    USING WS-OPCAO
             FOREGROUND-COLOR 14 HIGHLIGHT.
      *>---------------------------------------------------------------*
      *>-> Tela para exibição e entrada de dados do grupo de produto       
       01 TELA-DADOS.
          05 LINE 15 COL 14 
             PIC Z(4) USING WS-GRPPRD-COD
             FOREGROUND-COLOR 14 HIGHLIGHT.
          05 LINE 16 COL 14 PIC X(30)   USING WS-GRPPRD-DES.
          05 LINE 17 COL 14 PIC X(01)   USING WS-GRPPRD-SIT.
      *>---------------------------------------------------------------*
      *>-> Tela para exibição do código do grupo de produto durante busca por código    
       01 TELA-CODIGO.
          05 LINE 15 COL 15 
             PIC Z(4) USING WS-GRPPRD-COD
             FOREGROUND-COLOR 14 HIGHLIGHT.
      *>---------------------------------------------------------------*
       PROCEDURE DIVISION.
      *>---------------------------------------------------------------*
      *>-> Rotinas de arquivos de dados 
           COPY                   ARQROTIN.CPY
                           REPLACING ==XOPEN== BY ==OPEN-GRP==
                                    ==XCLOSE== BY ==CLOSE-GRP==
                                     ==XREAD== BY ==READ-GRP==
                                  ==XREWRITE== BY ==RE-WRITE-GRP==
                                   ==XDELETE== BY ==DELETE-GRP==
                                   ==XARQARQ== BY ==ARQ-GRP==
                                      ==XREG== BY ==REG-GRUPO==
                                     ==XFSOK== BY ==FS-GRP-OK==
                                    ==XFSDUP== BY ==FS-GRP-DUPLICADO==
                                     ==XFSNE== BY ==FS-GRP-NOT-EXIST==
                                      ==XKEY== BY ==GRP-CODIGO==.
      *>---------------------------------------------------------------*
       INICIO.
           PERFORM                OPEN-GRP.
           PERFORM                GRP-MANUTENCAO.
           PERFORM                CLOSE-GRP.
           EXIT PROGRAM.
      *>---------------------------------------------------------------*
      *>-> Manutenção de grupos de produtos     
       GRP-MANUTENCAO.
      *>-> Limpa a tela e exibe o menu de opções     
           DISPLAY                TELA-LIMPA
           DISPLAY                TELA-BASE
           PERFORM                GRP-LOOP-OPCOES UNTIL WS-OPCAO = "E"
                                                     OR WS-OPCAO = "e".
      *>---------------------------------------------------------------*       
      *>-> Aceita a opção do usuário e direciona para a rotina correspondente                                               
       GRP-LOOP-OPCOES.
           MOVE SPACES            TO WS-OPCAO.
           INITIALIZE             WS-GRPPRD.
           ACCEPT                 TELA-OPCAO.
           EVALUATE TRUE
               WHEN WS-OPCAO = "N" OR WS-OPCAO = "n"
                   PERFORM GRP-NOVO
               WHEN WS-OPCAO = "B" OR WS-OPCAO = "b"
                   PERFORM GRP-CONSULTAR
               WHEN WS-OPCAO = "G" OR WS-OPCAO = "g"
                   CONTINUE
               WHEN WS-OPCAO = "X" OR WS-OPCAO = "x"
                   CONTINUE
               WHEN WS-OPCAO = "E" OR WS-OPCAO = "e"
                   CONTINUE
               WHEN OTHER
                   DISPLAY "Opcao invalida." AT LINE 20 COL 2
                   CALL "SYSTEM" USING "PAUSE"
           END-EVALUATE.
      *>---------------------------------------------------------------* 
      *>-> Rotina para criação de um novo grupo de produto     
       GRP-NOVO.
           SET GRPPRD-SITATI TO TRUE
           ACCEPT                 TELA-DADOS.
           PERFORM                GRP-VALIDA-DADOS.
           IF NOT VALIDO-SIM
              DISPLAY WS-ERROR-MSG AT LINE 20 COL 2
              CALL "SYSTEM" USING "PAUSE"
              EXIT                PARAGRAPH           
           END-IF
           PERFORM                RE-WRITE-GRP
           IF FS-GRP-OK
              DISPLAY "Grupo de produto gravado com sucesso." 
                                  AT LINE 20 COL 2
           ELSE
              DISPLAY "Erro ao gravar grupo de produto." 
                                  AT LINE 20 COL 2
           END-IF.
      *>---------------------------------------------------------------* 
      *>-> Rotina para consulta de grupos de produtos     
       GRP-CONSULTAR.
      *>-> Aceita o código do grupo de produtos
           ACCEPT                 TELA-CODIGO.
      *>-> Se informou código para consultar     
           IF WS-GRPPRD-COD IS NOT EQUAL TO ZEROS
      *>-> Lê o grupo de produtos        
              MOVE WS-GRPPRD-COD  TO GRP-CODIGO
              PERFORM             READ-GRP
      *>-> Se leu ok        
              IF FS-GRP-OK
                 MOVE REG-GRUPO   TO WS-GRPPRD
              ELSE
                 MOVE "Grupo de produto nao encontrado." TO WS-ERROR-MSG
              END-IF
           END-IF.
      *>---------------------------------------------------------------* 
      *>-> Rotina para validação dos dados do grupo de produto     
       GRP-VALIDA-DADOS.
      *>-> Presume que não é válido     
           SET VALIDO-NAO TO TRUE.
      *>-> Se não informou código ou código é zero
           IF WS-GRPPRD-COD IS EQUAL TO ZEROS
              MOVE "Codigo do grupo de produto nao pode ser zero." 
                                  TO WS-ERROR-MSG,
              EXIT                PARAGRAPH,
           END-IF
      *>-> Se não informou descrição
           IF WS-GRPPRD-DES IS EQUAL TO SPACES
               MOVE "Descricao do grupo de produto nao pode ser vazia." 
                                   TO WS-ERROR-MSG,
               EXIT                PARAGRAPH,
           END-IF
      *>-> Se situação não é 'S' ou 'N'
           IF NOT (GRPPRD-SITATI OR GRPPRD-SITINA)
               MOVE "Situacao do grupo de produto deve ser 'S' ou 'N'." 
                                   TO WS-ERROR-MSG,
               EXIT                PARAGRAPH,
           END-IF
      *>-> Verifica se código do grupo de produto já existe
           MOVE WS-GRPPRD-COD  TO GRP-CODIGO,
           PERFORM             READ-GRP,           
           IF FS-GRP-OK
               MOVE "Codigo do grupo de produto ja existe." 
                                   TO WS-ERROR-MSG,
               EXIT                PARAGRAPH,
           END-IF
      *>-> Indica que o registro é válido
           SET VALIDO-SIM TO TRUE.
      *>---------------------------------------------------------------*
