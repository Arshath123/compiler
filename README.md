This is a basic C compiler using lex and bison

Runing the tokens.l file:

flex tokens.l

gcc lex.yy.c -o lexer -lfl

./lexer test.c