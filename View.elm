module View exposing (view)

import Html exposing (Html)
import Html.Events as Events
import Types exposing (Model, Msg)
import Builder.View
import Cart.View


view : Model -> Html Msg
view model =
    Html.div []
        [ Html.h2 [] [ Html.text "Design Your Pizza" ]
        , Builder.View.view model.newPizza
        , Html.h2 [] [ Html.text "Your Cart" ]
        , Html.button [ Events.onClick Types.ResetCart ] [ Html.text "Reset" ]
        , Cart.View.view model.cart
        ]
