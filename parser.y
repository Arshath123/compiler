%{
#include<stdio.h>
#include<string.h>
void yyerror(const char*);
int yylex();
%}

%token CHAR INT FLOAT DOUBLE
%token SEMICOLON COMMA ASSIGN
%token ID
%token ICONST FCONST
%token SOBRAC SCBRAC
%token POINTER

%start program

%%

program : declarations {printf("\nThe program has no error\n");};

declarations : declarations declare | declare ;

declare : type name SEMICOLON ;

name : name COMMA variables | variables;

variables : ID ;
        | pointer ID ;
        | ID array;

type : CHAR | INT | FLOAT | DOUBLE;

pointer : pointer POINTER | POINTER;

array : array array_dim | array_dim ;

array_dim : SOBRAC ICONST SCBRAC;

%%


#include"lex.yy.c"
int main(){
    return yyparse();
}
void yyerror(const char*s)
{
        fprintf(stderr,"%s\n",s);
}