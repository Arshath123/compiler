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
%token ROBRAC RCBRAC COBRAC CCBRAC SOBRAC SCBRAC
%token POINTER
%token IF ELSEIF ELSE
%token PLUS MINUS DIVIDE INC DEC
%token OR AND NOT
%token EQ NEQ LT LTE GT GTE

%define parse.error verbose

%start program
%%

program : declarations;

declarations : declarations declaration | declaration;

declaration : type name SEMICOLON ;

name : name COMMA declare | declare;

declare : variables ASSIGN expression | variables ;

type : CHAR | INT | FLOAT | DOUBLE;
	
pointer : pointer POINTER | POINTER;

array : array array_dim | array_dim ;

array_dim : SOBRAC ICONST SCBRAC;


variables : ID 
        | pointer ID ;
        | ID array;



expression :   expression operation variables 
	|	
                variables INC 
        |
                variables DEC
        |
                INC variables 
        |
                DEC variables 
        |
                NOT variables  
	|
		ROBRAC expression RCBRAC
	| 	
		variables
        | 
                ICONST
;

operation : PLUS | MINUS | POINTER | DIVIDE | OR | AND | NOT | EQ | NEQ | LT | GT | LTE | GTE

;


%%


#include"lex.yy.c"
int main(){
    return yyparse();
}
void yyerror(const char*s)
{
        fprintf(stderr,"%s\n",s);
}
