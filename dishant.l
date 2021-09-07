%{
    #include<stdio.h>  
    #include<string.h>  
    #include<ctype.h>
%}

%%
[\ ]{2,}[^\ ] {
    fprintf(yyout,"\t*%c",toupper(yytext[yyleng-1]));
    /*So, we will get the last letter of the recognised string which is the first letter of paragraph*/
}
[\n][^\ ][a-zA-Z] {
    fprintf(yyout,"\n\n\t#%c",toupper(yytext[yyleng-1]));
}
[\.][\ ][a-zA-Z] {
    yytext[yyleng-1] = toupper(yytext[yyleng-1]);
    fprintf(yyout,"%s",yytext);
}
%%

int yywrap(){
    return 1;
}
/*void firstupper(char str[]) {
    
    
    capitalizes the first character of file but since the whole documents gets selected we can see other chages;
    [^. ]*[. a-zA-Z0-9(/)\n\.]+ {
     yytext[0] = toupper(yytext[0]);
    fprintf(yyout,"\t%s",yytext);
}
    


    int n = strlen(str);
   int i;
   for(i = 0; i<n; i++) {
      //if (str[i-1] != ' ' || str[i-1] == '\t' || str[i-1] == '\n' || str[i-1]=='NULL') {
            if (islower(str[i])) {
                str[i] = toupper(str[i]);
            }
      //}
    }
}

Input

flex is a tool/computer. program for generating lexical analyzers (scanners or lexers) 

written by Vern Paxson in C around 1987. lex reads an input stream specifying the lexical analyzer.

    537aagrge75agr

and outputs source code implementing the lexer in the C programming

    language. The function yylex() is the main flex function which runs the Rule Section.

        what the fuck is this

*/
void swapthat(FILE *a, FILE *b){
    if(a==yyin){
        yyin = yyout;
        yyout = a;
    }else{
        yyout = yyin;
        yyin = b;
    }
}

int main(){
    /*
        [\ ]{2, } :- recognises all the whitespace
        [^\ ] :- gives us the first letter
        Only thing remaining is inserting a tab at the starting of the file if its not there.
    */

    extern FILE *yyin, *yyout;
    yyin = fopen("Input.txt", "r+");
    yyout = fopen("Output.txt", "r+");
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