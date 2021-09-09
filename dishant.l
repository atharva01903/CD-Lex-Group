%{
    #include<stdio.h>  
    #include<string.h>  
    #include<ctype.h>
%}

%%
[\ ]{2,}[^\ ] {
    fprintf(yyout,"\n\n\t%c",toupper(yytext[yyleng-1]));
    /*So, we will get the last letter of the recognised string which is the first letter of paragraph*/
}
[\n][^\ ][a-zA-Z] {
    fprintf(yyout,"\n\n\t%c",toupper(yytext[yyleng-1]));
}
[\.][\ ][a-zA-Z] {
    yytext[yyleng-1] = toupper(yytext[yyleng-1]);
    fprintf(yyout,"%s",yytext);
}
%%

int yywrap(){
    return 1;
}

int main(){
    /*
        [\ ]{2, } :- recognises all the whitespace
        [^\ ] :- gives us the first letter
        Only thing remaining is inserting a tab at the starting of the file if its not there.
    */

    extern FILE *yyin, *yyout;
    yyin = fopen("input.txt", "r+");
    yyout = fopen("Output.txt", "w");
    yylex();
    // rewind(yyin);
    // if(yyin[0]!=' '){
    //     yyout[0] = toupper(yyin[0]);
    // } 
    fclose(yyin);
    fclose(yyout);
    return 0;

    /*
    //[ \n\t\r]+[A-Z]
    //[\s]{2,}[^\t]
    //[\n]*[^\t][A-Z]
    // [\n+A-Z]+
    // Second line 
    // not needed
    [\n+\n+\t] {
        fprintf(yyout,"#%s", yytext);
    }
    */
}
