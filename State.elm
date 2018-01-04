module State exposing (initModel, update)

import Pizza exposing (Pizza)
import Types exposing (Model, Msg(..))
import List.Extra
import Builder.Types
import Cart.Types


initModel : ( Model, Cmd Msg )
initModel =
    ( { newPizza = Nothing, cart = [] }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        BuilderMsg builderMsg ->
            case builderMsg of
                Builder.Types.SelectBase base ->
                    ( { model | newPizza = Just (Pizza.new base) }, Cmd.none )

                Builder.Types.Cancel ->
                    ( { model | newPizza = Nothing }, Cmd.none )

                Builder.Types.ChangeBase base ->
                    ( updateNewPizza (Pizza.setBase base) model, Cmd.none )

                Builder.Types.AddTopping topping ->
                    ( updateNewPizza (Pizza.addTopping topping) model, Cmd.none )

                Builder.Types.RemoveTopping topping ->
                    ( updateNewPizza (Pizza.removeTopping topping) model, Cmd.none )

                Builder.Types.ResetToppings ->
                    ( updateNewPizza Pizza.resetToppings model, Cmd.none )

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
