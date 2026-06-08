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
       DATA DIVISION.
       FILE SECTION.
      *>---------------------------------------------------------------*
       WORKING-STORAGE SECTION.     
       01 WS-TECLA                PIC X  VALUE SPACES.
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
          05 LINE  7 COL  2 VALUE
             "-- MANUTENCAO DE GRUPOS DE PRODUTOS".
          05 LINE  8 COL  1 VALUE
             "                                                  ".
          05 LINE  9 COL  2 VALUE "Codigo    :".
          05 LINE 10 COL  2 VALUE "Descricao :".
          05 LINE 11 COL  2 VALUE "Ativo(S/N):".
          05 LINE 12 COL  1 VALUE
             "--------------------------------------------------".
          05 LINE  7 COL  2 VALUE
             "-- MANUTENCAO DE GRUPOS DE PRODUTOS".
          05 LINE  8 COL  1 VALUE
             "                                                  ".
          05 LINE  9 COL  2 VALUE "Codigo    :".
          05 LINE 10 COL  2 VALUE "Descricao :".
          05 LINE 11 COL  2 VALUE "Ativo(S/N):".
          05 LINE 12 COL  1 VALUE
             "--------------------------------------------------".
      *>---------------------------------------------------------------*
       PROCEDURE DIVISION.
      *>---------------------------------------------------------------*
       INICIO.
           PERFORM DESENHAR-TELA
           EXIT PROGRAM.
      *>---------------------------------------------------------------*
       DESENHAR-TELA.
           DISPLAY TELA-LIMPA
           DISPLAY TELA-BASE
           ACCEPT WS-TECLA AT LINE 14 COL 2
           DISPLAY "Pressione qualquer tecla para voltar ao menu..." 
                   AT LINE 14 COL 2.
      *>---------------------------------------------------------------*
