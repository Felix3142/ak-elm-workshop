module View exposing (view)

import Dict exposing (Dict)
import Html exposing (Html)
import Html.Attributes as Attributes
import Html.Events as Events
import Pizza exposing (Pizza)
import Types exposing (Model, Msg(..))


view : Model -> Html Msg
view model =
    Html.div []
        [ Html.h2 [] [ Html.text "Design Your Pizza" ]
        , viewPizzaBuilder model.newPizza
        , Html.h2 [] [ Html.text "Your Cart" ]
        , viewCart model.cart
        ]


viewPizzaBuilder : Maybe Pizza -> Html Msg
viewPizzaBuilder pizza =
    case pizza of
        Nothing ->
            baseSelector

        Just pizza ->
            pizzaBuilder pizza


viewCart : List Pizza -> Html Msg
viewCart pizzas =
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
