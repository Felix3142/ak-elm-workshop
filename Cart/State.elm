module Cart.State exposing (initModel, update)

import Pizza exposing (Pizza)
import Cart.Types exposing (Msg(..))
import List.Extra
import Builder.Types


initModel : List Pizza
initModel =
    []


update : Msg -> List Pizza -> ( List Pizza, Maybe Builder.Types.Msg )
update msg cart =
    case msg of
        AddToCart pizza ->
            ( pizza :: cart, Just Builder.Types.Cancel )

        RemoveFromCart index ->
            ( List.Extra.removeAt index cart, Nothing )

        ResetCart ->
            ( [], Nothing )

        DuplicateAndModify pizza ->
            ( cart, Just (Builder.Types.SetPizza pizza) )
