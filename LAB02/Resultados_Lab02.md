# Example Queries and Their Results

## Example 1. Show all registered foods
```prolog
?- show_all_food.

All foods: [pizza, hawaiian_pizza, salad, hornado, burger, sushi, tacos, pasta, soup, fruit_salad, cereal, ice_cream, sandwich, crepes, tiramisu, alitas]
true.
```

## Example 2. Ask if something is vegetarian
```prolog
?- is_vegetarian(salad).

true.
```

### Example 2.1
```prolog
?- is_vegetarian(burguer).

false.
```

## Example 3. Ask for vegan foods
```prolog
?- vegan(X).

X = fruit_salad ;
X = salad
```

## Example 4. Query which foods contain meat
```prolog
?- contains_meat(X).

X = pizza ;
X = burger ;
X = sushi ;
X = pasta ;
X = hornado ;
X = tacos ;
X = alitas
```

## Example 5. Query which foods are sweet

```prolog
?- sweet(X).

X = ice_cream ;
X = fruit_salad ;
X = crepes ;
X = tiramisu.
```

## Example 6. Use of recursion
```prolog
?- food_category(fruit_salad, C).

C = vegan_dish ;
C = sweet ;
C = vegetarian_dish ;
C = food ;
C = savory ;
C = food ;
```

## Example 7. Recommendation system
```prolog
?- recommend_food(L).

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
Based on your answers, you could try: [alitas, burger, hornado, pasta, pizza, sushi, tacos]
L = [alitas, burger, hornado, pasta, pizza, sushi, tacos].
