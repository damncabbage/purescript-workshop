module App.Play where

import App.Game (Result(..), Hand(..), Round, winner, currentAI)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Random (RANDOM)
import DOM (DOM)
import Data.Array (reverse, concat)
import Data.Maybe (maybe, Maybe(..))
import Pux (EffModel, noEffects)
import Pux.Html (h2, p, button, text, div, Html)
import Pux.Html.Attributes (className)
import Pux.Html.Events (onClick)
import Prelude hiding (div)

------ State ------
type State = { scores       :: { p1 :: Int, p2 :: Int }
             , rounds       :: Array Round
             , currentRound :: Maybe { result :: Result
                                     , round :: Round }
             }

init :: State
init = { scores: { p1: 0, p2: 0 }
       , rounds: []
       , currentRound: Nothing
       }

------ Actions and Updating ------
data Action = Throw Hand
            | CalculateResult Hand Hand
            | ResetGame
            | None

update :: forall eff. Action -> State -> EffModel State Action (dom :: DOM, random :: RANDOM | eff)
update None           state = noEffects state
update ResetGame      state = noEffects init
update (Throw p1Hand) state = {
    state: state,
    effects: [ do
      p2Hand <- liftEff (currentAI state.rounds)
      pure (CalculateResult p1Hand p2Hand)
    ]
  }
update (CalculateResult p1Hand p2Hand) state =
  let gameResult = winner p1Hand p2Hand
      handPair   = { p1: p1Hand, p2: p2Hand }
      scoreFromResult p1 p2 =
        case gameResult of
          Draw  -> { p1: p1,     p2: p2    }
          P1Won -> { p1: p1 + 1, p2: p2    }
          P2Won -> { p1: p1,     p2: p2 + 1}
   in { state:
        state { currentRound =
                  Just { result: gameResult
                       , round: handPair
                       }
              , rounds =
                  state.rounds <> [ handPair ]
              , scores =
                  (scoreFromResult state.scores.p1 state.scores.p2)
              }
      , effects: [ do
          liftEff $ case gameResult of
                      Draw  -> playMid
                      P1Won -> playHigh
                      P2Won -> playLow
          pure None
        ]
      }


------ View, to produce HTML ------
view :: State -> Html Action
view state =
  div [ className "game" ]
    [ div [ className "play"]
      [ div [ className "selections" ]
          ( map (\o ->
              button [ onClick (\_ -> Throw o.action) ]
                     [ text o.label ]
            ) options
          )
      , div [ className "scoreboard"]
          [ div [ className "score me" ] [ text ("😃 " <> show state.scores.p1) ]
          , div [ className "score ai" ] [ text ("💻 " <> show state.scores.p2) ]
          ]
      , div [ className "results" ]
          ( maybe []
              (\r -> [ p [] [ text ("You threw: " <> (handToIcon r.round.p1)) ]
                     , p [] [ text ("AI threw: "  <> (handToIcon r.round.p2)) ]
                     , p [] [ text ("Result: "    <> (resultToText r.result)) ]
                     ]
              )
              state.currentRound
          )
      ]
    , div [ className "previous-rounds" ] (concat [
        [ h2 [] [ text "Previous Rounds "
                , button [ onClick (\_ -> ResetGame) ]
                         [ text "Reset Game" ]
                ]
        ] <>
        ( map (\r ->
            p [] [ text (
              "😃: "   <> handToIcon r.p1 <>
              ", 💻: " <> handToIcon r.p2 <>
              " => "   <> resultToText (winner r.p1 r.p2)
            )]
          ) (reverse state.rounds)
        )
      ])
    ]
  where
    options = map (\h -> { action: h, label: handToIcon h })
                  [ Rock, Paper, Scissors ]
    handToIcon h = case h of
                      Rock     -> "🍪"
                      Paper    -> "📰"
                      Scissors -> "🔪"
    resultToText r = case r of
                      P1Won -> "✅ You Won"
                      P2Won -> "❌ AI Won"
                      Draw  -> "💅 Draw"

------ Helpers ------
foreign import playHigh :: forall eff. Eff (dom :: DOM | eff) Unit
foreign import playMid  :: forall eff. Eff (dom :: DOM | eff) Unit
foreign import playLow  :: forall eff. Eff (dom :: DOM | eff) Unit
