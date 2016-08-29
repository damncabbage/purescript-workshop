module App.Layout where

import App.Play as Play
import App.NotFound as NotFound
import App.Routes (Route(Home, NotFound))
import App.Types (AppEffects)
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

update :: Action -> State -> EffModel State Action AppEffects
update (PageView route)  state =
  noEffects (state { route = route })
update (PlayGame action) state =
  noEffects (state { game = Play.update action state.game })

view :: State -> Html Action
view state =
  main [] [
    case state.route of
      NotFound -> NotFound.view state
      Home ->
        div [ className "game-container" ]
          [ h1 [] [ text "Hello World" ]
          , forwardTo PlayGame (Play.view state.game)
          ]
  ]
