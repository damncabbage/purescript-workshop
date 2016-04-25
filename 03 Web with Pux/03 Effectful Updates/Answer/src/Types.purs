module App.Types where

import Control.Monad.Eff.Console (CONSOLE)
import Control.Monad.Eff.Random (RANDOM, randomInt)
import DOM (DOM)

type AppEffects eff = (random :: RANDOM, dom :: DOM, console :: CONSOLE | eff)
