%option noyywrap

%{
   #include <stdio.h>
   #include <stdlib.h>
   #include <string.h>
   int lineno = 1;
   void yyerror();
   void response(char*);
%}


%x IN_COMMENT

alpha      [a-zA-Z]
digit      [0-9]
alnum      {alpha}|{digit}

ID         {alpha}{alnum}*
ICONST     [0-9]{digit}*
FCONST     {digit}+"."{digit}+

%%

"char"      { response("KEYWORD_CHAR"); }
"int"       { response("KEYWORD_INT"); }
"float"     { response("KEYWORD_FLOAT"); }
"double"    { response("KEYWORD_DOUBLE"); }
"if"        { response("KEYWORD_IF"); }
"else"      { response("KEYWORD_ELSE"); }
"while"	    { response("KEYWORD_WHILE"); }
"for"	    { response("KEYWORD_FOR"); }
"continue"  { response("KEYWORD_CONTINUE"); }
"break"     { response("KEYWORD_BREAK"); }
"void"      { response("KEYWORD_VOID"); }
"return"    { response("KEYWORD_RETURN"); }


"+"|"-"             { response("ADDOP/SUBOP"); }
"*"	                { response("MULOP"); }
"/"	                { response("DIVOP"); }
"++"|"--"           { response("INCR"); }
"||"                { response("OROP"); }
"&&"	            { response("ANDOP"); }
"!"	                { response("NOTOP"); }
"=="|"!="           { response("EQUOP"); }
">"|"<"|">="|"<="   { response("RELOP"); }


"("      { response("LPAREN"); }
")"      { response("RPAREN"); }
"]"      { response("LBRACK"); }
"["      { response("RBRACK"); }
"{"      { response("LBRACE"); }
"}"      { response("RBRACE"); }
";"      { response("SEMI"); }
"."      { response("DOT"); }
","      { response("COMMA"); }
"="      { response("ASSIGN"); }
"&"      { response("REFER"); }

"//".*   { ;}

<INITIAL>{

"/*"      BEGIN(IN_COMMENT);

}
<IN_COMMENT>{

"*/"      BEGIN(INITIAL);
[^*\n]+   ;
"*"       ;
\n        {lineno += 1;};

}

{ID}         { response("ID"); }
{ICONST}     { response("ICONST"); }
{FCONST}     { response("FCONST"); }


"\n"		   { lineno += 1; }
[ \t\r\f]+	   ;
.		   { yyerror("Unrecognized character"); }

%%

void yyerror(char *message){
   printf("Error: %s in line %d Token = %s\n", message, lineno, yytext);
   exit(1);
}

void response(char *token_type){
   printf("yytext: %s \t token: %s \t lineno: %d\n", yytext, token_type, lineno);
}

int main(int argc, char *argv[]){
   yyin = fopen(argv[1], "r");
   yylex();
   fclose(yyin);
   return 0;
}