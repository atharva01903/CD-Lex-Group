%{
#include<stdio.h>
#include<string.h>
char line[100];
%}

%%
[a-z A-Z 0-9]+ printf("%s",yytext);
"$" return 0;
%%

/*** User code section***/
int yywrap(){}
int main(int argc, char **argv)
{
 	yylex(); 
	return 0;
}

