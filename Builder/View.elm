module Builder.View exposing (view)

import Dict
import Html exposing (Html)
import Html.Attributes as Attributes
import Html.Events as Events
import Pizza exposing (Pizza)
import Types exposing (Msg(..))
import Builder.Types
import Cart.Types


view : Maybe Pizza -> Html Msg
view pizza =
    case pizza of
        Nothing ->
            Html.map BuilderMsg baseSelector

        Just pizza ->
            pizzaBuilder pizza


baseSelector : Html Builder.Types.Msg
baseSelector =
    Html.div [] (List.map baseButton Pizza.bases)


baseButton : Pizza.Base -> Html Builder.Types.Msg
baseButton base =
    Html.button [ Events.onClick (Builder.Types.SelectBase base) ] [ Html.text base ]


changeBaseSelector : Html Builder.Types.Msg
changeBaseSelector =
    Html.div [] (List.map changeBaseButton Pizza.bases)


changeBaseButton : Pizza.Base -> Html Builder.Types.Msg
changeBaseButton base =
    Html.button [ Events.onClick (Builder.Types.ChangeBase base) ] [ Html.text base ]


pizzaBuilder : Pizza.Pizza -> Html Msg
pizzaBuilder pizza =
    Html.div []
        [ Html.map BuilderMsg changeBaseSelector
        , Html.div [] [ Html.text ("Base is " ++ pizza.base) ]
        , Html.div [] [ Html.text "Toppings are: ", Html.map BuilderMsg (displayToppings pizza) ]
        , Html.button [ Events.onClick (BuilderMsg Builder.Types.Cancel) ] [ Html.text "Cancel" ]
        , Html.button [ Events.onClick (BuilderMsg Builder.Types.ResetToppings) ] [ Html.text "Reset" ]
        , Html.button [ Events.onClick (CartMsg (Cart.Types.AddToCart pizza)) ] [ Html.text "Add to cart" ]
        ]


displayToppings : Pizza.Pizza -> Html Builder.Types.Msg
displayToppings pizza =
    htmlList (List.map (displayTopping pizza) (Dict.keys pizza.toppings))


htmlList : List (Html a) -> Html a
htmlList items =
    Html.ul [] (List.map (\item -> Html.li [] [ item ]) items)


displayTopping : Pizza.Pizza -> Pizza.Topping -> Html Builder.Types.Msg
displayTopping pizza topping =
    Html.span []
        [ Html.text (topping ++ "(")
        , removeToppingButton pizza topping
        , Html.text (Dict.get topping pizza.toppings |> Maybe.withDefault 0 |> toString)
        , addToppingButton pizza topping
        , Html.text ")"
        ]


addToppingButton : Pizza.Pizza -> Pizza.Topping -> Html Builder.Types.Msg
addToppingButton pizza topping =
    Html.button
        [ Events.onClick (Builder.Types.AddTopping topping)
        , Attributes.disabled (toppingIsAvailable pizza topping)
        ]
        [ Html.text ("+") ]


removeToppingButton : Pizza.Pizza -> Pizza.Topping -> Html Builder.Types.Msg
removeToppingButton pizza topping =
    Html.button
        [ Events.onClick (Builder.Types.RemoveTopping topping)
        , Attributes.disabled (not (Pizza.hasTopping topping pizza))
        ]
        [ Html.text "-" ]


toppingIsAvailable : Pizza.Pizza -> Pizza.Topping -> Bool
toppingIsAvailable pizza topping =
    Pizza.countTopping topping pizza >= 2 || Pizza.countAllToppings pizza >= 10
