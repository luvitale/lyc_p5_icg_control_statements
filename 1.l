%{
#include <stdio.h>
#include <stdlib.h>
#include "1.tab.h"

FILE *yyin;

int lineno = 1;

int yyerror(char *);
%}

%option noyywrap
%option yylineno


natural_digit [1-9]
digit (0|{natural_digit})
uppercase_letter [A-Z]
lowercase_letter [a-z]
letter ({uppercase_letter}|{lowercase_letter})

op_sum "+"
op_sub "-"
op_mult "*"
op_div "/"
op_assign ":="

id {letter}(_?({letter}|{digit}))*

cte ({digit}|{natural_digit}{digit}*)

open_parent "("
close_parent ")"

op_if (if|IF|If)
op_then (then|THEN|Then)
op_else (else|ELSE|Else)
op_endif (endif|ENDIF|Endif)

op_lt "<"
op_le "<="
op_gt ">"
op_ge ">="
op_eq "=="
op_ne (!=|<>)

%%
{open_parent} {
  return open_parent;
}
{close_parent} {
  return close_parent;
}

{op_sum} {
  return op_sum;
}
{op_sub} {
  return op_sub;
}
{op_mult} {
  return op_mult;
}
{op_div} {
  return op_div;
}
{op_assign} {
  return op_assign;
}

{op_if} {
  return op_if;
}
{op_then} {
  return op_then;
}
{op_else} {
  return op_else;
}
{op_endif} {
  return op_endif;
}

{op_lt} {
  return op_lt;
}
{op_le} {
  return op_le;
}
{op_gt} {
  return op_gt;
}
{op_ge} {
  return op_ge;
}
{op_eq} {
  return op_eq;
}
{op_ne} {
  return op_ne;
}

{id} {
  yylval.str_val = strdup(yytext);
  return id;
}

{cte} {
  int value = strtol(yytext,(char **)NULL,10);
  yylval.int_val = value;
  return cte;
}


" "
"\n" {
  ++lineno;
}
"\t"

. {
  char s[] = "invalid character: ";

  strcat(s, yytext);
  strcat(s, "\n");

  yyerror(s);
}
%%
