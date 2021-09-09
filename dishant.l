%{
    #include<stdio.h>  
    #include<string.h>  
    #include<ctype.h>
    void wrap();
%}
%%
[\ ]{2,}[^\ ] {
    fprintf(yyout,"\t%c",toupper(yytext[yyleng-1]));
    /*So, we will get the last letter of the recognised string which is the first letter of paragraph*/
}
[\n][^\ ][a-zA-Z] {
    fprintf(yyout,"\n\n\t%c",toupper(yytext[yyleng-1]));
    // where tab is not present
    // will substitute a single tab where extra tabs are given
}
[\.][\ ][a-z]|[\?][\ ][a-z]|[!][\ ][a-z]  {
    yytext[yyleng-1] = toupper(yytext[yyleng-1]);
    fprintf(yyout,"%s",yytext);
    //the letter after the space after a Full stop, a question mark, an exclamation mark 
}
%%
int yywrap(){
    printf("%c",yytext[0]);
    return 1;
}
/*
[^?][A-Za-z0-9 \n.&()?/]{1,} {
    // FILE *in = fopen("Output.txt","r");
    // fgets(yytext,yyleng,in);
    yytext[0] = toupper(yytext[0]);
    fprintf(yyout,"\t%s",yytext);
    //printf("%c",yytext[0]);
    // to add a tab and capitalise the first letter of the file if tab is not present and is small
}



[^?\ ][A-Za-z0-9 \n.&()?/]* {
    char* temp = strdup(yytext);
    strcpy(yytext, "\t");
    strcat(yytext, temp);
    yytext[1] = toupper(yytext[1]);
    fprintf(yyout,"%s^1",yytext);
    printf("%c",yytext[1]);
    free(temp);
}


[^?\ ][a-zA-Z ]{1,}[\ ][\n?]* {
    fprintf(yyout,"%s\n",yytext);
}


void firstupper(char str[]) {
    capitalizes the first character of file but since the whole documents gets selected we can see other chages;
    [^. ]*[. a-zA-Z0-9(/)\n\.]+ {
     yytext[0] = toupper(yytext[0]);
    fprintf(yyout,"\t%s",yytext);
}
void swapthat(FILE *a, FILE *b){
    if(a==yyin){
        yyin = yyout;
        yyout = a;
    }else{
        yyout = yyin;
        yyin = b;
    }
}


Input

flex is a tool/computer. program for generating lexical Sanalyzers (scanners or lexers)

written by Vern Paxson in C around 1987. lex reads an input stream specifying the lexical analyzer.

    ertr537aagrge75agr

and outputs source code. implementing the lexer & in the C programming

    language. the function yylex() is the main flex function which runs the Rule Section.

        what. the fuck is this

*/
void wrap(){
    if(yytext[0]=='f'){
        yytext[0] = '_';
    } 
    rewind(yyin);
}

int main(){
    /*
        [\ ]{2, } :- recognises all the whitespace
        [^\ ] :- gives us the first letter
        Only thing remaining is inserting a tab at the starting of the file if its not there.
    */

    extern FILE *yyin, *yyout;
    yyin = fopen("Input.txt", "r");
    yyout = fopen("Output.txt", "w");
    
    yylex();
    yywrap();
    // yyrestart(yyin);
    // wrap();
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
