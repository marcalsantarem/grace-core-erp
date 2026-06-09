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
       01 XFSARQ                  PIC X(02) VALUE "00".
          88 XFSOK                          VALUE "00".
          88 XFSDUP                         VALUE "22".
          88 XFSNF                          VALUE "23".
          88 XFSNE                          VALUE "35".
          88 XFSEOF                         VALUE "10".
      *>---------------------------------------------------------------*
          