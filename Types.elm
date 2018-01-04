module Types exposing (..)

import Pizza exposing (Pizza)


type alias Model =
    { newPizza : Maybe Pizza
    , cart : List Pizza
    }


type Msg
    = SelectBase Pizza.Base
    | AddTopping Pizza.Topping
    | RemoveTopping Pizza.Topping
    | ResetToppings
    | AddToCart Pizza
    | RemoveFromCart Int
    | ResetCart
    | DuplicateAndModify Pizza
    | ChangeBase
