module State exposing (initModel, update)

import Pizza exposing (Pizza)
import Types exposing (Model, Msg(..))


initModel : ( Model, Cmd Msg )
initModel =
    ( { newPizza = Nothing, cart = [] }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SelectBase base ->
            ( { model | newPizza = Just (Pizza.new base) }, Cmd.none )

        AddTopping topping ->
            ( updateNewPizza (Pizza.addTopping topping) model, Cmd.none )

        RemoveTopping topping ->
            ( updateNewPizza (Pizza.removeTopping topping) model, Cmd.none )

        AddToCart pizza ->
            ( { model | newPizza = Nothing, cart = pizza :: model.cart }, Cmd.none )


updateNewPizza : (Pizza -> Pizza) -> Model -> Model
updateNewPizza update model =
    { model | newPizza = Maybe.map update model.newPizza }
