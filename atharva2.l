%{
    #include<stdio.h>  
    #include<string.h>  
    #include<ctype.h>
    char date[15];
    char* sendYear(char* str3);
    int getIndex(char* str2);
    char *months[12] = {
        "January",
        "February",
        "March",
        "April",
        "May",
        "June",
        "July",
        "August",
        "September",
        "October",
        "November",
        "December" };
	char *sh_months[12] = {
        "Jan",
        "Feb",
        "Mar",
        "Apr",
        "May",
        "Jun",
        "Jul",
        "Aug",
        "Sept",
        "Oct",
        "Nov",
        "Dec" };
%}

%%
[\ ]{2,}[^\ ] {
    yytext[yyleng-1] = toupper(yytext[yyleng-1]);
    fprintf(yyout,"\t%c",toupper(yytext[yyleng-1]));
    /*So, we will get the last letter of the recognised string which is the first letter of paragraph*/
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
([1-2][0-9]|[3][0-1]|(0)?[1-9])-([0-9]|11|12)(-[0-9]+)? {
	//printf("%s\n",yytext);
	int i,j,k,n;
    char* str1 = (char*)malloc(sizeof(char)*2);
    char* str2 = (char*)malloc(sizeof(char)*2);
    char* str3 = (char*)malloc(sizeof(char)*5);
	i=0;
	n=strlen(yytext);
	while(yytext[i]!='-') 
	{
		str1[i]=yytext[i];
		i++;
	}
	i++;j=0;
	while(yytext[i]!='-' && j!=2) 
	{
		str2[j]=yytext[i];
		i++;j++;
	}
	if(yytext[i]=='-')
	{
		i++;k=0;
		while(yytext[i]!='\0') 
		{
			str3[k]=yytext[i];
			i++;k++;
		}
	}
	else
	{
		str3[0]='2';
		str3[1]='0';
		str3[2]='2';
		str3[3]='1';
	}
	//printf("%d-%s-%s | %s\n",atoi(str1),months[atoi(str2)-1],str3,sendYear(str3));
	fprintf(yyout,"%s %d, %s",months[atoi(str2)-1],atoi(str1),sendYear(str3));
}
([1-2][0-9]|[3][0-1]|(0)?[1-9])(st|nd|rd|th)[ ](Jan|Feb|Mar|Apr|May|Jun(e)?|Jul(y)?|Aug|Sep(t)?|Oct|Nov|Dec)([ ]([0-9][0-9]|[0-9][0-9][0-9][0-9]))? {
	int i,j,k;
    char* str1 = (char*)malloc(sizeof(char)*2);
    char* str2 = (char*)malloc(sizeof(char)*4);
    char* str3 = (char*)malloc(sizeof(char)*5);
    i=0;
	while(yytext[i]!='s' && yytext[i]!='n' && yytext[i]!='r' && yytext[i]!='t') 
	{
		str1[i]=yytext[i];
		i++;
	}
	i+=3;j=0;
	while(yytext[i]!=' ' && j!=4) 
	{
		str2[j]=yytext[i];
		i++;j++;
	}
	if(yytext[i]==' ')
	{
		i++;k=0;
		while(yytext[i]!='\0') 
		{
			str3[k]=yytext[i];
			i++;k++;
		}
	}
	else
	{
		str3[0]='2';
		str3[1]='0';
		str3[2]='2';
		str3[3]='1';
	}
	//printf("%d-%s-%s\n",atoi(str1),months[getIndex(str2)],sendYear(str3));
	fprintf(yyout,"%s %d, %s",months[getIndex(str2)],atoi(str1),sendYear(str3));
}
(Jan|Feb|Mar|Apr|May|Jun(e)?|Jul(y)?|Aug|Sep(t)?|Oct|Nov|Dec)[ ]([1-2][0-9]|[3][0-1]|(0)?[1-9])(st|nd|rd|th)([ ]([0-9][0-9]|[0-9][0-9][0-9][0-9]))? {
	int i,j,k; // rewrite the regex
    char* str2 = (char*)malloc(sizeof(char)*2);
    char* str1 = (char*)malloc(sizeof(char)*4);
    char* str3 = (char*)malloc(sizeof(char)*5);
    char* yyyy = (char*)malloc(sizeof(char)*4);
    i=0;
    if(yytext[i]==' ')
    {
    	i++;
    }
	while(yytext[i]!=' ' && i!=4) 
	{
		str1[i]=yytext[i];
		i++;
	}
	i++;j=0;
	while(yytext[i]!='s' && yytext[i]!='n' && yytext[i]!='r' && yytext[i]!='t') 
	{
		str2[j]=yytext[i];
		i++;j++;
	}
	i+=2;
	if(yytext[i]==' ')
	{
		i++;k=0;
		while(yytext[i]!='\0') 
		{
			str3[k]=yytext[i];
			i++;k++;
		}
	}
	else
	{
		str3[0]='2';
		str3[1]='0';
		str3[2]='2';
		str3[3]='1';
	}
	printf("%s\n",yytext);
	fprintf(yyout,"%s %d, %s",months[getIndex(str1)],atoi(str2),sendYear(str3));
}
\"[^"]+\" {
	fprintf(yyout,"%s",yytext);
}
%%

int yywrap(){
    return 1;
}
char* sendYear(char* str3)
{
	int two_dig;
	char* yyyy;
	yyyy = (char*)malloc(sizeof(char)*4);
	if(strlen(str3)==2)
	{
		two_dig = atoi(str3);
		if(two_dig>=0 && two_dig<=21)
		{
			yyyy[0] = '2';
			yyyy[1] = '0';	
		}
		else
		{
			yyyy[0] = '1';
			yyyy[1] = '9';	
		}
		yyyy[2]=str3[0];
		yyyy[3]=str3[1];
	}
	else
	{
		 strcpy(yyyy,str3);
	}
	return yyyy;
}
int getIndex(char* str2)
{
	int i;
	char sep[] = "Sep";
	if(strcmp(months[5],str2)==0)
		return 5;
	else if(strcmp(months[6],str2)==0)
		return 6;
	else if(strcmp(sep,str2)==0)
		return 8;
	else
	{
		for(i=0;i<12;i++)
		{
			if(strcmp(sh_months[i],str2)==0)
				return i;
		}
	}
	return 0;
}
int main(){
	/*
        [\ ]{2, } :- recognises all the whitespace
        [^\ ] :- gives us the first letter
        Only thing remaining is inserting a tab at the starting of the file if its not there.
    */
    extern FILE *yyin, *yyout;
    yyin = fopen("input.txt", "r+");
    yyout = fopen("output.txt", "w");
    yylex();
    fclose(yyin);
    fclose(yyout);
    return 0;
}
