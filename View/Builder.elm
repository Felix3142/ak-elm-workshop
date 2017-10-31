module View.Builder exposing (view)

import Dict
import Html exposing (Html)
import Html.Attributes as Attributes
import Html.Events as Events
import Pizza exposing (Pizza)
import Types exposing (Msg(..))


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
    Html.button [ Events.onClick (Types.SelectBase base) ] [ Html.text base ]


pizzaBuilder : Pizza.Pizza -> Html Msg
pizzaBuilder pizza =
    Html.div []
        [ Html.div [] [ Html.text ("Base is " ++ pizza.base) ]
        , Html.div [] [ Html.text "Toppings are: ", displayToppings pizza ]
        , Html.button [ Events.onClick (AddToCart pizza) ] [ Html.text "Add to cart" ]
        ]


displayToppings : Pizza.Pizza -> Html Msg
displayToppings pizza =
    Html.ul []
        (List.map
            (\topping -> Html.li [] [ topping ])
            (List.map (displayTopping pizza) (Dict.keys pizza.toppings))
        )


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
        [ Events.onClick (Types.AddTopping topping)
        , Attributes.disabled (toppingIsAvailable pizza topping)
        ]
        [ Html.text ("+") ]


removeToppingButton : Pizza.Pizza -> Pizza.Topping -> Html Msg
removeToppingButton pizza topping =
    Html.button
        [ Events.onClick (Types.RemoveTopping topping)
        , Attributes.disabled (not (Pizza.hasTopping topping pizza))
        ]
        [ Html.text "-" ]


toppingIsAvailable : Pizza.Pizza -> Pizza.Topping -> Bool
toppingIsAvailable pizza topping =
    Pizza.countTopping topping pizza >= 2 || Pizza.countAllToppings pizza >= 10
