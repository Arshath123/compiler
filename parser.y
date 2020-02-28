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
%token FOR WHILE

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


%nonassoc LOWER
%nonassoc ELSE
%nonassoc ELSEIF

%define parse.error verbose

%start program
%%

program:   statements;

statements:  statements statement | ;

statement:     simple_statement 
        |       complex_statement;

complex_statement: COBRAC statements CCBRAC;

simple_statement: if_statement 
        |       for_statement
        |       declaration SEMICOLON
        |       assignment SEMICOLON 
        |       unary SEMICOLON
        |       ICONST SEMICOLON
        |       SEMICOLON;

declaration: type name;

name: name COMMA declare | declare;

declare: assignment | variables ;
	
type: INT | FLOAT | CHAR | DOUBLE;

if_statement:   IF ROBRAC multi_exp RCBRAC statement if_body;

if_body:        ELSE statement
        |       ELSEIF ROBRAC multi_exp RCBRAC statement %prec LOWER
        |       ELSEIF ROBRAC multi_exp RCBRAC statement ELSE statement
        |       %prec LOWER;

for_statement: FOR ROBRAC expression_statement expression_statement multi_exp RCBRAC statement
        |      FOR ROBRAC expression_statement expression_statement assignment RCBRAC statement
        |      FOR ROBRAC expression_statement expression_statement RCBRAC statement;

assignment: variables ASSIGN multi_exp;

expression_statement: assignment SEMICOLON
        |       multi_exp SEMICOLON
        |       SEMICOLON ;

multi_exp: multi_exp COMMA expression
        |       expression;

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

multi_dim: array 
        | ;

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
