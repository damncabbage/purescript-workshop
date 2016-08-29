module App.Play where

import Prelude hiding (div)
import Pux (EffModel, noEffects)
import Pux.Html (button, text, div, Html)
import Pux.Html.Attributes (className)
import Pux.Html.Events (onClick)
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Random (RANDOM, randomInt)
import DOM (DOM)

type State = { score :: Int }

init :: State
init = { score: 0 }

----- Exercise -----
data Action = ResetGame
            | GenerateRandom
            | ReceiveRandom Int

-- The parent component (App.Layout) was altered to expect this newly-effectful
-- update function.
update :: Action -> State -> EffModel State Action (dom :: DOM, random :: RANDOM)
update ResetGame state = noEffects init

update GenerateRandom state =
  -- TODO: Create an effect that generates a random integer, and returns a
  --       ReceiveRandom with the number.
  --       Use liftEff in front of any Eff effects you want to use.
  let resolveRandom = do
        n <- liftEff (randomInt 0 999)
        pure (ReceiveRandom n)
   in { state: state  -- Pass state through as-is.
      , effects: [ resolveRandom ]
      }

update (ReceiveRandom n) state =
  -- TODO: Replace this catch-all `update` case with one to deal with receiving
  --       the random integer, and updating the score to that value.
  noEffects (state { score = n })


view :: State -> Html Action
view state =
  div [ className "game" ]
    [ button [ onClick (\e -> GenerateRandom) ] [ text (show state.score) ]
    , button [ onClick (\e -> ResetGame) ] [ text "Reset" ]
    ]
