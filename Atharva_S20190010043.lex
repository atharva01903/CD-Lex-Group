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
[\n][^\ ][a-z]|[\n][^\ ][A-Z] {
    int i;
    for(i=yyleng-1; i>=0;i--){
        if(yytext[i] == '\n'){
            yytext[i] = '\t';
            if(yytext[i-1] != '\n'){
                fprintf(yyout,".");
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
    fprintf(yyout,"%s",yytext);
    // where tab is not present it will add an empty line followed by a tab
    // where tab is already present it will just  add an empty line  
}
[\n]+[a-z]|[\n]+[A-Z] {
    fprintf(yyout,"\t%s",yytext);
}

[\.][\ ][a-z]|[\?][\ ][a-z]|[!][\ ][a-z]  {
    yytext[yyleng-1] = toupper(yytext[yyleng-1]);
    fprintf(yyout,"%s",yytext);
    //the letter after the space after a Full stop, a question mark, an exclamation mark 
}
[0-9]+-[0-9]+(-[0-9]+)? {
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
		if(i>=yyleng)
			break;
	}
	if(i<yyleng)
	{
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
	}
	else
	{
		str3[0]='2';
		str3[1]='0';
		str3[2]='2';
		str3[3]='1';
	}
	fprintf(yyout,"%s %d, %s",months[getIndex(str2)],atoi(str1),sendYear(str3));
}
(Jan|Feb|Mar|Apr|May|Jun(e)?|Jul(y)?|Aug|Sep(t)?|Oct|Nov|Dec)[ ]([1-2][0-9]|[3][0-1]|(0)?[1-9])(st|nd|rd|th)([ ]([0-9][0-9]|[0-9][0-9][0-9][0-9]))? {
	int i,j,k; 
    char* str2 = (char*)malloc(sizeof(char)*2);
    char* str1 = (char*)malloc(sizeof(char)*4);
    char* str3 = (char*)malloc(sizeof(char)*5);
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
    */
    extern FILE *yyin, *yyout;
    char filein[50];
    printf("Please enter an existing input essay file: ");
    scanf("%s",filein);
    yyin = fopen(filein, "r+");
    yyout = fopen("output.txt", "w");
    yylex();
    fclose(yyin);
    fclose(yyout);
    printf("The formatted essay has been uploaded in output.txt file of the current folder.\n");
    return 0;
}
