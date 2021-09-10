
%{
    #include<stdio.h>  
    #include<string.h>  
    #include<ctype.h>
    void wrap();
%}
%%
[\ ]{2,}[^\ ] {
    yytext[yyleng-1] = toupper(yytext[yyleng-1]);
    fprintf(yyout,"\t%c",toupper(yytext[yyleng-1]));
    /*So, we will get the last letter of the recognised string which is the first letter of paragraph*/
}
[\X][a-zA-Z0-9_] {
	printf("%s\n",yytext);
}
[\n][^\ ][a-z] {
    int i;
    printf("1.%sc\n",yytext);
    for(i=yyleng-1; i>=0;i--){
        if(yytext[i] == '\n'){
            yytext[i] = '\t';
            if(yytext[i-1] != '\n'){
                fprintf(yyout,"\n\n");
            }
            break;
        }
        if(yytext[i] == '\t'){
            if(yytext[i-1] == '\n'){
                if(yytext[i-2]!='\n'){
                    fprintf(yyout,"\n");
                }
            }
            break;
        }
    }
    yytext[i+1] = toupper(yytext[i+1]);
    //printf("%c %c,",a,b);
    fprintf(yyout,"%s",yytext);
    // where tab is not present
    //  will not substitute a single tab where extra tabs are given
}
[\n]+[a-z]|[\n]+[A-Z] {
    fprintf(yyout,"^%s",yytext);
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
    //yyin = fopen("Input.txt", "r");
    yyin = fopen("input.txt","r");
    yyout = fopen("Output.txt", "w");
    
    yylex();
    yywrap();
    // yyrestart(yyin);
    // wrap();
    fclose(yyin);
    fclose(yyout);
    return 0;
}
