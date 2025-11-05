:- use_module(library(clpfd)).

%------------------- Part 1 – Setup ----------------------------
task(a, 3, 1).
task(b, 2, 1).
task(c, 4, 2).
task(d, 2, 1).

%------------------- Part 2 – Core Logic ------------------------
schedule(Tasks, Starts, Ends, Makespan) :-
    findall(task(N,D,R), task(N,D,R), Tasks),

    length(Tasks, N),
    length(Starts, N),
    length(Ends, N),

    Starts ins 0..20,
    Ends   ins 0..30,

    findall(D, task(_,D,_), Durations),
    findall(R, task(_,_,R), Resources),

    maplist(constrain_task, Starts, Durations, Ends),
    apply_non_overlap(Starts, Durations, Resources),

    nth0(0, Ends, Ea),
    nth0(1, Starts, Sb),
    Ea #=< Sb,

    Makespan in 0..30,
    max_constraint(Ends, Makespan),

    append(Starts, [Makespan], Vars),
    labeling([min(Makespan)], Vars).

constrain_task(S, D, E) :- E #= S + D.

apply_non_overlap([], [], []).
apply_non_overlap([S|Ss], [D|Ds], [R|Rs]) :-
    no_overlap_with_others(S, D, R, Ss, Ds, Rs),
    apply_non_overlap(Ss, Ds, Rs).

no_overlap_with_others(_, _, _, [], [], []).
no_overlap_with_others(S1, D1, R1, [S2|Ss], [D2|Ds], [R2|Rs]) :-
    (R1 #= R2 ->
        S1 + D1 #=< S2 #\/ S2 + D2 #=< S1
    ; true),
    no_overlap_with_others(S1, D1, R1, Ss, Ds, Rs).

% Manual max implementation for old SWI-Prolog
max_constraint([], _).
max_constraint([E|Es], Max) :-
    E #=< Max,
    max_constraint(Es, Max),
    member(Max, [E|Es]).

%------------------- Part 3 – Output -----------------------------
run_schedule :-
    schedule(Tasks, Starts, Ends, Makespan),
    format('--- Schedule ---~n'),
    print_schedule(Tasks, Starts, Ends),
    format('makespan=~w~n',[Makespan]).

print_schedule([], [], []).
print_schedule([task(N,D,R)|Ts],[S|Ss],[E|Es]):-
    format('~w [res=~w, dur=~w]\t start=~w\t end=~w~n',[N,R,D,S,E]),
    print_schedule(Ts,Ss,Es).




/*
In this laboratory, it was not possible to use the predicates disjoint1/1 and maximum/2,
because the version of SWI-Prolog installed does not support them.
For this reason, it was necessary to replace them with manual constraints to avoid task 
overlap and an auxiliary predicates to calculate the makespan.
These adaptations allow the planner to continue functioning correctly and obtain the result, 
even when working with and older version of Prolog.

*/