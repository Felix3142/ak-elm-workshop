module Types exposing (..)


type alias Base =
    String


type alias Topping =
    String


type alias Pizza =
    { base : Base
    , toppings : List Topping
    }


type alias Model =
    Maybe Pizza


type Msg
    = SelectBase Base
    | AddTopping Topping
