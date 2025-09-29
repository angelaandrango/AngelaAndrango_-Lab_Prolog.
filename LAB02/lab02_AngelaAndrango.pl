%----------------------------
% Step1: Knowledge Base
%----------------------------

food(pizza).
food(hawaiian_pizza).
food(salad).
food(hornado).
food(burger).
food(sushi).
food(tacos).
food(pasta).
food(soup).
food(fruit_salad).
food(cereal).
food(ice_cream).
food(sandwich).
food(crepes).
food(tiramisu).
food(alitas).

%----------------------------
% Step2: Rules for classification
%----------------------------
contains_meat(pizza).
contains_meat(burger).
contains_meat(sushi).
contains_meat(pasta).
contains_meat(hornado).
contains_meat(tacos).
contains_meat(alitas).

vegetarian(salad).
vegetarian(soup).
vegetarian(fruit_salad).
vegetarian(cereal).
vegetarian(ice_cream).
vegetarian(sandwich).
vegetarian(hawaiian_pizza).
vegetarian(tiramisu).
vegetarian(crepes).

vegan(fruit_salad).
vegan(salad).

for_breakfast(cereal).
for_breakfast(fruit_salad).
for_breakfast(sandwich).
for_breakfast(crepes).

for_lunch(pizza).
for_lunch(burger).
for_lunch(salad).
for_lunch(sushi).
for_lunch(pasta).
for_lunch(hornado).
for_lunch(tacos).
for_lunch(alitas).

for_dinner(soup).
for_dinner(pasta).
for_dinner(sushi).
for_dinner(salad).
for_dinner(alitas).
for_dinner(tacos).

sweet(ice_cream).
sweet(fruit_salad).
sweet(crepes).
sweet(tiramisu).

%--------------------------------
% Step3: Generalization
%--------------------------------

is_meatlover(X) :- contains_meat(X).
is_vegetarian(X) :- vegetarian(X).
is_vegan(X) :- vegan(X).
is_sweet(X) :- sweet(X).

%-----------------------
% Step4: Interaction
%-----------------------

ask(Question, Answer) :-
    write(Question), write(' (yes/no): '), nl,
    read(Answer).

%-------------------------------
% Step5: Food recommendations
%-------------------------------

recommend_food(List) :-
    ask('Do you want meat?', Meat),
    ask('Is it for breakfast?', Breakfast),
    ask('Is it for lunch?', Lunch),
    ask('Is it for dinner?', Dinner),
    ask('Do you prefer something sweet?', Sweet),

    findall(F,
        ( food(F),
          (Meat == yes -> contains_meat(F) ; true),
          (Breakfast == yes -> for_breakfast(F) ; true),
          (Lunch == yes -> for_lunch(F) ; true),
          (Dinner == yes -> for_dinner(F) ; true),
          (Sweet == yes -> sweet(F) ; true)
        ),
        RawList),
    sort(RawList, List), % elimina duplicados y ordena
    ( List = [] ->
        write('Sorry, no foods match your preferences.'), nl
    ;
        write('Based on your answers, you could try: '), write(List), nl
    ).

%-----------------------------
% Show all food
%-----------------------------
show_all_food :-
    findall(F, food(F), List),
    write('All foods: '), write(List), nl.

% ---------------------------------------------
% Step 7: Classification tree with recursion
% ---------------------------------------------

% Categorías principales
category(food, savory).
category(food, sweet).

% Subcategorías
category(savory, meat_dish).
category(savory, vegetarian_dish).
category(vegetarian_dish, vegan_dish).

% Asignación de comidas a categorías
belongs_to(pizza, meat_dish).
belongs_to(burger, meat_dish).
belongs_to(sushi, meat_dish).
belongs_to(hornado, meat_dish).
belongs_to(tacos, meat_dish).
belongs_to(alitas, meat_dish).
belongs_to(pasta, meat_dish).

belongs_to(salad, vegetarian_dish).
belongs_to(soup, vegetarian_dish).
belongs_to(fruit_salad, vegan_dish).
belongs_to(sandwich, vegetarian_dish).
belongs_to(cereal, vegetarian_dish).
belongs_to(hawaiian_pizza, vegetarian_dish).

belongs_to(ice_cream, sweet).
belongs_to(crepes, sweet).
belongs_to(tiramisu, sweet).
belongs_to(fruit_salad, sweet).  % también puede ser dulce

% ----------------------------
% Recursive reasoning
% ----------------------------
ancestor(Category, SubCategory) :-
    category(Category, SubCategory).

ancestor(Category, SubCategory) :-
    category(Category, Mid),
    ancestor(Mid, SubCategory).

% Relación comida → categoría raíz
food_category(Food, Category) :-
    belongs_to(Food, Category).

food_category(Food, Category) :-
    belongs_to(Food, Sub),
    ancestor(Category, Sub).
