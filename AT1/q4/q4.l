%{
#include <stdio.h>
#include <stdlib.h>

extern FILE *yyin;
%}

%option noyywrap

%%

"//".*                  /* ignora comentarios de linha */
"if"                    { printf("IF\n"); }
"else"                  { printf("ELSE\n"); }
"while"                 { printf("WHILE\n"); }
"return"                { printf("RETURN\n"); }

[a-zA-Z_][a-zA-Z0-9_]*  { printf("ID %s\n", yytext); }
[0-9]+(\.[0-9]+)?       { printf("NUMBER %s\n", yytext); }

[=;()><]                { printf("SIMBOLO %s\n", yytext); }

[ \t\n\r]+              /* ignora espacos, tabulacoes e quebras de linha */
.                       { printf("ERRO %s\n", yytext); }

%%

int main(int argc, char **argv) {
    // (b) Verifica se o argumento foi passado
    if (argc < 2) {
        fprintf(stderr, "Erro: Informe o arquivo de entrada. Ex: %s entrada.txt\n", argv[0]);
        return 1;
    }

    // (a) Abre o arquivo informado
    FILE *arquivo = fopen(argv[1], "r");
    if (!arquivo) {
        fprintf(stderr, "Erro: Nao foi possivel abrir o arquivo '%s'.\n", argv[1]);
        return 2;
    }

    // Redireciona a entrada do Flex para o arquivo aberto
    yyin = arquivo;

    yylex();

    fclose(arquivo);
    return 0;
}
