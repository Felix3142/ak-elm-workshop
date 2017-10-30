module Pizza exposing (Base, Topping, Pizza, addTopping, bases, toppings)


type alias Base =
    String


type alias Topping =
    String


type alias Pizza =
    { base : Base
    , toppings : List Topping
    }


addTopping : Topping -> Pizza -> Pizza
addTopping topping pizza =
    { pizza | toppings = List.append pizza.toppings [ topping ] }


bases : List Base
bases =
    [ "Margherita", "Bianco" ]


toppings : List Topping
toppings =
    [ "Pineapple", "Spam" ]
