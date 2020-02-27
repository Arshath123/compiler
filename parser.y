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
%token PLUS MINUS DIVIDE INC DEC MOD
%token OR AND NOT BOR BAND BNOT XOR BLSHIFT BRSHIFT
%token EQ NEQ LT LTE GT GTE

%left COMMA
%left OR 
%left AND
%left BOR
%left XOR
%left BAND
%left EQ NEQ
%left LT LTE GT GTE
%left BLSHIFT BRSHIFT
%left PLUS MINUS
%left POINTER DIVIDE MOD

%right INC DEC
%right BNOT NOT
%right ASSIGN

%define parse.error verbose

%start program
%%

program:    program statement SEMICOLON;
    |       

statement: declaration | assignment | unary | ICONST;

declaration: type name;

name: name COMMA declare | declare;

declare: assignment | variables ;
	
type: INT | FLOAT | CHAR | DOUBLE;

assignment: variables ASSIGN expression;

expression: expression PLUS expression 
    |       expression MINUS expression    
    |       expression DIVIDE expression
    |       expression POINTER expression
    |       expression MOD expression
    |       expression OR expression
    |       expression AND expression
    |       expression EQ expression
    |       expression NEQ expression
    |       expression LT expression
    |       expression LTE expression
    |       expression GTE expression
    |       expression GT expression
    |       BOR expression
    |       BAND expression
    |       expression XOR expression
    |       BNOT expression
    |       NOT expression 
    |       expression BLSHIFT expression
    |       expression BRSHIFT expression
    |       ROBRAC expression RCBRAC
    |       INC expression
    |       expression INC
    |       DEC expression
    |       expression DEC
    |       MINUS variables
    |       ICONST
    |       variables;

unary:      unary INC
    |       INC unary
    |       DEC unary
    |       unary DEC
    |       variables
    ;

variables:
        ID multi_dim
        | pointer ID multi_dim;

multi_dim: array | ;

pointer: pointer POINTER | POINTER;

array: array array_dim | array_dim;

array_dim: SOBRAC ICONST SCBRAC;


%%


#include"lex.yy.c"
int main(){
    return yyparse();
}
void yyerror(const char*s)
{
        fprintf(stderr,"%s\n",s);
}
