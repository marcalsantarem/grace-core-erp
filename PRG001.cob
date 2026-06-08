      *>---------------------------------------------------------------*
      *> PRG001.COB - PROGRAMA PRINCIPAL                               *
      *> Menu de acesso aos modulos do sistema                         *
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
       PROCEDURE DIVISION.
      *----------------------------------------------------------------*
       INICIO.
           PERFORM MENU-PRINCIPAL UNTIL WS-CONTINUAR = 'N'
           STOP RUN.
      *>---------------------------------------------------------------*
      *> MENU PRINCIPAL                                                *
      *>---------------------------------------------------------------*
       MENU-PRINCIPAL.
           PERFORM                IMPRIME-MENU.        
           DISPLAY "Opcao: " WITH NO ADVANCING
           ACCEPT WS-OPCAO
           
           EVALUATE WS-OPCAO
              WHEN "1"
                 DISPLAY "Modulo 1 selecionado."
              WHEN "0"
                 DISPLAY "Saindo do sistema..."
                 MOVE 'N' TO WS-CONTINUAR
              WHEN OTHER
                 DISPLAY "Opcao invalida."
           END-EVALUATE.
           CALL "SYSTEM" USING "PAUSE".
      *>---------------------------------------------------------------*
       IMPRIME-MENU.
           CALL "SYSTEM" USING "cls"
           PERFORM                LINHA-TRACEJADA
           PERFORM                LINHA-EM-BRANCO
           DISPLAY "-                  Bem Vindo ao                  -"
           DISPLAY "-                 Grace Core ERP                 -"
           PERFORM                LINHA-EM-BRANCO
           PERFORM                LINHA-TRACEJADA

           PERFORM                LINHA-VAZIA
           DISPLAY "- Selecione uma opcao do menu:"
           PERFORM                LINHA-VAZIA
           DISPLAY "  1 - Módulo 1"
           PERFORM                LINHA-VAZIA
           DISPLAY "  0 - Sair"
           PERFORM                LINHA-VAZIA.     
      *>---------------------------------------------------------------*
           COPY                   TELAUTIL.cpy.
      *>---------------------------------------------------------------*
      