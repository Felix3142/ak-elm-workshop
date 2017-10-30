module Main exposing (main)

import Html
import State
import Types exposing (..)
import View


main : Program Never Model Msg
main =
    Html.program
        { init = State.initModel
        , view = View.view
        , update = State.update
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
