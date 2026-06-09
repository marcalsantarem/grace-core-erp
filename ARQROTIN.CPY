      *>---------------------------------------------------------------*
      *> Copy padrão de rotinas para arquivos de dados                 *
      *>---------------------------------------------------------------*
      *>-> Abre arquivo. Se nao existir, cria um novo arquivo vazio
       XOPEN.
           OPEN I-O               XARQARQ
           IF XFSNE
               OPEN OUTPUT        XARQARQ
               CLOSE              XARQARQ
               OPEN I-O           XARQARQ
           END-IF.
      *>---------------------------------------------------------------*
      *>-> Fecha arquivo
       XCLOSE.
           CLOSE                  XARQARQ.
      *>---------------------------------------------------------------*
      *>-> Le registro na chave principal
       XREAD.
           READ XARQARQ KEY IS XKEY.
      *>---------------------------------------------------------------*
      *>-> Grava ou regrava registro
       XREWRITE.
           WRITE                  XREG.
           IF XFSOK
               EXIT PARAGRAPH
           ELSE IF XFSDUP
               REWRITE            XREG
           END-IF.
      *>---------------------------------------------------------------*
      *>-> Exclui registro
       XDELETE.
           DELETE                 XARQARQ.
      *>---------------------------------------------------------------*
           