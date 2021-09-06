# LEX Code Repo for the group
We have to just get our things done. At first glance, LEX doesn't seem that different from C. Just keep a check on three things:
1. Definitions 
2. Rules
3. Code Section
## Pre-requisites
- Each one of us must have installed **Flex (Fast Lexical Analyzer Generator )**
- It will compile your LEX program
- It's your wish to update your system before installing Flex.
- `sudo apt-get install flex`
## Running the code
I have provided 3 sample LEX programming files and one reading source (given by Sir) in this repository. In order to run the LEX program follow these steps:
- Store your program with **'.l'** extension only. That is the convention we as a group are going to follow
- $ lex filename.l
- $ gcc lex.yy.c
- $ ./a.out
## Notes
- As negative lookahead is not supported by flex compiler we are extracting date segment otherwise would have used the regex `(?<=^[Dd]ate:).*` 
