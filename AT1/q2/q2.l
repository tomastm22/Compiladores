%{
#include <stdio.h>
%}

%option noyywrap

%%

"+"         { printf("PLUS\n"); }
"-"         { printf("MINUS\n"); }
"*"         { printf("TIMES\n"); }
"/"         { printf("DIVIDE\n"); }
"|"         { printf("ABS\n"); }
"("         { printf("LPAREN\n"); }
")"         { printf("RPAREN\n"); }
"%"         { printf("MOD\n"); }
"^"         { printf("POWER\n"); }

"<="        { printf("REL_OP <=\n"); }
">="        { printf("REL_OP >=\n"); }
"=="        { printf("REL_OP ==\n"); }
"!="        { printf("REL_OP !=\n"); }
"<"         { printf("REL_OP <\n"); }
">"         { printf("REL_OP >\n"); }

[0-9]+      { printf("NUMBER %s\n", yytext); }
\n          { printf("NEWLINE\n"); }
[ \t]+      
.           { printf("Mystery character %s\n", yytext); }

%%

int main(void) {
    yylex();
    return 0;
}
