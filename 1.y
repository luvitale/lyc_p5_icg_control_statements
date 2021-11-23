%{
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include "rpn.h"

#define COLOR_RED "\033[1;31m"
#define COLOR_RESET "\033[0m"

#define FILENAME "1"

int lineno;

int yystopparser = 0;

FILE *yyin;

char *yyltext;
char *yytext;

char* rule[15] = {
  "R0. START -> PROGRAMA",
  "R1. PROGRAMA -> PROGRAMA SENT",
  "R2. PROGRAMA -> SENT",
  "R3. SENT -> SEL",
  "R4. SENT -> ASIG",
  "R5. ASIG -> id := EXP",
  "R6. SEL -> if COND then PROGRAMA endif",
  "R7. SEL -> if COND then PROGRAMA else PROGRAMA endif",
  "R8. COND -> id < cte",
  "R9. EXP -> EXP + TERM",
  "R10. EXP -> TERM",
  "R11. TERM -> TERM * FACTOR",
  "R12. TERM -> FACTOR",
  "R13. FACTOR -> cte",
  "R14. FACTOR -> id"
};

// RPN
rpn_t *rpn;

int yylex();
int yyerror(char *);
%}

%union {
  int int_val;
  char *str_val;
}

%token open_parent close_parent

%token op_sum op_sub op_mult op_div
%token op_assign
%token <str_val> id
%token <int_val> cte

%token op_if op_then op_else op_endif
%token op_lt op_le op_gt op_ge op_eq op_ne

%%
START: PROGRAMA {
  puts(rule[0]);
};

PROGRAMA: PROGRAMA SENT {
  puts(rule[1]);
} | SENT {
  puts(rule[2]);
};

SENT: SEL {
  puts(rule[3]);
} | ASIG {
  puts(rule[4]);
};

ASIG: id op_assign EXP {
  puts(rule[5]);
};

SEL: op_if COND op_then PROGRAMA op_endif {
  puts(rule[6]);
} | op_if COND op_then PROGRAMA op_else PROGRAMA op_endif {
  puts(rule[7]);
};

COND: id op_lt cte {
  puts(rule[8]);
};

EXP: EXP op_sum TERM {
  puts(rule[9]);
} | TERM {
  puts(rule[10]);
};

TERM: TERM op_mult FACTOR {
  puts(rule[11]);
} | FACTOR {
  puts(rule[12]);
};

FACTOR: cte {
  puts(rule[13]);
} | id {
  puts(rule[14]);
};
%%

int main(int argc,char *argv[]) {
  const char* filename = argv[1];
  FILE* arg_file = fopen(filename, "rt");

  if (arg_file == NULL ) {
    printf("File cannot be opened: %s\n", filename);
    printf("Using standard input\n\n");
  }
  else {
    yyin = arg_file;
  }

  rpn = create_rpn();

  yyparse();

  save_rpn_in_file(rpn, FILENAME);

  fclose(yyin);

  return EXIT_SUCCESS;
}

int yyerror(char *error) {
  fprintf(stderr, COLOR_RED "\nline %d: %s\n" COLOR_RESET, lineno, error);
  fclose(yyin);
  exit(1);
}
