PREFIX ?= /usr/local
MANPREFIX ?= ${PREFIX}/man
CC ?= cc
CFLAGS += -Wall
LDFLAGS += 

all: entr

test: entr_spec entr
	@/bin/echo "Running unit tests"
	@./entr_spec

regress:
	@/bin/echo -n "Running functional tests"
	@./regress.sh

debug: entr_spec
	gdb -q entr_spec

entr: entr.c
	${CC} ${CFLAGS} entr.c -o $@ ${LDFLAGS}
	@chmod +x $@

entr_spec: entr.c entr_spec.c
	${CC} ${CFLAGS} entr_spec.c -o $@ ${LDFLAGS}
	@chmod +x $@

clean:
	rm -rf entr entr_spec *.o

install:
	install entr ${PREFIX}/bin/
	install entr.1 ${MANPREFIX}/man1/

uninstall:
	rm ${PREFIX}/bin/entr
	rm ${MANPREFIX}/man1/entr.1

