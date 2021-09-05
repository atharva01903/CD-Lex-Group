%{
    #include<stdio.h>    
%}
%%
[\n+A-Z]+ {
    fprintf(yyout,"*\t%s", yytext);
}
[\n+\n+\t] {
    fprintf(yyout,"#%s", yytext);
}


%%

int main(){
    /* This program will find each of Capital letter  and new line from input file and replace it with "*     " in Output file"*/

    extern FILE *yyin, *yyout;
    yyin = fopen("Input.txt", "r");
    yyout = fopen("Output.txt", "w");
    yylex();
    return 0;
}