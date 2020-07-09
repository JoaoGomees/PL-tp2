%{
#include "y.tab.h" 
#include <stdio.h>

int numberSpaces = 0;

%}
%option yylineno
%option noyywrap

acentos Ç|ç|á|Á|à|À|ã|Ã|â|Â|é|É|è|È|ê|Ê|í|Í|ó|Ó|ô|Ô|ú|Ú
%x TRADUCAO EXP AUX
%%
[A-Z][ ]*\n                                                                 {printf("Começa letra %c\n",yytext[0]);}
[ ]                                                                         { BEGIN AUX; return (yytext[0]); }
[^ |\n|:]+([[ ][^ |\n|:]+)*                                                 { yylval.valueBase=strdup(yytext); BEGIN TRADUCAO; return pal; }
\n                                                                          { return (yytext[0]);} 
.                                                                           {;}

<AUX>[ ]                                                                    { numberSpaces++; return (yytext[0]); }
<AUX>\-                                                                     { BEGIN EXP; numberSpaces = 0; return (yytext[0]); }
<AUX>[a-zA-Z()\[\]|acentos|\s]+([ -][a-zA-Z()\[\]|acentos|\s]+)*           { if(numberSpaces > 9)
                                                                            {
                                                                        
                                                                                yylval.correspondencia=strdup(yytext); numberSpaces = 0; BEGIN INITIAL; return palC; 
                                                                            } else 
                                                                                {
                                                                         
                                                                                    yylval.correspondencia=strdup(yytext); numberSpaces = 0; BEGIN EXP; return palC;
                                                                                }}

<TRADUCAO>:                                                                 { return (yytext[0]); }
<TRADUCAO>[ ]                                                               { return (yytext[0]); }
<TRADUCAO>[^ |\n|]+([ ][^ |\n]+)*                                           { yylval.correspondencia=strdup(yytext); return palC; }
<TRADUCAO>\n                                                                { BEGIN INITIAL;return (yytext[0]); } 
<TRADUCAO>.                                                                 { BEGIN INITIAL; } 

<EXP>\-                                                                     { return (yytext[0]); }
<EXP>[ ]                                                                   { ; }
<EXP>[ ][ ]                                                                 { BEGIN TRADUCAO; }
<EXP>[a-zA-Z()\[\]]+([[ -][a-zA-Z()\[\]]+)*                                 { yylval.correspondencia=strdup(yytext); return palC; }  
<EXP>\n                                                                     { BEGIN INITIAL; return (yytext[0]); } 
<EXP>.                                                                      {;}




%%



