projeto : y.tab.o lex.yy.o 
	gcc -o projeto y.tab.o lex.yy.o -ll

y.tab.o: y.tab.c
	gcc -c y.tab.c

lex.yy.o: lex.yy.c
	gcc -c lex.yy.c

y.tab.c y.tab.h: h.y
	yacc -d -v h.y

lex.yy.c: h.l y.tab.h
	flex h.l

clean: 
	rm *.o
	rm projeto
	rm y.tab.c y.tab.h lex.yy.c y.output