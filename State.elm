module State exposing (initModel, update)

import Pizza exposing (Pizza)
import Types exposing (Model, Msg(..))
import List.Extra
import Builder.State
import Cart.Types


initModel : ( Model, Cmd Msg )
initModel =
    ( { newPizza = Builder.State.initModel, cart = [] }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        BuilderMsg builderMsg ->
            ( { model | newPizza = Builder.State.update builderMsg model.newPizza }, Cmd.none )

        CartMsg cartMsg ->
            case cartMsg of
                Cart.Types.AddToCart pizza ->
                    ( { model | newPizza = Nothing, cart = pizza :: model.cart }, Cmd.none )

                Cart.Types.RemoveFromCart index ->
                    ( { model | cart = List.Extra.removeAt index model.cart }, Cmd.none )

                Cart.Types.ResetCart ->
                    ( { model | newPizza = Nothing, cart = [] }, Cmd.none )

                Cart.Types.DuplicateAndModify pizza ->
                    ( { model | newPizza = Just pizza }, Cmd.none )


updateNewPizza : (Pizza -> Pizza) -> Model -> Model
updateNewPizza update model =
    { model | newPizza = Maybe.map update model.newPizza }
