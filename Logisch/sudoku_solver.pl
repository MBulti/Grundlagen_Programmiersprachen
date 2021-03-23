:- use_module(library(clpfd)).

regeln(Zeilen) :-
    length(Zeilen, 9), 
    maplist(same_length(Zeilen), Zeilen),
    append(Zeilen, Vs), 
    Vs ins 1..9,
    maplist(all_distinct, Zeilen),
    
    transpose(Zeilen, Spalten),
    maplist(all_distinct, Spalten),

    Zeilen = [A,B,C,D,E,F,G,H,I],
    block(A, B, C),
    block(D, E, F),
    block(G, H, I).
    

block([], [], []).
block( [AA, BB, CC | Rest1],
         [DD, EE, FF | Rest2],
         [GG, HH, II | Rest3]) :-
    all_distinct([AA, BB, CC, DD, EE, FF, GG, HH, II]),
    block(Rest1, Rest2, Rest3).


loeseSudoku(Nummer) :- 
    puzzle(Nummer, Zeilen), 
    regeln(Zeilen), 
    maplist(labeling([ff]), Zeilen), 
    maplist(portray_clause, Zeilen).


generiereSudoku(Rows) :- 
    regeln(Rows), 
    maplist(labeling([ff]), Rows), 
    maplist(portray_clause, Rows).

/*Beispiele*/
puzzle(1,  [[_,4,_,9,_,_,_,5,_],
            [2,_,_,_,_,_,_,4,_],
            [1,9,_,_,8,_,7,_,_],
            [5,_,_,_,_,_,1,_,_],
            [_,_,7,_,6,_,_,_,3],
            [_,_,_,_,3,_,8,9,_],
            [_,8,_,3,4,_,_,6,_],
            [3,_,_,2,_,8,_,_,_],
            [_,_,_,_,_,_,_,_,_]]).

puzzle(2,  [[_,_,9,5,_,_,_,3,7],
            [1,3,7,9,_,_,_,5,2],
            [2,_,_,_,_,3,6,9,_],
            [3,5,2,_,1,_,_,_,6],
            [_,_,_,4,5,2,3,_,_],
            [_,8,1,_,3,_,2,_,_],
            [6,_,3,_,4,_,8,_,9],
            [5,2,_,_,_,1,_,6,_],
            [_,_,_,3,_,7,_,_,_]]).

puzzle(3,  [[_,5,_,1,_,_,_,_,_],
            [2,_,_,5,_,_,6,_,_],
            [1,_,_,_,8,_,2,_,_],
            [_,8,_,4,3,_,_,_,_],
            [_,_,_,_,_,_,_,4,_],
            [_,_,_,_,_,7,9,3,2],
            [_,4,_,6,7,_,_,_,_],
            [_,7,_,_,_,_,_,1,9],
            [9,_,_,_,_,8,_,_,_]]).

