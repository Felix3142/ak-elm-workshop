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

        DuplicateAndModify pizza ->
            ( { model | newPizza = Just pizza }, Cmd.none )

        AddTopping topping ->
            ( updateNewPizza (Pizza.addTopping topping) model, Cmd.none )

        RemoveTopping topping ->
            ( updateNewPizza (Pizza.removeTopping topping) model, Cmd.none )

        ResetToppings ->
            ( updateNewPizza (Pizza.resetToppings) model, Cmd.none )

        AddToCart pizza ->
            ( { model | newPizza = Nothing, cart = pizza :: model.cart }, Cmd.none )

        RemoveFromCart index ->
            ( { model | cart = removeFromList index model.cart }, Cmd.none )

        ResetCart ->
            ( { model | newPizza = Nothing, cart = [] }, Cmd.none )


updateNewPizza : (Pizza -> Pizza) -> Model -> Model
updateNewPizza update model =
    { model | newPizza = Maybe.map update model.newPizza }


removeFromList : Int -> List a -> List a
removeFromList i xs =
    (List.take i xs) ++ (List.drop (i + 1) xs)
