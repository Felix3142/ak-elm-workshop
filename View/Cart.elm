module View.Cart exposing (view)

import Html exposing (Html)
import Pizza exposing (Pizza)
import Types exposing (Msg)


view : List Pizza -> Html Msg
view pizzas =
    Html.ul [] (List.map displayPizza pizzas)


displayPizza : Pizza -> Html Msg
displayPizza pizza =
    Html.li []
        [ Html.text pizza.base
        , Html.text " ["
        , Html.text
            (String.join ", "
                (List.map
                    (\( topping, count ) -> (toString count) ++ " x " ++ topping)
                    (Pizza.getToppings pizza)
                )
            )
        , Html.text "]"
        ]
