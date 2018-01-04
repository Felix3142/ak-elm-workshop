module Builder.State exposing (initModel, update)

import Builder.Types exposing (Msg(..))
import Pizza exposing (Pizza)
import Cart.Types


initModel : Maybe Pizza
initModel =
    Nothing


update : Builder.Types.Msg -> Maybe Pizza -> ( Maybe Pizza, Maybe Cart.Types.Msg )
update msg maybePizza =
    case msg of
        SelectBase base ->
            ( Just (Pizza.new base), Nothing )

        Cancel ->
            ( Nothing, Nothing )

        ChangeBase base ->
            ( Maybe.map (Pizza.setBase base) maybePizza, Nothing )

        AddTopping topping ->
            ( Maybe.map (Pizza.addTopping topping) maybePizza, Nothing )

        RemoveTopping topping ->
            ( Maybe.map (Pizza.removeTopping topping) maybePizza, Nothing )

        ResetToppings ->
            ( Maybe.map Pizza.resetToppings maybePizza, Nothing )

        SetPizza pizza ->
            ( Just pizza, Nothing )

        AddToCart pizza ->
            ( Nothing, Just (Cart.Types.AddToCart pizza) )
