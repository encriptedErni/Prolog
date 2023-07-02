:- module(_,_,[classic,assertions,regtypes]).
author_data('Naval','Rodriguez','Ernesto','C200343').

%hechos
color(o).
color(x).

%reglas automata
rule(o,o,o,_,o). % regla nula
rule(x,o,o,r(A,_,_,_,_,_,_),A) :- color(A).
rule(o,x,o,r(_,B,_,_,_,_,_),B) :- color(B).
rule(o,o,x,r(_,_,C,_,_,_,_),C) :- color(C).
rule(x,o,x,r(_,_,_,D,_,_,_),D) :- color(D).
rule(x,x,o,r(_,_,_,_,E,_,_),E) :- color(E).
rule(o,x,x,r(_,_,_,_,_,F,_),F) :- color(F).
rule(x,x,x,r(_,_,_,_,_,_,G),G) :- color(G).



%reglas auxiliares

%first element is white
first_white([o|_]).

%last element is white
last_white([o]).
last_white([_|T]) :- 
    last_white(T).

%add an element to the last position of a list
add_last(X, [], [X]).
add_last(X, [H|T], [H|T1]) :- add_last(X, T, T1).


%Takes the 3 first elements of a list
take_3([A,B,C|_],A,B,C).

%Appends 2 lists
join([], X, X).                                  
join([X | Y], Z, [X | W]) :- 
    join(Y, Z, W).

%Creates a list of sublists of 3 elememts each out of a list
list_of_3([X,Y,Z], [[X,Y,Z]]).
list_of_3([X,Y,Z|T], [[X,Y,Z]|R]) :- 
    list_of_3([Y,Z|T], R).

%errases the 2 first elements of a list
del_2([_,_|T], T).

%fin reglas auxiliares  

%cells/3
%Computes the state of the cells after applying the rules in a given rule set.
cells(Inic, Rule, Cells) :-
    first_white(Inic),
    last_white(Inic),
    join([o], Inic, White1),
    add_last(o, White1, White2),
    list_of_3(White2, Lists),
    cells_aux(Lists, Rule, Cells1),
    join([o],Cells1, Cells2),
    add_last(o, Cells2, Cells).

cells_aux([], _, []).
cells_aux([H|T], Rule, [Color|Cells]) :-
    take_3(H, A, B, C),
    rule(A, B, C, Rule, Color),
    cells_aux(T, Rule, Cells).


%evol/3
%Evolves the cells for a given number of steps using a given rule set.
evol(N, RuleSet, Cells) :-
    evol_aux(N, RuleSet, [o,x,o], Cells).

evol_aux(0, _, Cells, Cells).
evol_aux(s(N), RuleSet, PrevCells, Cells) :-
    cells(PrevCells, RuleSet, NextCells),
    evol_aux(N, RuleSet, NextCells, Cells).

%step/2
%Computes the number of steps required to reduce the cells to a size of 3 cells.
steps([_,_,_], 0).
steps(Cells, s(N)) :-
    del_2(Cells, ReducedCells),
    steps(ReducedCells, N).


%ruleset/2
%Computes a rule set for a given initial state of cells.
ruleset(RuleSet, Cells) :-
    steps(Cells, N),
    evol(N, RuleSet, Cells).






