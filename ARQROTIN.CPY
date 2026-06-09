      *>---------------------------------------------------------------*
      *> Copy padrão de rotinas para arquivos de dados                 *
      *>---------------------------------------------------------------*
      *>-> Abre arquivo. Se nao existir, cria um novo arquivo vazio
       OPEN-XARQ-ARQ.
           OPEN I-O               XARQ-ARQ
           IF XARQ-NOT-EXIST
               OPEN OUTPUT        XARQ-ARQ
               CLOSE              XARQ-ARQ
               OPEN I-O           XARQ-ARQ
           END-IF.
      *>---------------------------------------------------------------*
      *>-> Fecha arquivo
       CLOSE-XARQ-ARQ.
           CLOSE                  XARQ-ARQ.
      *>---------------------------------------------------------------*
      *>-> Le registro na chave principal
       READ-XARQ-ARQ.
           READ XARQ-ARQ KEY IS XARQKEY.
      *>---------------------------------------------------------------*
      *>-> Grava ou regrava registro
       RE-WRITE-XARQ-ARQ.
           WRITE                  XREG-ARQ.
           IF XARQ-OK
               EXIT PARAGRAPH
           ELSE IF XARQ-DUPLICADO
               REWRITE            XREG-ARQ
           END-IF.
      *>---------------------------------------------------------------*
      *>-> Exclui registro
       DELETE-XARQ-ARQ.
           DELETE                 XARQ-ARQ.
      *>---------------------------------------------------------------*
           