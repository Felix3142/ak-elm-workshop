module View exposing (view)

import Html exposing (Html)
import Html.Events as Events
import Types exposing (Model, Msg(BuilderMsg, CartMsg))
import Builder.View
import Cart.View
import Cart.Types


view : Model -> Html Msg
view model =
    Html.div []
        [ Html.h2 [] [ Html.text "Design Your Pizza" ]
        , Html.map BuilderMsg (Builder.View.view model.newPizza)
        , Html.h2 [] [ Html.text "Your Cart" ]
        , Html.button [ Events.onClick (CartMsg Cart.Types.ResetCart) ] [ Html.text "Reset" ]
        , Html.map CartMsg (Cart.View.view model.cart)
        ]
