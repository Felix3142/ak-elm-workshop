module View exposing (view)

import Html exposing (Html)
import Types exposing (Model, Msg)
import View.Builder
import View.Cart


view : Model -> Html Msg
view model =
    Html.div []
        [ Html.h2 [] [ Html.text "Design Your Pizza" ]
        , View.Builder.view model.newPizza
        , Html.h2 [] [ Html.text "Your Cart" ]
        , View.Cart.view model.cart
        ]
