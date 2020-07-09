%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

extern int yylex();
extern int yyerror();
extern int yylineno;
extern char* yytext;

char * palavra_base;

%}

%union{
   char* valueBase;
   char* correspondencia;
}
%token pal palT palC ERRO
%type <valueBase> pal  
%type <correspondencia> palT palC Smth 


%%
Dicionario  : Traducao '\n'
            | Dicionario Traducao '\n'
            | Dicionario '\n'
            ;

Traducao : Base Correspondencia
         | Base Delim 
         | Intervalo Exp Correspondencia
         | Correspondencia
         ;


Base    : pal                                   {printf("EN: %s\n",$1); palavra_base = strdup($1);}
        ;

Exp : Smth '-' Smth                             {printf("EN: %s %s %s\n", $1, palavra_base, $3); 
                                                 printf("+base: %s\n", palavra_base);}
    ;

Smth : palC                                     {$$ = strdup($1);}
     |                                          {$$ = "";}                                 
     ;
     
Delim : ':' Correspondencia
      | ':'
      ;
 
        
Correspondencia : Intervalo palC error           {printf("PT Tradução: %s\n",$2); printf("\n");}
                | Intervalo palC                 {printf("PT Tradução: %s\n",$2); printf("\n");}
                ;

Intervalo : Intervalo ' '
          | ' '
          ;
%%


int yyerror(){
    printf("Erro Sintático ou Léxico na linha: %d\n", yylineno);
}

int main(){
    yyparse();
	return 0;
}
