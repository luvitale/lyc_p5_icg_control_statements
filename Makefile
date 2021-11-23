CC=gcc

ifeq ($(OS),Windows_NT)
	LEX=win_flex
	BISON=win_bison
	EXT=exe
else
	LEX=flex
	BISON=bison
	EXT=app
endif

all: 1.app

1.app: 1.yy.c 1.tab.c rpn.c
	$(CC) -o 1.$(EXT) $? -fcommon

%.yy.c: %.l
	$(LEX) -o $@ $<

%.tab.c: %.y
	$(BISON) -o $@ -dyv $<

test-%: %.app
	./$*.$(EXT) ./test/$*/code.txt

test: test-1

clean:
	rm -f *.yy.* *.app *.tab.* *.output
