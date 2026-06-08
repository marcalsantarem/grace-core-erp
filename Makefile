COBC = C:/Users/marca/AppData/Local/GnuCOBOL/bin/cobc.exe
FLAGS = -x
TARGET = PRG001
SOURCES = PRG001.cob MANGRP.cob

all: $(SOURCES)
	$(COBC) $(FLAGS) -o $(TARGET) $(SOURCES)

clean:
	del $(TARGET).exe