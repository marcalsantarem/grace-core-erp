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
                              REPLACING ==XARQ-== BY ==GRP==
                                      ==XARQNOM== BY =="DADOSGRP.DAD"==
                                      ==XARQKEY== BY ==GRP-CODIGO==.
      *>---------------------------------------------------------------*
       DATA DIVISION.
       FILE SECTION.
      *>-> Registro do arquivo de grupos de produtos
           COPY                   ARQREGFD.CPY
                                 REPLACING ==XARQ-== BY ==GRP==
                                           ==XREG-== BY ==REG-GRUPO==.
          05 GRP-CODIGO           PIC 9(04).
          05 GRP-DESCRICAO        PIC X(40).
          05 GRP-ATIVO            PIC X(01).
      *>---------------------------------------------------------------*
       WORKING-STORAGE SECTION.
      *>-> Variáveis para manipulação de opções do menu e controle de loop 
       01 WS-OPCAO                PIC X  VALUE SPACES.
      *>-> Variáveis para manipulação de grupos de produtos 
       01 WS-GRPPRD.
          05 WS-GRPPRD-COD        PIC 9(04) VALUE ZEROS.
          05 WS-GRPPRD-DES        PIC X(30) VALUE SPACES.
          05 WS-GRPPRD-SIT        PIC X(01) VALUE SPACES.
             88 GRPPRD-SITATI               VALUE 'S'.
             88 GRPPRD-SITINA               VALUE 'N'.
      *>-> File status do arquivo de grupos de produtos
           COPY                   ARQFILES.CPY
                                 REPLACING ==XARQ-== BY ==GRP==.
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
       INICIO.
           PERFORM                DESENHAR-TELA.
           EXIT PROGRAM.
      *>---------------------------------------------------------------*
       DESENHAR-TELA.
           DISPLAY                TELA-LIMPA     
           DISPLAY                TELA-BASE
           ACCEPT                 TELA-OPCAO.
      *>---------------------------------------------------------------*
           COPY                   ARQROTIN.CPY
                                 REPLACING ==XARQ-== BY ==GRP==
                                           ==XREG-== BY ==REG-GRUPO==
                                         ==XARQKEY== BY ==GRP-CODIGO==.
      *>---------------------------------------------------------------*
