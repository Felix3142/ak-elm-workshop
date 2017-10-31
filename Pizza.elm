module Pizza
    exposing
        ( Base
        , Topping
        , Pizza
        , addTopping
        , bases
        , toppings
        , hasTopping
        , countAllToppings
        , countTopping
        , removeTopping
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


hasTopping : Topping -> Pizza -> Bool
hasTopping topping pizza =
    Maybe.withDefault False (Maybe.map ((<) 0) (Dict.get topping pizza.toppings))


countTopping : Topping -> Pizza -> Int
countTopping topping pizza =
    Maybe.withDefault 0 (Dict.get topping pizza.toppings)


countAllToppings : Pizza -> Int
countAllToppings pizza =
    List.sum (Dict.values pizza.toppings)


removeTopping : Topping -> Pizza -> Pizza
removeTopping topping pizza =
    { pizza | toppings = Dict.update topping decrementToppingCount pizza.toppings }


decrementToppingCount : Maybe Int -> Maybe Int
decrementToppingCount maybeTopping =
    case maybeTopping of
        Nothing ->
            Just 0

        Just count ->
            Just (count - 1)


bases : List Base
bases =
    [ "Margherita", "Bianco" ]


toppings : List Topping
toppings =
    [ "Pineapple", "Spam", "Honey", "Walnuts", "Cherries", "Feta" ]
