# Clean Makefile for ECPS203
# 11/01/18 ZC  adjusted for ECPS 203, Fall'18
# 12/14/17 ZC  adjusted for ECPS 203, Fall'17
# 10/24/17 RD  adjusted for ECPS 203, Fall'17

SYSTEMC = /opt/pkg/systemc-2.3.1

INCLUDE = -I. -I$(SYSTEMC)/include
LIBRARY = $(SYSTEMC)/lib-linux64
SYSC_CFLAG = $(INCLUDE) -L$(LIBRARY) -Xlinker -R -Xlinker $(LIBRARY) -lsystemc -O2

CC = g++
RM = rm -f

VIDEO	= Engineering
FRAMES	= $(VIDEO)[0-9][0-9][0-9]_edges.pgm

EXE =	Canny

all: $(EXE)


clean:
	$(RM) $(EXE)
	$(RM) *.bak *~
	$(RM) *.o *.ti gmon.out
	$(RM) $(IMG_OUT)
	$(RM) $(FRAMES)

cleanall: clean
	$(RM) *.log

	
# Assignment 5 
# Test bench model in SystemC

Canny: Canny.cpp
	$(CC) $(SYSC_CFLAG) $< -o $@

test: Canny video/$(FRAMES)
	ulimit -s 128000; ./$<
	set -e; \
	for f in video/$(FRAMES); do \
		diff `basename $$f` $$f; \
	done

# EOF
