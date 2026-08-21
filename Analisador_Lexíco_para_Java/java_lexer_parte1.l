%{
#include <stdio.h>
#include <stdlib.h>
%}

%option noyywrap

%x COMENTARIO_BLOCO

%%

"//".*                  
"/*"                    { BEGIN(COMENTARIO_BLOCO); }
<COMENTARIO_BLOCO>"*/"  { BEGIN(INITIAL); }
<COMENTARIO_BLOCO>.|\n  

"public"                { printf("PUBLIC\n"); }
"private"               { printf("PRIVATE\n"); }
"protected"             { printf("PROTECTED\n"); }
"class"                 { printf("CLASS\n"); }
"static"                { printf("STATIC\n"); }
"void"                  { printf("VOID\n"); }
"return"                { printf("RETURN\n"); }
"if"                    { printf("IF\n"); }
"else"                  { printf("ELSE\n"); }
"while"                 { printf("WHILE\n"); }
"for"                   { printf("FOR\n"); }
"new"                   { printf("NEW\n"); }

"int"                   { printf("TYPE_INT\n"); }
"float"                 { printf("TYPE_FLOAT\n"); }
"double"                { printf("TYPE_DOUBLE\n"); }
"char"                  { printf("TYPE_CHAR\n"); }
"true"                  { printf("TYPE_BOLEAN %s\n", yytext); }
"false"                 { printf("TYPE_BOLEAN %s\n", yytext); }
"null"                  { printf("TYPE_NULL\n"); }

"=="                    { printf("OPERADOR_RELACIONAL ==\n"); }
"!="                    { printf("OPERADOR_RELACIONAL !=\n"); }
"<="                    { printf("OPERADOR_RELACIONAL <=\n"); }
">="                    { printf("OPERADOR_RELACIONAL >=\n"); }

"["                     { printf("COLCHETE_INICIO\n"); }
"]"                     { printf("COLCHETE_FIM\n"); }
"("                     { printf("PARENTESE_INICIO\n"); }
")"                     { printf("PARENTESE_FIM\n"); }
"{"                     { printf("CHAVE_INICIO\n"); }
"}"                     { printf("CHAVE_FIM\n"); }

[0-9]+\.[0-9]+          { printf("NUMERO_DECIMAL %s\n", yytext); }
[0-9]+                  { printf("NUMERO_INTEIRO %s\n", yytext); }
[a-zA-Z_$][a-zA-Z0-9_$]* { printf("IDENTIFICADOR %s\n", yytext); }

[ \t\n]+                /* Ignora espaços, tabs e quebras de linha */
.                       { printf("ERRO %s\n", yytext); }

%%

int main(void) {
    yylex();
    return 0;
}