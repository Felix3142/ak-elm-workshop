module Types exposing (..)

import Pizza


type alias Model =
    Maybe Pizza.Pizza


type Msg
    = SelectBase Pizza.Base
    | AddTopping Pizza.Topping
