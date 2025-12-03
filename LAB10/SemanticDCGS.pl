%----------------LEXICON---------------------

det --> [the] | [a] | [an].

noun(cat)  --> [cat].
noun(dog)  --> [dog].
noun(fish) --> [fish].
noun(bird) --> [bird].

adjective(big)   --> [big].
adjective(small) --> [small].
adjective(angry) --> [angry].

verb(eat)   --> [eat]  | [eats].
verb(see)   --> [see]  | [sees].
verb(love)  --> [love] | [loves].
verb(chase) --> [chase] | [chases].

%------------SEMANTIC---------------------------

sentence(S) -->
    noun_phrase(Subj),
    verb_phrase(Subj, S).

noun_phrase(Subj) -->
    det_opt,
    adjectives(Mods),
    noun(N),
    { (Mods == [] -> Subj = N ; Subj = entity(N, Mods)) }.

det_opt --> [].
det_opt --> det.

adjectives([]) --> [].
adjectives([A|As]) --> adjective(A), adjectives(As).

verb_phrase(Subj, Sem) -->
    verb(V),
    noun_phrase(Obj),
    { Sem =.. [V, Subj, Obj] }.



% ----------------------Final Comment:
% In this laboratory, we successfully implemented all required extensions.
% We extended the grammar to allow adjectives before nouns in noun phrases,
% and we decided to include adjectives in the semantic representation.