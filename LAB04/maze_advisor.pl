% 1. Maze representation ----------------------------
edge(entrance, a).
edge(a, b).
edge(a, c).
edge(b, exit).
edge(c, b).
blocked(a, c).

% 2. Movement reasoning rules -----------------------

can_move(X, Y) :-
    edge(X, Y),
    \+ blocked(X, Y).

reason(_, Y, 'destination reached') :-
    Y == exit.

reason(X, Y, 'path is open') :-
    can_move(X, Y).

reason(X, Y, 'path is blocked') :-
    blocked(X, Y).


% 3. Recursive traversal with reasoning ---------------

move(X, Y, Visited, [Y|Visited]) :-
    can_move(X, Y),
    format('Moving from ~w to ~w.~n', [X, Y]),
    reason(X, Y, R),
    format('Reason: ~w.~n', [R]),
    !.  % Stop recursion when destination is reached

move(X, Y, Visited, Path) :-
    can_move(X, Z),
    \+ member(Z, Visited),
    format('Exploring from ~w to ~w...~n', [X, Z]),
    reason(X, Z, R),
    format('Reason: ~w.~n', [R]),
    move(Z, Y, [Z|Visited], Path).

% 4. Main predicate -----------------------------------
find_path(X, Y, Path) :-
    move(X, Y, [X], RevPath),
    reverse(RevPath, Path),
    format('Path found: ~w~n', [Path]).

% 5. Optional -----------------------------------------

% Explain why a move was possible
why(X, Y) :-
    reason(X, Y, Explanation),
    format('Reasoning from ~w to ~w: ~w~n', [X, Y, Explanation]).

/*
This program implements reasoning in Prolog by combining facts, rules,
and recursion. The maze is represented as a graph using edge/2 facts
and blocked/2 facts to indicate obstacles. Logical reasoning is achieved
through the predicates can_move/2 and reason/3, which decide if a move
between two nodes is possible and explain why. Recursive traversal is
implemented in move/4, which explores all reachable paths while avoiding
loops by keeping track of visited nodes. Finally, the main predicate
find_path/3 integrates these components to find a valid path from the
entrance to the exit and prints human-readable reasoning at each step.
*/
  