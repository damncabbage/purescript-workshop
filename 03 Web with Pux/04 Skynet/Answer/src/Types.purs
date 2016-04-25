module App.Types where

import Control.Monad.Eff.Console (CONSOLE)
import Control.Monad.Eff.Random (RANDOM)
import DOM (DOM)

type AppEffects eff = (dom :: DOM, console :: CONSOLE, random :: RANDOM | eff)
