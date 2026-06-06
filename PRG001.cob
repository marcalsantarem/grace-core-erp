       IDENTIFICATION DIVISION.
       PROGRAM-ID. PRG001.
       AUTHOR. MARCAL SANTAREM.
      *================================================================*
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.
      *================================================================*
       DATA DIVISION.
       FILE SECTION.
      *================================================================*
       WORKING-STORAGE SECTION.
       01 WS-OPCAO             PIC X(1)  VALUE SPACES.
       01 WS-CONTINUAR         PIC X(1)  VALUE 'S'.
      *================================================================*
       PROCEDURE DIVISION.
      *----------------------------------------------------------------*
       INICIO.
           DISPLAY "Menu Principal do Sistema"
           PERFORM MENU-PRINCIPAL UNTIL WS-CONTINUAR = 'N'
           STOP RUN.
      *================================================================*
      * MENU PRINCIPAL                                                 *
      *================================================================*
       MENU-PRINCIPAL.
           CALL "SYSTEM" USING "cls"
           DISPLAY "  1 - Módulo 1"
           DISPLAY " "
           DISPLAY "  0 - Sair"
           DISPLAY " "
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
           cALL "SYSTEM" USING "PAUSE".
      *================================================================*
