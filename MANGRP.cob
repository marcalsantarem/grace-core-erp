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
      *> Grupos de produtos
           SELECT ARQ-GRUPOS      ASSIGN TO "GRUPOPRO.DAD"
                                  ORGANIZATION IS INDEXED
                                  ACCESS MODE IS DYNAMIC
                                  RECORD KEY IS GRP-CODIGO
                                  FILE STATUS IS FS-GRUPOS.
      *>---------------------------------------------------------------*
       DATA DIVISION.
       FILE SECTION.
      * Registro do arquivo de grupos de produtos
       FD ARQ-GRUPOS.
       01 REG-GRUPO.
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
       01 FS-GRUPOS              PIC X(02) VALUE "00".
          88 FS-GRUPOS-OK                  VALUE "00".
          88 FS-GRUPOS-DUPLICADO           VALUE "22".
          88 FS-GRUPOS-NOT-FOUND           VALUE "23".
          88 FS-GRUPOS-NOT-EXIST           VALUE "35".
          88 FS-GRUPOS-EOF                 VALUE "10".
      *>---------------------------------------------------------------*
       SCREEN SECTION.
      *>---------------------------------------------------------------*
       01 TELA-LIMPA
          BLANK SCREEN.
      *>---------------------------------------------------------------*
       01 TELA-BASE.                           
          COPY                    MANUBASE.CPY 
                REPLACING ==(MANUTENCAO)== BY =="GRUPOS DE PRODUTOS"==.
          05 LINE 15 COL  2 VALUE "Codigo    :".
          05 LINE 16 COL  2 VALUE "Descricao :".
          05 LINE 17 COL  2 VALUE "Ativo(S/N):".
          05 LINE 18 COL  1 VALUE
             "--------------------------------------------------".
      *>---------------------------------------------------------------*
       01 TELA-OPCAO.
          05 LINE  9 COL  9
             PIC X(1)    USING WS-OPCAO
             FOREGROUND-COLOR 14 HIGHLIGHT.
      *>---------------------------------------------------------------*
       01 TELA-DADOS.
          05 LINE 15 COL 14 
             PIC Z(4) USING WS-GRPPRD-COD
             FOREGROUND-COLOR 14 HIGHLIGHT.
          05 LINE 16 COL 14 PIC X(30)   USING WS-GRPPRD-DES.
          05 LINE 17 COL 14 PIC X(01)   USING WS-GRPPRD-SIT.
      *>---------------------------------------------------------------*
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
      *> Abre arquivo de grupos de produtos
       ABRIR-ARQUIVO.
      *>-> Tenta abrir o arquivo, se nao existir, cria um novo arquivo vazio     
           OPEN I-O               ARQ-GRUPOS
           IF FS-GRUPOS = "35"
               OPEN OUTPUT        ARQ-GRUPOS
               CLOSE              ARQ-GRUPOS
               OPEN I-O           ARQ-GRUPOS
           END-IF.           
      *>---------------------------------------------------------------*
      *> Fecha arquivo de grupos de produtos
       FECHAR-ARQUIVO.
           CLOSE                  ARQ-GRUPOS.           
      *>---------------------------------------------------------------*
      *>-> Le grupo de produto por codigo
       LE-GRUPO.     
           READ ARQ-GRUPOS KEY IS GRP-CODIGO.
      *>---------------------------------------------------------------*
       RE-GRAVA-GRUPO.
      *>-> Grava ou regrava registro de grupo de produto     
           WRITE                  REG-GRUPO.
           IF FS-GRUPOS = "00"
               EXIT PARAGRAPH
           ELSE IF FS-GRUPOS = "22"
               REWRITE            REG-GRUPO
               IF FS-GRUPOS = "00"
                  EXIT PARAGRAPH
               END-IF
           END-IF.
      *>---------------------------------------------------------------*
       DESENHAR-TELA.
           DISPLAY                TELA-LIMPA     
           DISPLAY                TELA-BASE
           ACCEPT                 TELA-OPCAO.

      *>---------------------------------------------------------------*
