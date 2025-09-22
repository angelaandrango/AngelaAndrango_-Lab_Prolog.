% 1. Family Tree A
% 2. Define at least 10 parent/2 facts with multiple generations

parent(miguel, angela).
parent(miguel, katherine).
parent(miguel, jhonatan).

parent(olga, angela).
parent(olga, katherine).
parent(olga, jhonatan).

parent(carolina, karla).
parent(jairo, karla).

parent(javier, daniela).
parent(javier, rodrigo).
parent(luisa, daniela).
parent(luisa, rodrigo).


%3. Add rules
grandparent(X,Y) :- parent(X,Z), parent(Z,Y).
sibling(X,Y) :- parent(Z,X), parent(Z,Y), X \= Y.
ancestor(X,Y) :- parent(X,Y).
ancestor(X,Y) :- parent(X,Z), ancestor(Z,Y).

%4 and 5. Food preferences

likes(angela, helado).
likes(cristhian, pizza).
likes(adriana, fritada).
likes(tamya, salchipapa).
likes(gabriel, encebollado).
likes(katherine, pizza).
likes(sofia, ceviche).
likes(mariana, hornado).

%6. Rule Food
food_friend(X, Y):- likes(X, Z), likes(Y, Z), X\=Y.

%8. Factorial Recursively
factorial(0,1).
factorial(N,F) :-
    N > 0,
    N1 is N - 1,
    factorial(N1,F1),
    F is N * F1.


%9. Rule sum_list(List, Sum)
sum_list([],0).
sum_list([H|T],S) :-
    sum_list(T,S1),
    S is H + S1.


%10 and 11. Length
length_list([],0).
length_list([_|T],N) :-
    length_list(T,N1),
    N is N1 + 1.

%12. Append
append_list([],L,L).
append_list([H|T],L2,[H|R]) :-
    append_list(T,L2,R).

%Queries to Run
%?- ancestor(X, rodrigo).
%?- sibling(rodrigo, X).
%?- food_friend(X,Y).
%?- factorial(6,F).
%?- sum_list([2,4,6,8],S).
%?- length_list([a,b,c,d],N).
%?- append_list([1,2],[3,4],R).


