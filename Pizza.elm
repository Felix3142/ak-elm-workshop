module Pizza
    exposing
        ( Base
        , Topping
        , Pizza
        , addTopping
        , bases
        , toppings
        , new
        , hasTopping
        , countAllToppings
        , countTopping
        , getToppings
        , removeTopping
        )

import Dict exposing (Dict)


type alias Base =
    String


type alias Topping =
    String


type alias Pizza =
    { base : Base
    , toppings : Dict Topping Int
    }


new : Base -> Pizza
new base =
    { base = base, toppings = newToppings }


newToppings : Dict Topping Int
newToppings =
    List.foldr (\topping result -> Dict.insert topping 0 result) Dict.empty toppings


addTopping : Topping -> Pizza -> Pizza
addTopping topping pizza =
    { pizza | toppings = Dict.update topping incrementToppingCount pizza.toppings }


incrementToppingCount : Maybe Int -> Maybe Int
incrementToppingCount =
    applyWithDefault 1 ((+) 1)


hasTopping : Topping -> Pizza -> Bool
hasTopping topping =
    .toppings
        >> Dict.get topping
        >> Maybe.map ((<) 0)
        >> Maybe.withDefault False


countTopping : Topping -> Pizza -> Int
countTopping topping =
    .toppings
        >> Dict.get topping
        >> Maybe.withDefault 0


countAllToppings : Pizza -> Int
countAllToppings =
    .toppings >> Dict.values >> List.sum


getToppings : Pizza -> List ( Topping, Int )
getToppings =
    .toppings
        >> Dict.filter (\_ count -> count > 0)
        >> Dict.map (,)
        >> Dict.values


removeTopping : Topping -> Pizza -> Pizza
removeTopping topping pizza =
    { pizza | toppings = Dict.update topping decrementToppingCount pizza.toppings }


decrementToppingCount : Maybe Int -> Maybe Int
decrementToppingCount =
    applyWithDefault 0 (\x -> x - 1)


applyWithDefault : b -> (a -> b) -> Maybe a -> Maybe b
applyWithDefault default fn =
    Maybe.map fn >> Maybe.withDefault default >> Just


bases : List Base
bases =
    [ "Margherita", "Bianco" ]


toppings : List Topping
toppings =
    [ "Pineapple", "Spam", "Honey", "Walnuts", "Cherries", "Feta" ]
