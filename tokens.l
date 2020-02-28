%{

%}

%option noyywrap
%x IN_COMMENT

alpha      [a-zA-Z]
digit      [0-9]
alnum      {alpha}|{digit}

ID         {alpha}{alnum}*
ICONST     [0-9]{digit}*
FCONST     {digit}+"."{digit}+

%%

	/*..........DATATYPES..........*/
"char"      { return CHAR ; }
"int"       { return INT ; }
"float"     { return FLOAT ; }
"double"    { return DOUBLE; }

	/*..........CONDITIONAL KEYWORDS..........*/
"else if"   {return ELSEIF;}
"else"      {return ELSE;}
"if"        {return IF;}

	
";"      { return SEMICOLON;} 
","      { return COMMA; }
"="      { return ASSIGN; }
	/*..........LOOP KEYWORDS..........*/

"for"	{return FOR;}
"while"	{return WHILE;}
"do"	{return DO;}

	/*..........ARITHMETIC OPERATORS..........*/
"+"      {return PLUS;}
"-"      {return MINUS;}
"/"      {return DIVIDE;}
"%"		{return MOD;}
"++"     {return INC;}
"--"     {return DEC;}

	/*..........BOOLEAN OPERATORS..........*/
"||"     {return OR;}
"&&"     {return AND;}
"!"     {return NOT;}
"|"		{return BOR;}
"&" 	{return BAND;}
"~"		{return BNOT;}
"^"		{return XOR;}
"<<"	{return BLSHIFT;}
">>"	{return BRSHIFT;}
	/*..........CONDITIONAL OPERATORS..........*/
"=="     {return EQ;}
"!="     {return NEQ;}
"<"     {return LT;}
">"     {return GT;}
"<="     {return LTE;}
">="     {return GTE;}

	/*..........DATATYPES..........*/
"["     {return SOBRAC;}
"]"     {return SCBRAC;}
"("     {return ROBRAC;}
")"     {return RCBRAC;}
"{"     {return COBRAC;}
"}"     {return CCBRAC;}

"*"   {return POINTER;}


{ID}         { return ID; }
{ICONST}     { return ICONST; }
{FCONST}     { return FCONST; }

	/**/

"//".*   { ;}

<INITIAL>{

"/*"      BEGIN(IN_COMMENT);

}
<IN_COMMENT>{

"*/"      BEGIN(INITIAL);
[^*\n]+   ;
"*"       ;
\n        ;

}

"\n"	; 
[ \t\r\f]+	   ;
.		   ;

%%
