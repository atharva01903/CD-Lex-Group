%{
    #include<stdio.h>  
    #include<string.h>  
    #include<ctype.h>
%}

%%
[\ ]{2,}[^\ ] {
    fprintf(yyout,"\t*%c",toupper(yytext[strlen(yytext)-1]));
}
%%

int yywrap(){
    return 1;
}
/*void firstupper(char str[]) {
    int n = strlen(str);
   int i;
   for(i = 0; i<n; i++) {
      //if (str[i-1] != ' ' || str[i-1] == '\t' || str[i-1] == '\n' || str[i-1]=='NULL') {
            if (islower(str[i])) {
                str[i] = toupper(str[i]);
            }
      //}
    }
}*/

int main(){
    /*
        [\ ]{2, } :- recognises all the whitespace
        [^\ ] :- gives us the first letter
    */

    extern FILE *yyin, *yyout;
    yyin = fopen("Input.txt", "r");
    yyout = fopen("Output.txt", "w");
    yylex();
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