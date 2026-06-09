      *>---------------------------------------------------------------*
      *> Copy padrão de File Status para arquivos de dados             *
      *>---------------------------------------------------------------*
      *> File status mais comuns:                                      *
      *>                                                               *
      *> 00 = OK                                                       *
      *> 22 = Chave duplicada (ja existe)                              *
      *> 23 = Registro nao encontrado                                  *
      *> 35 = Arquivo nao existe                                       *
      *> 10 = Fim de arquivo (EOF)                                     *
      *>---------------------------------------------------------------*
       01 XARQ-FS                 PIC X(02) VALUE "00".
          88 XARQ-OK                        VALUE "00".
          88 XARQ-DUPLICADO                 VALUE "22".
          88 XARQ-NOT-FOUND                 VALUE "23".
          88 XARQ-NOT-EXIST                 VALUE "35".
          88 XARQ-EOF                       VALUE "10".
      *>---------------------------------------------------------------*
          