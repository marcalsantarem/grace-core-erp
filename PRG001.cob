      *>---------------------------------------------------------------*
      *> PRG001.COB - PROGRAMA PRINCIPAL                               *
      *>---------------------------------------------------------------*
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PRG001.
       AUTHOR. MARCAL SANTAREM.
      *>---------------------------------------------------------------*
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.
      *>---------------------------------------------------------------*
       DATA DIVISION.
       FILE SECTION.
      *>---------------------------------------------------------------*
       WORKING-STORAGE SECTION.
       01 WS-OPCAO             PIC X(1)  VALUE SPACES.
       01 WS-CONTINUAR         PIC X(1)  VALUE 'S'.
      *>---------------------------------------------------------------*
       SCREEN SECTION.
      *>---------------------------------------------------------------*
       01 TELA-LIMPA
          BLANK SCREEN.
      *>---------------------------------------------------------------*
       01 TELA-BASE.           
          COPY                    TELAHEAD.CPY.
          05 LINE  6 COL  1 VALUE
             "                                                  ".
          05 LINE  7 COL  2 VALUE "Selecione uma opcao do menu:".
          05 LINE  8 COL  1 VALUE
             "                                                  ".
          05 LINE  9 COL  3 VALUE "1 - Modulo 1".
          05 LINE 10 COL  3 VALUE "0 - Sair".
          05 LINE 11 COL  1 VALUE
             "                                                  ".             
      *>---------------------------------------------------------------*
       01 TELA-CAMPOS.
          05 LINE  7 COL 31
             PIC X(1)     USING WS-OPCAO
             FOREGROUND-COLOR 14 HIGHLIGHT.
      *>---------------------------------------------------------------*
       PROCEDURE DIVISION.
      *>---------------------------------------------------------------*
       INICIO.
           PERFORM MENU-PRINCIPAL UNTIL WS-CONTINUAR = 'N'
           STOP RUN.   
      *>---------------------------------------------------------------*
      *> MENU PRINCIPAL                                                *
      *>---------------------------------------------------------------*
       MENU-PRINCIPAL.
           PERFORM                IMPRIME-MENU.
           ACCEPT TELA-CAMPOS.
           
           EVALUATE WS-OPCAO
              WHEN "1"
                 CALL "MANGRP"
                 CANCEL "MANGRP"
              WHEN "0"
                 MOVE 'N' TO WS-CONTINUAR
              WHEN OTHER
                 DISPLAY "Opcao invalida." AT LINE 14 COL 2
                   CALL "SYSTEM" USING "PAUSE"
           END-EVALUATE.
           MOVE SPACES TO WS-OPCAO.
      *>---------------------------------------------------------------*
       IMPRIME-MENU.           
           DISPLAY TELA-LIMPA
           DISPLAY TELA-BASE.
      *>---------------------------------------------------------------*
      