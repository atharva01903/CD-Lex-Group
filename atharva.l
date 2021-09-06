%{
char date[50];
%}

%%
[ \n]+ {fprintf(yyout, "");}
.	{ fprintf(yyout, "%s", yytext); }
^[Dd]ate:(\s)?.+.\n\t { 
		int i,c;
		c = 0;
		if(yytext[5]==' ')
		{
			i = 6;
			while(yytext[i]!='\n' && yytext[i]!='\t')
			{
				date[c]=yytext[i];
				//printf("%c",date[c]);
				i++;c++;
			}
			//printf("\n%d\n",i);
		}
		else
		{
			i = 5;
			while(yytext[i]!='\n' && yytext[i]!='\t')
			{
				date[c]=yytext[i];
				//printf("%c",date[c]);
				i++;c++;
			}
		}
		fprintf(yyout, "%s\n",date); 
};
%%

/*** User code section***/
int yywrap(){}
int main()
{
	extern FILE *yyin, *yyout;
  
    /* yyin points to the file input.txt
    and opens it in read mode*/
    yyin = fopen("input.txt", "r");
  
    /* yyout points to the file output.txt
    and opens it in write mode*/
    yyout = fopen("output.txt", "w");
 	yylex();	
	printf("%sc\n",date); 
	return 0;
}

