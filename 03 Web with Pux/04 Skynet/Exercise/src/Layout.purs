module App.Layout where

import App.Play as Play
import App.Routes (Route(Home, NotFound))
import App.Types (AppEffects)
import App.Utils (effectfulChild)
import Pux (noEffects, EffModel)
import Pux.Html (forwardTo, Html, div, h1, text)
import Pux.Html.Attributes (className)
import Pux.Html.Elements (main)

data Action = PlayGame (Play.Action)
            | PageView Route

type State = { route :: Route
             , game :: Play.State
             }

init :: State
init = { route: NotFound
       , game: Play.init
       }

update :: forall eff. Action -> State -> EffModel State Action (AppEffects eff)
update (PageView route)  state =
  noEffects (state { route = route })
update (PlayGame action) state =
  effectfulChild (\r -> state { game = r}) PlayGame
                 (Play.update action state.game)

view :: State -> Html Action
view state =
  main [] [
    case state.route of
      NotFound -> App.NotFound.view state
      Home ->
        div [ className "game-container" ]
          [ h1 [] [ text "Rock Paper Scissors" ]
          , forwardTo PlayGame (Play.view state.game)
          ]
  ]
