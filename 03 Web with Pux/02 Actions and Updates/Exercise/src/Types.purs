module App.Types where

import Control.Monad.Eff.Console (CONSOLE)
import DOM (DOM)

type AppEffects = (dom :: DOM, console :: CONSOLE)
