%{
#include "bison_expr.tab.h"
%}

digit       [0-9]+
whitespace  [ \t]

%%

{digit}     { yylval = atoi(yytext); return NUMBER; }
"+"         { return PLUS; }
"-"         { return MINUS; }
"*"         { return MULTIPLY; }
"/"         { return DIVIDE; }
\n          { return EOL; }
{whitespace}+ { /* Ignorar espaços */ }

.           { printf("Token inválido: %s\n", yytext); return 0; }
%%

int yywrap() {
    return 1;
}