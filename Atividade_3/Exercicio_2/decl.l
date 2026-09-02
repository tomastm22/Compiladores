%{
#include "decl.tab.h"
#include <string.h>
%}

%option noyywrap

%%
"int"       { yylval.name = strdup(yytext); return TIPO; }
"double"    { yylval.name = strdup(yytext); return TIPO; }
"char"      { yylval.name = strdup(yytext); return TIPO; }

[a-zA-Z_][a-zA-Z0-9_]* { yylval.name = strdup(yytext); return ID; }

","         { return ','; }
";"         { return ';'; }
[ \t\n]+    { }
.           { return yytext[0]; }
%%