module View exposing (view)

import Html exposing (div, text, button)
import Html.Events exposing (onClick)
import Types exposing (Model, Msg(..))


bases : List Types.Base
bases =
    [ "Margherita", "Bianco" ]


toppings : List Types.Topping
toppings =
    [ "Pineapple", "Spam" ]


view : Model -> Html.Html Msg
view model =
    case model of
        Nothing ->
            baseSelector

        Just pizza ->
            pizzaBuilder pizza


baseSelector : Html.Html Msg
baseSelector =
    Html.div [] (List.map baseButton bases)


baseButton : Types.Base -> Html.Html Msg
baseButton base =
    Html.button [ Html.Events.onClick (Types.SelectBase base) ] [ Html.text base ]


pizzaBuilder : Types.Pizza -> Html.Html Msg
pizzaBuilder pizza =
    Html.div []
        [ Html.div [] [ Html.text ("Base is " ++ pizza.base) ]
        , Html.div [] [ Html.text ("Toppings are: " ++ (String.join ", " pizza.toppings)) ]
        , Html.div [] (List.map addToppingButton toppings)
        ]


addToppingButton : Types.Topping -> Html.Html Msg
addToppingButton topping =
    Html.button
        [ Html.Events.onClick (Types.AddTopping topping) ]
        [ Html.text ("Add " ++ topping) ]
