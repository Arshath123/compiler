%{
#include<stdio.h>
#include<string.h>
void yyerror(const char*);
int yylex();
%}

%token CHAR INT FLOAT DOUBLE VOID
%token SEMICOLON COMMA ASSIGN
%token ID
%token ICONST FCONST
%token ROBRAC RCBRAC COBRAC CCBRAC SOBRAC SCBRAC
%token POINTER
%token IF ELSEIF ELSE
%token PLUS MINUS DIVIDE INC DEC MOD
%token OR AND NOT BOR BAND BNOT XOR BLSHIFT BRSHIFT
%token EQ NEQ LT LTE GT GTE
%token FOR WHILE DO
%token RETURN BREAK CONTINUE

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

%start source_code
%%

source_code:    source_code program
        |       program;

program:   function | declaration SEMICOLON;

function: type ID ROBRAC arguments_with_type RCBRAC complex_statement;

return_statement: RETURN expression SEMICOLON | RETURN SEMICOLON;

function_call:  type variables ASSIGN ID ROBRAC arguments_without_type RCBRAC
        |       variables ASSIGN ID ROBRAC arguments_without_type RCBRAC
        |      ID ROBRAC arguments_without_type RCBRAC
        ;

arguments_with_type: arguments_with_type COMMA type variables
        |  type variables
        |;

arguments_without_type: arguments_without_type  COMMA variables
        |       variables
        |;

statements:  statements statement | ;

statement:     simple_statement 
        |       complex_statement;

complex_statement: COBRAC statements CCBRAC;

simple_statement: if_statement 
        |       while_statement
        |       dowhile_statement
        |       for_statement
        |       function_call SEMICOLON
        |       declaration SEMICOLON
        |       BREAK SEMICOLON
        |       CONTINUE SEMICOLON
        |       assignment SEMICOLON 
        |       unary SEMICOLON
        |       ICONST SEMICOLON
        |       return_statement
        |       SEMICOLON;

declaration: type name;

name: name COMMA declare | declare;

declare: assignment | variables ;
	
if_statement:   IF ROBRAC multi_exp RCBRAC statement if_body;

if_body:        elseif_statement 
        |       %prec LOWER;

elseif_statement: ELSEIF ROBRAC multi_exp RCBRAC statement %prec LOWER 
        |       ELSEIF ROBRAC multi_exp RCBRAC statement elseif_statement
        |       ELSE statement
        ;

for_statement: FOR ROBRAC expression_statement expression_statement multi_exp RCBRAC statement
        |      FOR ROBRAC expression_statement expression_statement assignment RCBRAC statement
        |      FOR ROBRAC expression_statement expression_statement RCBRAC statement;

while_statement: while statement;

while:          WHILE ROBRAC multi_exp RCBRAC
        |       WHILE ROBRAC assignment RCBRAC 
        ;

dowhile_statement:      DO statement while SEMICOLON;

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
        |       FCONST
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

type: INT | FLOAT | CHAR | DOUBLE | VOID;


%%


#include"lex.yy.c"
int main(){
    return yyparse();
}
void yyerror(const char*s)
{
        fprintf(stderr,"%s\n",s);
}
