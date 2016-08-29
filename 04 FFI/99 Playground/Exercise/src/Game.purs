module App.Game where

----- Exercise -----
-- Go down to "AI" below:

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Random (randomInt, RANDOM)
import Data.Array (last)
import Data.Maybe (maybe)
import Data.Generic (class Generic, gShow)

data Hand   = Rock  | Paper | Scissors
data Result = P1Won | P2Won | Draw
derive instance eqHand   :: Eq Hand   -- Makes Hand and Result
derive instance eqResult :: Eq Result -- comparable with ==

type PlayerPair a = { p1 :: a, p2 :: a }
type Round        = PlayerPair Hand

winner :: Hand -> Hand -> Result
winner h1 h2 = case h1, h2 of
  Rock, Rock         -> Draw
  Rock, Paper        -> P2Won
  Rock, Scissors     -> P1Won
  Paper, Rock        -> P1Won
  Paper, Paper       -> Draw
  Paper, Scissors    -> P2Won
  Scissors, Rock     -> P2Won
  Scissors, Paper    -> P1Won
  Scissors, Scissors -> Draw

----- Misc Helpers -----

-- | A quick helper for a common P1 + P2 structure
playerPair :: forall a. a -> a -> PlayerPair a
playerPair a b = { p1: a, p2: b }

-- Could be used to make a shrunk "winner" function.
-- As it is, it's just being used in the AIs detailed below.
beats :: Hand -> Hand
beats h = case h of
  Rock     -> Paper
  Paper    -> Scissors
  Scissors -> Rock

-- | Choose a random Hand. This is an Effectful function, as a random
-- | number generator is dependent on (and change) external state.
randomHand :: forall eff. Eff (random :: RANDOM | eff) Hand
randomHand = do
  n <- randomInt 1 3
  pure $ case n of
    1 -> Rock
    2 -> Paper
    _ -> Scissors

----- AI -----

-- | A type alias for convenience; all the effectful AI functions are going to match it.
type AI eff = Array Round -> Eff (random :: RANDOM | eff) Hand

-- | Random AI: Randomly picks a hand, ignoring the past.
randomAI :: forall eff. AI eff
randomAI _ = randomHand

-- TODO: Use this to swap between different AI bots; just replace randomAI
--       with skynetAI or whatever.
currentAI :: forall eff. AI eff
currentAI = randomAI

-- TODO: Make some computer players. You have access to the play history, and a random
--       number generator. :-)

-- | Beats-Last AI: Picks whatever beats the opponent's last hand choice.
beatsLastAI :: forall eff. AI eff
beatsLastAI rounds =
  let chooseHand lr = pure (beats lr.p1)
   in maybe randomHand chooseHand (last rounds)

-- | The ArsTechnica-detailed AI; see http://arstechnica.com/science/2014/05/win-at-rock-paper-scissors-by-knowing-thy-opponent/
-- | A summary of its "AI" rules:
-- | * First round? Random hand.
-- | * If we won, play our opponent's hand.
-- | * If they won, play what would've just beaten our hand.
arsAI :: forall eff. AI eff
arsAI rounds =
  let chooseHand lr = case winner lr.p1 lr.p2 of
                        Draw  -> randomHand
                        P1Won -> pure lr.p1 -- HACK: Everything in this game is making the assumption that P1 is human
                        P2Won -> pure (beats lr.p2)
   in maybe randomHand chooseHand (last rounds)



----- Unfortunate debugging boilerplate: -----
derive instance genHand :: Generic Hand
derive instance genResult :: Generic Result
instance showHand :: Show Hand where
  show = gShow
instance showResult :: Show Result where
  show = gShow
