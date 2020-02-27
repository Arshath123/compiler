run:
	lex tokens.l
	bison parser.y
	gcc parser.tab.c -ll 
	./a.out < test.c
