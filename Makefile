run:
	lex tokens.l
	bison parser.y
	gcc parser.tab.c 
	./a.out < test.c
