module Builder.View exposing (view)

import Dict
import Html exposing (Html)
import Html.Attributes as Attributes
import Html.Events as Events
import Pizza exposing (Pizza)
import Builder.Types exposing (Msg(..))


view : Maybe Pizza -> Html Msg
view pizza =
    case pizza of
        Nothing ->
            baseSelector

        Just pizza ->
            pizzaBuilder pizza


baseSelector : Html Msg
baseSelector =
    Html.div [] (List.map baseButton Pizza.bases)


baseButton : Pizza.Base -> Html Msg
baseButton base =
    Html.button [ Events.onClick (SelectBase base) ] [ Html.text base ]


changeBaseSelector : Html Msg
changeBaseSelector =
    Html.div [] (List.map changeBaseButton Pizza.bases)


changeBaseButton : Pizza.Base -> Html Msg
changeBaseButton base =
    Html.button [ Events.onClick (ChangeBase base) ] [ Html.text base ]


pizzaBuilder : Pizza.Pizza -> Html Msg
pizzaBuilder pizza =
    Html.div []
        [ changeBaseSelector
        , Html.div [] [ Html.text ("Base is " ++ pizza.base) ]
        , Html.div [] [ Html.text "Toppings are: ", (displayToppings pizza) ]
        , Html.button [ Events.onClick Cancel ] [ Html.text "Cancel" ]
        , Html.button [ Events.onClick ResetToppings ] [ Html.text "Reset" ]
        , Html.button [ Events.onClick (AddToCart pizza) ] [ Html.text "Add to cart" ]
        ]


displayToppings : Pizza.Pizza -> Html Msg
displayToppings pizza =
    htmlList (List.map (displayTopping pizza) (Dict.keys pizza.toppings))


htmlList : List (Html a) -> Html a
htmlList items =
    Html.ul [] (List.map (\item -> Html.li [] [ item ]) items)


displayTopping : Pizza.Pizza -> Pizza.Topping -> Html Msg
displayTopping pizza topping =
    Html.span []
        [ Html.text (topping ++ "(")
        , removeToppingButton pizza topping
        , Html.text (Dict.get topping pizza.toppings |> Maybe.withDefault 0 |> toString)
        , addToppingButton pizza topping
        , Html.text ")"
        ]


addToppingButton : Pizza.Pizza -> Pizza.Topping -> Html Msg
addToppingButton pizza topping =
    Html.button
        [ Events.onClick (AddTopping topping)
        , Attributes.disabled (toppingIsAvailable pizza topping)
        ]
        [ Html.text ("+") ]


removeToppingButton : Pizza.Pizza -> Pizza.Topping -> Html Msg
removeToppingButton pizza topping =
    Html.button
        [ Events.onClick (RemoveTopping topping)
        , Attributes.disabled (not (Pizza.hasTopping topping pizza))
        ]
        [ Html.text "-" ]


toppingIsAvailable : Pizza.Pizza -> Pizza.Topping -> Bool
toppingIsAvailable pizza topping =
    Pizza.countTopping topping pizza >= 2 || Pizza.countAllToppings pizza >= 10
