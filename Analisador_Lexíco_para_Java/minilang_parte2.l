%option noyywrap
%option yylineno

%{
#include <stdio.h>
#include <stdlib.h> 
%}


%x COMENTARIO
%x STRING_ESTADO

%%


"{\---" {
    BEGIN(COMENTARIO);
}

<COMENTARIO>"\---}" {
    BEGIN(INITIAL);
}

<COMENTARIO>\n {
    /* ignora quebras de linha dentro do comentario */
}

<COMENTARIO>. {
    /* ignora qualquer outro caractere do comentario */
}



"'" {
    BEGIN(STRING_ESTADO);
}

<STRING_ESTADO>"'" {
    BEGIN(INITIAL);
}

<STRING_ESTADO>\n {
    printf("LINHA %d: ERRO_LEXICO (String nao fechada)\n", yylineno);
    BEGIN(INITIAL);
}

<STRING_ESTADO>[^'\n]+ {
    printf("LINHA %d: STRING (%s)\n", yylineno, yytext);
}



"#coment".* { /* ignora comentario de linha */ }



"inicio"                { printf("LINHA %d: INICIO (%s)\n", yylineno, yytext); }
"fim"                   { printf("LINHA %d: FIM (%s)\n", yylineno, yytext); }
"inteiro"               { printf("LINHA %d: INTEIRO (%s)\n", yylineno, yytext); }
"real"                  { printf("LINHA %d: REAL (%s)\n", yylineno, yytext); }
"texto"                 { printf("LINHA %d: TEXTO (%s)\n", yylineno, yytext); }
"booleano"              { printf("LINHA %d: BOOLEANO (%s)\n", yylineno, yytext); }
"se"                    { printf("LINHA %d: SE (%s)\n", yylineno, yytext); }
"faz"                   { printf("LINHA %d: FAZ (%s)\n", yylineno, yytext); }
"senao"                 { printf("LINHA %d: SENAO (%s)\n", yylineno, yytext); }
"repita_enquanto"       { printf("LINHA %d: REPITA_ENQUANTO (%s)\n", yylineno, yytext); }
"para"                  { printf("LINHA %d: PARA (%s)\n", yylineno, yytext); }
"de"                    { printf("LINHA %d: DE (%s)\n", yylineno, yytext); }
"ate"                   { printf("LINHA %d: ATE (%s)\n", yylineno, yytext); }
"faca"                  { printf("LINHA %d: FACA (%s)\n", yylineno, yytext); }
"leia"                  { printf("LINHA %d: LEIA (%s)\n", yylineno, yytext); }
"mostre"                { printf("LINHA %d: MOSTRE (%s)\n", yylineno, yytext); }
"sim"                   { printf("LINHA %d: SIM (%s)\n", yylineno, yytext); }
"nao"                   { printf("LINHA %d: NAO (%s)\n", yylineno, yytext); }
"retorne"               { printf("LINHA %d: RETORNE (%s)\n", yylineno, yytext); }
"funcao"                { printf("LINHA %d: FUNCAO (%s)\n", yylineno, yytext); }


"=="                    { printf("LINHA %d: RELACIONAIS_IGUAL (%s)\n", yylineno, yytext); }
"!="                    { printf("LINHA %d: RELACIONAIS_DIFERENCA (%s)\n", yylineno, yytext); }
"<="                    { printf("LINHA %d: RELACIONAIS_MENORIGUAL (%s)\n", yylineno, yytext); }
">="                    { printf("LINHA %d: RELACIONAIS_MAIORIGUAL (%s)\n", yylineno, yytext); }
"&&"                    { printf("LINHA %d: LOGICOS_AND (%s)\n", yylineno, yytext); }
"||"                    { printf("LINHA %d: LOGICOS_OR (%s)\n", yylineno, yytext); }
"+"                     { printf("LINHA %d: ARITMETICO_SOMA (%s)\n", yylineno, yytext); }
"-"                     { printf("LINHA %d: ARITMETICO_SUBTRACAO (%s)\n", yylineno, yytext); }
"*"                     { printf("LINHA %d: ARITMETICO_MULTIPLICACAO (%s)\n", yylineno, yytext); }
"/"                     { printf("LINHA %d: ARITMETICO_DIVISAO (%s)\n", yylineno, yytext); }
"%"                     { printf("LINHA %d: ARITMETICO_RESTO (%s)\n", yylineno, yytext); }
"<"                     { printf("LINHA %d: RELACIONAIS_MENORQUE (%s)\n", yylineno, yytext); }
">"                     { printf("LINHA %d: RELACIONAIS_MAIORQUE (%s)\n", yylineno, yytext); }
"!"                     { printf("LINHA %d: LOGICOS_NOT (%s)\n", yylineno, yytext); }
"="                     { printf("LINHA %d: ATRIBUICAO (%s)\n", yylineno, yytext); }


"("                     { printf("LINHA %d: DELIMITADOR_LPAREN (%s)\n", yylineno, yytext); }
")"                     { printf("LINHA %d: DELIMITADOR_RPAREN (%s)\n", yylineno, yytext); }
"["                     { printf("LINHA %d: DELIMITADOR_LBRACKET (%s)\n", yylineno, yytext); }
"]"                     { printf("LINHA %d: DELIMITADOR_RBRACKET (%s)\n", yylineno, yytext); }
"{"                     { printf("LINHA %d: DELIMITADOR_LBRACE (%s)\n", yylineno, yytext); }
"}"                     { printf("LINHA %d: DELIMITADOR_RBRACE (%s)\n", yylineno, yytext); }
";"                     { printf("LINHA %d: DELIMITADOR_PONTOVIRGULA (%s)\n", yylineno, yytext); }
"$"                     { printf("LINHA %d: DELIMITADOR_CIFRAO (%s)\n", yylineno, yytext); }

[a-zA-Z_][a-zA-Z0-9_]*  { printf("LINHA %d: ID (%s)\n", yylineno, yytext); }
[0-9]+,[0-9]+           { printf("LINHA %d: REAL (%s)\n", yylineno, yytext); }
[0-9]+                  { printf("LINHA %d: INTEGER (%s)\n", yylineno, yytext); }



[ \t\n\r]+              { /* ignora espacos, tabs e newlines */ }
.                       { printf("LINHA %d: ERRO_LEXICO (%s)\n", yylineno, yytext); }

%%

int main(int argc, char **argv) {
    if (argc < 2) {
        fprintf(stderr, "Erro: Uso correto: %s <nome_do_arquivo_entrada>\n", argv[0]);
        exit(1);
    }

    FILE *arquivo = fopen(argv[1], "r");
    if (!arquivo) {
        fprintf(stderr, "Erro: Nao foi possivel abrir o arquivo '%s'.\n", argv[1]);
        exit(1);
    }

    yyin = arquivo;
    yylex();

    fclose(arquivo); 
    return 0;
}