module Builder.State exposing (initModel, update)

import Builder.Types exposing (Msg(..))
import Pizza exposing (Pizza)


initModel : Maybe Pizza
initModel =
    Nothing


update : Builder.Types.Msg -> Maybe Pizza -> Maybe Pizza
update msg model =
    case msg of
        SelectBase base ->
            Just (Pizza.new base)

        Cancel ->
            Nothing

        ChangeBase base ->
            Maybe.map (Pizza.setBase base) model

        AddTopping topping ->
            Maybe.map (Pizza.addTopping topping) model

        RemoveTopping topping ->
            Maybe.map (Pizza.removeTopping topping) model

        ResetToppings ->
            Maybe.map Pizza.resetToppings model

        SetPizza pizza ->
            Just pizza
