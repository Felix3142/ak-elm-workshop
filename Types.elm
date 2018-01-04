module Types exposing (..)

import Pizza exposing (Pizza)
import Builder.Types
import Cart.Types


type alias Model =
    { newPizza : Maybe Pizza
    , cart : List Pizza
    }


type Msg
    = CartMsg Cart.Types.Msg
    | BuilderMsg Builder.Types.Msg
