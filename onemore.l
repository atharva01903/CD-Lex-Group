%{
    #include<stdio.h>  
    #include<string.h>  
    #include<ctype.h>
%}
%%
[ ][\n]+ {
    fprintf(yyout,"\n\t^%s",yytext);
}
%%


int main(){
    extern FILE *yyin, *yyout;
    yyin = fopen("Input.txt", "r");
    yyout = fopen("Output.txt", "w");
    yylex();
    return 0;
}