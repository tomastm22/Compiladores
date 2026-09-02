%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

int yylex(void);
void yyerror(const char *s);
extern FILE *yyin;

typedef struct {
    char name[50];
    double value;
} Symbol;

Symbol symtab[100];
int sym_count = 0;

double get_var(char *name) {
    for (int i = 0; i < sym_count; i++) {
        if (strcmp(symtab[i].name, name) == 0) return symtab[i].value;
    }
    return 0.0;
}

void set_var(char *name, double val) {
    for (int i = 0; i < sym_count; i++) {
        if (strcmp(symtab[i].name, name) == 0) {
            symtab[i].value = val;
            return;
        }
    }
    strcpy(symtab[sym_count].name, name);
    symtab[sym_count].value = val;
    sym_count++;
}

void print_vars() {
    for (int i = 0; i < sym_count; i++) {
        printf("%s >>> %g\n", symtab[i].name, symtab[i].value);
    }
}

%}

%union {
    double val;
    char *name;
}

%token <val> NUM
%token <name> ID
%token ATRIB PRINT_VARS
%type <val> exp

%left '+' '-'
%left '*' '/'
%right POT
%nonassoc NEG

%%
linhas :
       | linhas linha
       ;

linha : '\n'
      | exp '\n'                  { printf("= %g\n", $1); }
      | ID ATRIB exp '\n'         { set_var($1, $3); free($1); }
      | PRINT_VARS '\n'           { print_vars(); }
      ;

exp : NUM                         { $$ = $1; }
    | ID                          { $$ = get_var($1); free($1); }
    | exp '+' exp                 { $$ = $1 + $3; }
    | exp '-' exp                 { $$ = $1 - $3; }
    | exp '*' exp                 { $$ = $1 * $3; }
    | exp '/' exp                 { $$ = $1 / $3; }
    | exp POT exp                 { $$ = pow($1, $3); }
    | '-' exp %prec NEG           { $$ = -$2; }
    | '(' exp ')'                 { $$ = $2; }
    ;

%%

void yyerror(const char *s) {}

int main(int argc, char **argv) {
    if (argc > 1) yyin = fopen(argv[1], "r");
    return yyparse();
}