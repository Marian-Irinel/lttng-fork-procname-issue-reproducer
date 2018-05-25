CC=gcc
CFLAGS=-I$(IDIR)

SDIR=src
IDIR =src/include

LIBS=-ldl -llttng-ust -L/usr/local/lib

_DEPS = hello-tp.h
DEPS = $(patsubst %,$(IDIR)/%,$(_DEPS))

_OBJ = hello-tp.o test.o 
OBJ = $(patsubst %,$(SDIR)/%,$(_OBJ))


$(SDIR)/%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

test: $(OBJ)
	gcc -o $@ $^ $(CFLAGS) $(LIBS)

.PHONY: clean

clean:
	rm -f $(SDIR)/*.o test
