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

import Dict


type alias Base =
    String


type alias Topping =
    String


type alias Pizza =
    { base : Base
    , toppings : Dict.Dict Topping Int
    }


addTopping : Topping -> Pizza -> Pizza
addTopping topping pizza =
    { pizza | toppings = Dict.update topping incrementToppingCount pizza.toppings }


incrementToppingCount : Maybe Int -> Maybe Int
incrementToppingCount maybeTopping =
    case maybeTopping of
        Nothing ->
            Just 1

        Just count ->
            Just (count + 1)


countTopping : Topping -> Pizza -> Int
countTopping topping pizza =
    Maybe.withDefault 0 (Dict.get topping pizza.toppings)


countAllToppings : Pizza -> Int
countAllToppings pizza =
    List.sum (Dict.values pizza.toppings)


bases : List Base
bases =
    [ "Margherita", "Bianco" ]


toppings : List Topping
toppings =
    [ "Pineapple", "Spam", "Honey", "Walnuts", "Cherries", "Feta" ]
