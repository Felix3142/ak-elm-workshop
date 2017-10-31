module State exposing (initModel, update)

import Dict
import Pizza
import Types exposing (Model, Msg(..))


initModel : ( Model, Cmd Msg )
initModel =
    ( Nothing, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SelectBase base ->
            ( Just { base = base, toppings = Dict.empty }, Cmd.none )

        AddTopping topping ->
            ( Maybe.map (Pizza.addTopping topping) model, Cmd.none )
