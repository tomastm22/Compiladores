%{
#include "calc.tab.h"
#include <stdlib.h>
#include <string.h>
%}

%option noyywrap

%%
"printar_variaveis" { return PRINT_VARS; }
">>>"               { return ATRIB; }
"**"                { return POT; }
"+"                 { return '+'; }
"-"                 { return '-'; }
"*"                 { return '*'; }
"/"                 { return '/'; }
"("                 { return '('; }
")"                 { return ')'; }

[0-9]+(\.[0-9]+)?   { yylval.val = atof(yytext); return NUM; }
[a-zA-Z_][a-zA-Z0-9_]* { yylval.name = strdup(yytext); return ID; }

[ \t]+              { }
\n                  { return '\n'; }
.                   { return yytext[0]; }
%%