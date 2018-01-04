module Builder.Types exposing (Msg(..))

import Pizza exposing (Pizza)


type Msg
    = SelectBase Pizza.Base
    | AddTopping Pizza.Topping
    | RemoveTopping Pizza.Topping
    | ResetToppings
    | ChangeBase Pizza.Base
    | Cancel
