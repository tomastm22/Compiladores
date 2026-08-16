%{
#include <stdio.h>
%}

%option noyywrap

%%

"//".*                 
"if"                    { printf("IF\n"); }
"return"                { printf("RETURN\n"); }

[a-zA-Z_][a-zA-Z0-9_]*  { printf("ID %s\n", yytext); }
[0-9]+(\.[0-9]+)?       { printf("NUMBER %s\n", yytext); }

[=;()><]                { printf("SIMBOLO %s\n", yytext); }

[ \t\n\r]+              
.                       { printf("ERRO %s\n", yytext); }

%%

int main(void) {
    yylex();
    return 0;
}
