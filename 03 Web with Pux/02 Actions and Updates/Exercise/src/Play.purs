module App.Play where

import Prelude hiding (div)
import Pux.Html (text, div, Html)
import Pux.Html.Attributes (className)

type State = { score :: Int }

init :: State
init = { score: 0 }

----- Exercise -----
-- TODO: Fill out this sum-type with two actions: Win and ResetGame
data Action = Todo

-- TODO: Use pattern matching to:
--       a) reset the score on ResetGame
--       b) increment the score on Win
update :: Action -> State -> State
update action state = state

view :: State -> Html Action
view state =
  -- TODO: Add two clickable buttons (using "button" and "onClick" from Pux.Html),
  --       one to Win, the other to ResetGame.
  div [ className "game" ]
    [ text ("An integer: " <> show state.score)
    ]
