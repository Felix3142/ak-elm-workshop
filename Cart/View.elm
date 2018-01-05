module Cart.View exposing (view)

import Html exposing (Html)
import Html.Events as Events
import Pizza exposing (Pizza)
import Cart.Types exposing (Msg(..))


view : List Pizza -> Html Msg
view pizzas =
    Html.ul [] (List.indexedMap displayPizza pizzas)


displayPizza : Int -> Pizza -> Html Msg
displayPizza index pizza =
    Html.li []
        [ Html.text pizza.base
        , Html.text " ["
        , Html.text
            (String.join
                ", "
                (List.map (uncurry displayTopping) (Pizza.getToppings pizza))
            )
        , Html.text "]"
        , Html.button [ Events.onClick (RemoveFromCart index) ] [ Html.text "Remove" ]
        , Html.button [ Events.onClick (AddToCart pizza) ] [ Html.text "Duplicate" ]
        , Html.button [ Events.onClick (DuplicateAndModify pizza) ] [ Html.text "Duplicate and Modify" ]
        ]


displayTopping : Pizza.Topping -> Int -> String
displayTopping topping count =
    (toString count) ++ " x " ++ topping
