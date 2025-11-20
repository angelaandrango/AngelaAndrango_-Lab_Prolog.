:- use_module(library(clpfd)).


%------------------------------- PART A - AUSTRALIA ----------------------------------

% --------- Australia Regions ---------
regions_au([wa, nt, sa, q, nsw, v, t]).

% --------- Adjacent Australia ---------
edges_au([
    wa-nt, wa-sa, nt-sa, nt-q, sa-q,
    sa-nsw, sa-v, q-nsw, nsw-v
]).

% --------- Colors Name ---------
color_names([red, green, blue, yellow, purple] ).

% --------- General Coloring Model ---------

map_color(Regions, Vars, Edges, K) :-
    Vars ins 1..K,
    maplist(diff_constraint(Regions, Vars), Edges),
    labeling([min], Vars).


diff_constraint(Regions, Vars, A-B) :-
    nth0(IndexA, Regions, A),
    nth0(IndexB, Regions, B),
    nth0(IndexA, Vars, ColorA),
    nth0(IndexB, Vars, ColorB),
    ColorA #\= ColorB.


% --------- Resolve for Australia ---------
colorize_au(K, Vars) :-
    regions_au(Regions),
    edges_au(Edges),
    length(Regions, N),
    length(Vars, N),
    map_color(Regions, Vars, Edges, K).


% --------- Print ---------
pretty_color_by_region([], []).
pretty_color_by_region([R|Rs], [C|Cs]) :-
    color_names(Names),
    nth1(C, Names, Name),
    format("~w = ~w~n", [R, Name]),
    pretty_color_by_region(Rs, Cs).




%----------------------------- PART B - SOUTH AMERICA ------------------------------

% -------------------- Regiones de Sudamérica --------------------------------------
regions_sa([ar, bo, br, cl, co, ec, gy, gfr, py, pe, su, uy, ve]).

% ----------------------- Adyacencias de Sudamérica --------------------------------
edges_sa([
    ar-bo, ar-cl, ar-py, ar-uy,
    bo-br, bo-cl, bo-pe, bo-py,
    br-co, br-gy, br-gfr, br-pe, br-py, br-su, br-uy,
    cl-pe,
    co-ec, co-pe, co-ve,
    ec-pe,
    gy-su,
    gfr-gy,
    py-uy
]).


% --------------------------- Resolver para Sudamérica ------------------------------
colorize_sa(K, Vars) :-
    regions_sa(Regions),
    edges_sa(Edges),
    length(Regions, N),
    length(Vars, N),
    map_color(Regions, Vars, Edges, K).


%----------------------------Parte 2 - Optimization -------------------------------------------------

% --------------------------------- Find Minimum Number of Colors -----------------------------------
min_colors(Regions, Edges, MaxK, MinK, Vars) :-
    between(1, MaxK, K),
    length(Regions, N),
    length(Vars, N),
    map_color(Regions, Vars, Edges, K),
    MinK = K,
    !. % 


min_colors_au(MaxK, MinK, Vars) :-
    regions_au(Rs),
    edges_au(Es),
    min_colors(Rs, Es, MaxK, MinK, Vars).

min_colors_sa(MaxK, MinK, Vars) :-
    regions_sa(Rs),
    edges_sa(Es),
    min_colors(Rs, Es, MaxK, MinK, Vars).



