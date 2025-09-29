# Example queries and their results

## Example 1. Show all registered foods

?- show\_all\_food.


All foods: \[pizza,hawaiian\_pizza,salad,hornado,burger,sushi,tacos,pasta,soup,fruit\_salad,cereal,ice\_cream,sandwich,crepes,tiramisu,alitas]
true.

## Example 2. Ask if something is vegetarian

?- is\_vegetarian(salad).


true.

### Example 2.1.

?- is\_vegetarian(burguer).


false.

## Example 3. Ask for vegan foods

?- vegan(X).


X = fruit\_salad ;
X = salad

## Example 4. Query which foods contain meat

?- contains\_meat(X).


X = pizza ;
X = burger ;
X = sushi ;
X = pasta ;
X = hornado ;
X = tacos ;
X = alitas

## Example 5. Query which foods are sweet

?- sweet(X).


X = ice\_cream ;
X = fruit\_salad ;
X = crepes ;
X = tiramisu.

## Example 6. Use of recursion

?- food\_category(fruit\_salad, C).


C = vegan\_dish ;
C = sweet ;
C = vegetarian\_dish ;
C = food ;
C = savory ;
C = food ;

## Example 7. Recommendation system

?- recommend\_food(L).


Do you want meat? (yes/no):
|: yes.
Is it for breakfast? (yes/no):
|: no.
Is it for lunch? (yes/no):
|: yes.
Is it for dinner? (yes/no):
|: no.
Do you prefer something sweet? (yes/no):
|: no.
Based on your answers, you could try: \[alitas,burger,hornado,pasta,pizza,sushi,tacos]
L = \[alitas, burger, hornado, pasta, pizza, sushi, tacos].

