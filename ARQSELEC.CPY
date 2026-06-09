      *>---------------------------------------------------------------*
      *> Copy padrão de Select para arquivos de dados                  *
      *>---------------------------------------------------------------*
           SELECT XARQ-ARQ        ASSIGN TO XARQNOM
                                  ORGANIZATION IS INDEXED
                                  ACCESS MODE IS DYNAMIC
                                  RECORD KEY IS XARQKEY
                                  FILE STATUS IS XARQ-FS.
      *>---------------------------------------------------------------*
       