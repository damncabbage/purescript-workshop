module App.Types where

import Control.Monad.Eff.Random (RANDOM)
import DOM (DOM)

type AppEffects = (dom :: DOM, random :: RANDOM)
