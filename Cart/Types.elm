module Cart.Types exposing (Msg(..))

import Pizza exposing (Pizza)


type Msg
    = AddToCart Pizza
    | RemoveFromCart Int
    | ResetCart
    | DuplicateAndModify Pizza
