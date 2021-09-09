%{
    #include<stdio.h>  
    #include<string.h>  
    #include<ctype.h>
%}
%%
[^?][A-Za-z0-9 \n.&()?/]{1,} {
    // FILE *in = fopen("Output.txt","r");
    // fgets(yytext,yyleng,in);
    yytext[0] = toupper(yytext[0]);
    fprintf(yyout,"\t%s",yytext);
    //printf("%c",yytext[0]);
    // to add a tab and capitalise the first letter of the file if tab is not present and is small
}
%%


int main(){

// [ ][\n]+ {
//     fprintf(yyout,"\n\t^%s",yytext);
// }

    extern FILE *yyin, *yyout;
    yyin = fopen("Output.txt", "r");
    yyout = fopen("Input.txt", "w");
    yylex();
    return 0;
}