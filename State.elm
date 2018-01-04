module State exposing (initModel, update)

import Types exposing (Model, Msg(..))
import Builder.State
import Cart.State


initModel : ( Model, Cmd Msg )
initModel =
    ( { newPizza = Builder.State.initModel
      , cart = Cart.State.initModel
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        BuilderMsg builderMsg ->
            let
                ( newNewPizza, maybeCartMsg ) =
                    Builder.State.update builderMsg model.newPizza

                newModel =
                    { model | newPizza = newNewPizza }
            in
                maybeCartMsg
                    |> Maybe.map (\cartMsg -> update (CartMsg cartMsg) newModel)
                    |> Maybe.withDefault ( newModel, Cmd.none )

        CartMsg cartMsg ->
            let
                ( newCart, maybeBuilderMsg ) =
                    Cart.State.update cartMsg model.cart

                newModel =
                    { model | cart = newCart }
            in
                maybeBuilderMsg
                    |> Maybe.map (\builderMsg -> update (BuilderMsg builderMsg) newModel)
                    |> Maybe.withDefault ( newModel, Cmd.none )
