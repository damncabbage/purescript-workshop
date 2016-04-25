module Main where

import Prelude

-- An example type declaration:
data TrafficLight = Red | Yellow | Green

-- Something returning a value from that type:
stoppedColour :: TrafficLight
stoppedColour = Red

-- And something using it with "pattern-matching":
shouldBrake :: TrafficLight -> Boolean
shouldBrake Red    = true
shouldBrake Yellow = true
shouldBrake Green  = false


-- Rock Paper Scissors Exercise:
-- Come up with constructors to represent a choice of Rock, Paper or Scissors
-- and a game result of a P1 win, a P2 win, or a Draw.

-- TODO: Fill these out.
data Hand   = ToDo
data Result = AlsoToDo

-- TODO: Write this function:
-- winner :: Hand -> Hand -> Result










-- Ignore all the below; this is boilerplate to let you use
-- your custom types in psci, and with any luck should go away
-- shortly.
-- (Haskellers: PureScript doesn't yet have a "... deriving (Show)"
--  equivalent, only Generic, Eq and Ord. This piggy-backs off
--  Data.Generic's gShow :: forall a. (Generic a) => a -> String
--  function.)
import Data.Generic (class Generic, gShow)
derive instance genericTrafficLight :: Generic TrafficLight
derive instance genericHand :: Generic Hand
derive instance genericResult :: Generic Result
instance showTrafficLight :: Show TrafficLight where
  show = gShow
instance showHand :: Show Hand where
  show = gShow
instance showResult :: Show Result where
  show = gShow
