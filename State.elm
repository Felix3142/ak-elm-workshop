module State exposing (initModel, update)

import Pizza
import Types exposing (Model, Msg(..))


initModel : ( Model, Cmd Msg )
initModel =
    ( Nothing, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SelectBase base ->
            ( Just (Pizza.new base), Cmd.none )

        AddTopping topping ->
            ( Maybe.map (Pizza.addTopping topping) model, Cmd.none )

        RemoveTopping topping ->
            ( Maybe.map (Pizza.removeTopping topping) model, Cmd.none )
