CC = cc
CFLAGS += -g -Wall
PROGRAM = start-stop-daemon
SOURCES = start-stop-daemon.c

$(PROGRAM): $(SOURCES)
	$(CC) $(CFLAGS) -o $(@) $(SOURCES)


all:	$(PROGRAM)
clean:	; rm -f $(PROGRAM)
force: clean all
