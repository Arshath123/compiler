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

"char" { return CHAR ; }
"int"       { return INT ; }
"float"     { return FLOAT ; }
"double"    { return DOUBLE; }

";"      { return SEMICOLON;} 
","      { return COMMA; }
"="      { return ASSIGN; }

"["   {return SOBRAC;}
"]"   {return SCBRAC;}

"*"   {return POINTER;}


{ID}         { return ID; }
{ICONST}     { return ICONST; }
{FCONST}     { return FCONST; }



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

"\n"		    ; 
[ \t\r\f]+	   ;
.		   ;

%%
