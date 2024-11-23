%{
#include <stdio.h>
#include <stdlib.h>
void yyerror(const char *s);
int yylex();
%}

%token NUMBER PLUS MINUS MULTIPLY DIVIDE EOL
%left PLUS MINUS
%left MULTIPLY DIVIDE

%%
input:
    /* vazio */
    | input line
;

line:
    expr EOL {
        printf("Resultado: %d\n", $1);
    }
;

expr:
    NUMBER {
        $$ = $1;
    }
    | expr PLUS expr {
        $$ = $1 + $3;
    }
    | expr MINUS expr {
        $$ = $1 - $3;
    }
    | expr MULTIPLY expr {
        $$ = $1 * $3;
    }
    | expr DIVIDE expr {
        if ($3 == 0) {
            printf("Erro: divisao por zero\n");
            exit(1);
        }
        $$ = $1 / $3;
    }
;
%%
void yyerror(const char *s) {
    fprintf(stderr, "Erro: %s\n", s);
}

int main() {
    printf("Digite a expressao aritimetica desejada (+, -, /, *):\n");
    return yyparse();
}