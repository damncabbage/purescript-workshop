module App.Game
  ( Hand(..)
  , Result(..)
  , winner
  ) where

import Prelude

data Hand   = Rock | Paper | Scissors
data Result = P1Won | P2Won | Draw

derive instance eqHand   :: Eq Hand
derive instance eqResult :: Eq Result

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









-- Unfortunate debugging boilerplate:
import Data.Generic (class Generic, gShow)

derive instance genHand :: Generic Hand
derive instance genResult :: Generic Result

instance showHand :: Show Hand where
  show = gShow
instance showResult :: Show Result where
  show = gShow
