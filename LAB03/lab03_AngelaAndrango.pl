%------------------------------------
% Lab: Graph Traversal in Prolog
%------------------------------------

:- discontiguous edge/2.

%-----------------------------------
% 1. BASICS
%-----------------------------------
% 1.1. Define edges
edge(a, b).
edge(b, c).
edge(a, d).
edge(d, c).
edge(c, a).

% 1.2. Test reachability using path/2.
path(X, Y) :- edge(X, Y).
path(X, Y) :- edge(X, Z), path(Z, Y).

% 2. CYCLES (se usa path_safe)
path_safe(X, Y) :- path_safe(X, Y, []).
path_safe(X, Y, _) :- edge(X, Y).
path_safe(X, Y, Visited) :-
    edge(X, Z),
    \+ member(Z, Visited),
    path_safe(Z, Y, [X|Visited]).

%------------------------------------
% 3. LISTING ALL PATHS
%------------------------------------
all_paths(X, Y, Paths) :-
    findall(P, find_path(X, Y, [X], P), Paths).

find_path(X, Y, Visited, Path) :-
    edge(X, Y),
    reverse([Y|Visited], Path).

find_path(X, Y, Visited, Path) :-
    edge(X, Z),
    \+ member(Z, Visited),
    find_path(Z, Y, [Z|Visited], Path).

%------------------------------------
% 4. STUDENT EXTENSION (MAZE)
%------------------------------------
door(entrance, room1).
door(room1, room2).
door(room2, room3).
door(room1, room4).
door(room4, exit).

maze_path(X, Y, Path) :-
    findall(P, find_maze_path(X, Y, [X], P), AllPaths),
    member(Path, AllPaths).

find_maze_path(X, Y, Visited, Path) :-
    door(X, Y),
    reverse([Y|Visited], Path).

find_maze_path(X, Y, Visited, Path) :-
    door(X, Z),
    \+ member(Z, Visited),
    find_maze_path(Z, Y, [Z|Visited], Path).
