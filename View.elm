module View exposing (view)

import Html exposing (div, text, button)
import Html.Attributes
import Html.Events exposing (onClick)
import Pizza
import Types exposing (Model, Msg(..))


view : Model -> Html.Html Msg
view model =
    case model of
        Nothing ->
            baseSelector

        Just pizza ->
            pizzaBuilder pizza


baseSelector : Html.Html Msg
baseSelector =
    Html.div [] (List.map baseButton Pizza.bases)


baseButton : Pizza.Base -> Html.Html Msg
baseButton base =
    Html.button [ Html.Events.onClick (Types.SelectBase base) ] [ Html.text base ]


pizzaBuilder : Pizza.Pizza -> Html.Html Msg
pizzaBuilder pizza =
    Html.div []
        [ Html.div [] [ Html.text ("Base is " ++ pizza.base) ]
        , Html.div [] [ Html.text ("Toppings are: " ++ (String.join ", " pizza.toppings)) ]
        , Html.div [] (List.map (addToppingButton pizza) Pizza.toppings)
        ]


addToppingButton : Pizza.Pizza -> Pizza.Topping -> Html.Html Msg
addToppingButton pizza topping =
    Html.button
        [ Html.Events.onClick (Types.AddTopping topping)
        , Html.Attributes.disabled (Pizza.countTopping topping pizza == 2)
        ]
        [ Html.text ("Add " ++ topping) ]
