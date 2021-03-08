:- use_module(library(clpfd)).

solver(Rows) :-
    /*Sind alle Reihen 9 Lang*/
    length(Rows, 9), 
    /*Sind die Spalten 9 Lang (Liste der Liste)*/
    maplist(same_length(Rows), Rows),
    /*Alle Eingaben der Rows (die Zahlen) sind in Vs definiert*/
    append(Rows, Vs),
    /*Vs sind die Zahlen von 1 bis 9*/
    Vs ins 1..9,
    /*Schleife ForEach Row, all_distinct*/
    maplist(all_distinct, Rows),
    /*"Drehen" der einzelnen Reihen, Rows werden Columns, Columns werden Rows*/
    /*
    Vorher
    1   2   3   4   5   6   7   8   9
    10  11  12  13  14  15  16  17  18
    19  20  21  22  23  24  25  ...
    Nachher
    1   10  19  28  37  46  55  64  73
    2   11  20  29  38  47  56  65  74 
    3   12  21  30  ...
    */
    transpose(Rows, Columns),
    /*Schleife, um auch die Spalten all_distinct zu machen*/
    maplist(all_distinct, Columns),

    /*Die einzelnen Blöcke benennen, mit Variablen*/ 
    Rows = [A,B,C,D,E,F,G,H,I],
    /*nun immer drei Reihen am Stück*/
    /*Erste Reihe A, B, C*/
    squares(A, B, C),
    /*Zweite Reihe D, E, F*/
    squares(D, E, F),
    /*Dritte Reihe G, H, I*/
/*
    squares(G, H, I),
    maplist(labeling([ff]), Rows). 
*/
    squares(G, H, I).
    

/*Wird verwendet wenn wir am dritten Square sind, es gibt nur insgesamt 9*/
squares([], [], []).
/*Die ersten drei Zahlen jeder der drei Reihe (A-I) und alle anderen 6 Zahlen jeder Reihe als Ss1..., dann Rekursiver Aufruf der Funktion*/
squares( [A, B, C | Ss1],
         [D, E, F | Ss2],
         [G, H, I | Ss3]) :-
    all_distinct([A, B, C, D, E, F, G, H, I]),
    squares(Ss1, Ss2, Ss3).

/*Beispiel für ein squares
1   2   3   4   5   6   7   8   9
10  11  12  13  14  15  16  17  18
19  20  21  22  23  24  25  ...

A = 1   B = 2   C = 3
D = 10  E = 11  F = 12
G = 19  H = 20  I = 21

Ss1 = 4, 5, 6, 7, 8, 9
Ss2 = 13, 14, 15, 16, 17 ...
*/

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

/*In SWI Prolog
?- puzzle(1,Rows), solver(Rows), maplist(portray_clause, Rows).*/

/*
?- solver(Rows), maplist(label, Rows), maplist(portray_clause, Rows).
*/


/*https://www.youtube.com/watch?v=5KUdEZTu06o&ab_channel=ThePowerofProlog*/