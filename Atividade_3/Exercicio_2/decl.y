%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex(void);
void yyerror(const char *s);
extern FILE *yyin;

char *symtab[100];
int total_vars = 0;

int var_exists(const char *name) {
    for (int i = 0; i < total_vars; i++) {
        if (strcmp(symtab[i], name) == 0) return 1;
    }
    return 0;
}

void add_var(const char *tipo, const char *name) {
    if (var_exists(name)) {
        printf("erro: %s já foi declarada\n", name);
    } else {
        printf("%s %s\n", tipo, name);
        symtab[total_vars] = strdup(name);
        total_vars++;
    }
}
%}

%union {
    char *name;
}

%token <name> TIPO ID
%type <name> tipo

%%
programa : declaracoes { printf("+++++ %d variáveis declaradas\n", total_vars); }
         ;

declaracoes : 
            | declaracoes declaracao
            ;

declaracao : tipo lista_ids ';' { free($1); }
           ;

tipo : TIPO { $$ = $1; }
     ;

lista_ids : ID                  { add_var($<name>0, $1); free($1); }
          | lista_ids ',' ID    { add_var($<name>0, $3); free($3); }
          ;

%%

void yyerror(const char *s) {}

int main(int argc, char **argv) {
    if (argc > 1) yyin = fopen(argv[1], "r");
    return yyparse();
}