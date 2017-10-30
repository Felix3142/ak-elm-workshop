module Main exposing (main)

import Html
import Html.Events


main : Program Never Model Msg
main =
    Html.program
        { init = initModel
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


bases : List Base
bases =
    [ "Margherita", "Bianco" ]


toppings : List Topping
toppings =
    [ "Pineapple", "Spam" ]


type alias Base =
    String


type alias Topping =
    String


type alias Pizza =
    { base : Base
    , toppings : List Topping
    }


type alias Model =
    Maybe Pizza


type Msg
    = SelectBase Base
    | AddTopping Topping


initModel : ( Model, Cmd Msg )
initModel =
    ( Nothing, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SelectBase base ->
            ( Just { base = base, toppings = [] }, Cmd.none )

        AddTopping topping ->
            ( Maybe.map (addTopping topping) model, Cmd.none )


addTopping : Topping -> Pizza -> Pizza
addTopping topping pizza =
    { pizza | toppings = List.append pizza.toppings [ topping ] }


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


baseButton : Base -> Html.Html Msg
baseButton base =
    Html.button [ Html.Events.onClick (SelectBase base) ] [ Html.text base ]


pizzaBuilder : Pizza -> Html.Html Msg
pizzaBuilder pizza =
    Html.div []
        [ Html.div [] [ Html.text ("Base is " ++ pizza.base) ]
        , Html.div [] [ Html.text ("Toppings are: " ++ (String.join ", " pizza.toppings)) ]
        , Html.div [] (List.map addToppingButton toppings)
        ]


addToppingButton : Topping -> Html.Html Msg
addToppingButton topping =
    Html.button
        [ Html.Events.onClick (AddTopping topping) ]
        [ Html.text ("Add " ++ topping) ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
