module App.Types where

import App.Audio (WEBAUDIO)
import Control.Monad.Eff.Random (RANDOM)
import DOM (DOM)

type AppEffects =
  ( dom :: DOM
  , random :: RANDOM
  , webaudio :: WEBAUDIO
  )
