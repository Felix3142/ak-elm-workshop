module View exposing (view)

import Dict
import Html
import Html.Attributes
import Html.Events
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
        , Html.div []
            [ Html.ul [] (List.map (addToppingButton pizza) Pizza.toppings) ]
        , Html.div [] [ Html.text "Toppings are: ", displayToppings pizza ]
        ]


displayToppings : Pizza.Pizza -> Html.Html Msg
displayToppings pizza =
    Html.div []
        (List.map
            (\topping -> Html.li [] [ topping ])
            (List.map (displayTopping pizza) (Dict.keys pizza.toppings))
        )


displayTopping : Pizza.Pizza -> Pizza.Topping -> Html.Html Msg
displayTopping pizza topping =
    Html.span []
        [ Html.text (topping ++ "(")
        , Html.text (toString (Maybe.withDefault 0 (Dict.get topping pizza.toppings)))
        , removeToppingButton pizza topping
        , Html.text ")"
        ]


addToppingButton : Pizza.Pizza -> Pizza.Topping -> Html.Html Msg
addToppingButton pizza topping =
    Html.button
        [ Html.Events.onClick (Types.AddTopping topping)
        , Html.Attributes.disabled (toppingIsAvailable pizza topping)
        ]
        [ Html.text ("Add " ++ topping) ]


removeToppingButton : Pizza.Pizza -> Pizza.Topping -> Html.Html Msg
removeToppingButton pizza topping =
    Html.button
        [ Html.Events.onClick (Types.RemoveTopping topping)
        , Html.Attributes.disabled (not (Pizza.hasTopping topping pizza))
        ]
        [ Html.text "-" ]


toppingIsAvailable : Pizza.Pizza -> Pizza.Topping -> Bool
toppingIsAvailable pizza topping =
    Pizza.countTopping topping pizza >= 2 || Pizza.countAllToppings pizza >= 10
