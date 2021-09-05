/* Declaring two counters one for number
of lines other for number of characters */
%{
%}

/***rule 1 counts the number of lines,
rule 2 counts the number of characters
and rule 3 specifies when to stop
taking input***/
%%
%%

/*** User code section***/
int yywrap(){}
int main(int argc, char **argv)
{
// yyelex();
printf("Hello World!\n");

return 0;
}

