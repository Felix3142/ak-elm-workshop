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
            Builder.State.update builderMsg model.newPizza
                |> updateModel (\value -> { model | newPizza = value })
                |> updateMsg CartMsg
                |> runNextUpdate

        CartMsg cartMsg ->
            Cart.State.update cartMsg model.cart
                |> updateModel (\value -> { model | cart = value })
                |> updateMsg BuilderMsg
                |> runNextUpdate


updateModel : (value -> Model) -> ( value, Maybe msg ) -> ( Model, Maybe msg )
updateModel valueToModel ( value, msg ) =
    ( valueToModel value, msg )


updateMsg : (msg -> Msg) -> ( Model, Maybe msg ) -> ( Model, Maybe Msg )
updateMsg msgToMsg ( model, msg ) =
    ( model, Maybe.map msgToMsg msg )


runNextUpdate : ( Model, Maybe Msg ) -> ( Model, Cmd Msg )
runNextUpdate ( model, maybeMsg ) =
    case maybeMsg of
        Just innerMsg ->
            update innerMsg model

        Nothing ->
            ( model, Cmd.none )
