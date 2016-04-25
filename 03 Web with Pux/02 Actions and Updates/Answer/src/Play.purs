module App.Play where

import Prelude hiding (div)
import Pux.Html (button, text, div, Html)
import Pux.Html.Events (onClick)
import Pux.Html.Attributes (className)

type State = { score :: Int }

init :: State
init = { score: 0 }

----- Exercise -----
-- TODO: Fill out this sum-type with two actions: Win and ResetGame
data Action = ResetGame
            | Win

-- TODO: Use pattern matching to:
--       a) reset the score on ResetGame
--       b) increment the score on Win
update :: Action -> State -> State
update ResetGame state = init
update Win       state = state { score = state.score + 1 }

view :: State -> Html Action
view state =
  -- TODO: Add two clickable buttons (using "button" and "onClick" from Pux.Html),
  --       one to Win, the other to ResetGame.
  div [ className "game" ]
    [ button [ onClick (\e -> Win) ] [ text (show state.score) ]
    , button [ onClick (\e -> ResetGame) ] [ text "Reset" ]
    ]
