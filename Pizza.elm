module Pizza
    exposing
        ( Base
        , Topping
        , Pizza
        , addTopping
        , bases
        , toppings
        , countAllToppings
        , countTopping
        )


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


countTopping : Topping -> Pizza -> Int
countTopping topping pizza =
    List.length (List.filter ((==) topping) pizza.toppings)


countAllToppings : Pizza -> Int
countAllToppings pizza =
    List.length pizza.toppings


bases : List Base
bases =
    [ "Margherita", "Bianco" ]


toppings : List Topping
toppings =
    [ "Pineapple", "Spam", "Honey", "Walnuts", "Cherries", "Feta" ]
