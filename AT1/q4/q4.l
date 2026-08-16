%{
#include <stdio.h>
#include <stdlib.h>

extern FILE *yyin;
%}

%option noyywrap

%%

"//".*                  
"if"                    { printf("IF\n"); }
"else"                  { printf("ELSE\n"); }
"while"                 { printf("WHILE\n"); }
"return"                { printf("RETURN\n"); }

[a-zA-Z_][a-zA-Z0-9_]*  { printf("ID %s\n", yytext); }
[0-9]+(\.[0-9]+)?       { printf("NUMBER %s\n", yytext); }

[=;()><]                { printf("SIMBOLO %s\n", yytext); }

[ \t\n\r]+              
.                       { printf("ERRO %s\n", yytext); }

%%

int main(int argc, char **argv) {
    
    if (argc < 2) {
        fprintf(stderr, "Erro: Informe o arquivo de entrada. Ex: %s entrada.txt\n", argv[0]);
        return 1;
    }

    
    FILE *arquivo = fopen(argv[1], "r");
    if (!arquivo) {
        fprintf(stderr, "Erro: Nao foi possivel abrir o arquivo '%s'.\n", argv[1]);
        return 2;
    }

    
    yyin = arquivo;

    yylex();

    fclose(arquivo);
    return 0;
}
