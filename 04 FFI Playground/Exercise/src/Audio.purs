module App.Audio where

import Prelude
import Control.Monad.Eff (Eff)
import Data.Function (Fn3, runFn3)
import DOM (DOM)

---- Bogus Examples ----

-- Some dummy examples that have nothing to do with audio,
-- but just introduce the FFI.

-- Import function matching the exports.leftPad name.
-- Get the name right, tell PS the type sig, and...
foreign import leftPad :: String -> Int -> String -> String
-- ... just like that.

-- Easier for JS...
foreign import easierLeftPad :: Fn3 String Int String String -- Three args and a return value
-- Harder for PS.
useEasierLeftPad :: String -> Int -> String -> String
useEasierLeftPad s i c = runFn3 easierLeftPad s i c
                 -- "Fully Saturated" functions like this (specifying
                 -- all inputs) currently makes things easier to optimise.



----- WebAudio -----

-- Invent an effect type. This is another Kind type; there are * and ! (Effect), and
-- the row constructor # (eg. # * or # !).
foreign import data WEBAUDIO :: ! -- Loud like the speaker you're about to overload.

-- Invent a type representing an "AudioContext" object.
foreign import data AudioContext :: * -- Just a regular type.

-- Two AudioContext operations: creating it (in a web browser
-- window, requiring DOM and WEBAUDIO) ...
foreign import createWindowAudioContext ::
  forall eff. Eff (dom :: DOM, webaudio :: WEBAUDIO | eff) AudioContext

-- ... And destroying it (only needs the WEBAUDIO effect).
foreign import closeAudioContext ::
  forall eff. AudioContext -> Eff (webaudio :: WEBAUDIO | eff) Unit

-- Plays a frequency then runs a callback with the AudioContext.
-- This is manual-continuation stuff; there's room here to convert all these to Aff.
foreign import playFreq
  :: forall eff. AudioContext
  -> Number
  -> (AudioContext -> Eff (webaudio :: WEBAUDIO | eff) Unit)
  -> Eff (webaudio :: WEBAUDIO | eff) Unit


playHigh :: forall eff. Eff (dom :: DOM, webaudio :: WEBAUDIO | eff) Unit
playHigh = createWindowAudioContext >>= \c ->
             playFreq c 391.99543598174995 closeAudioContext --

playMid  :: forall eff. Eff (dom :: DOM, webaudio :: WEBAUDIO  | eff) Unit
playMid = createWindowAudioContext >>= \c ->
            playFreq c 261.62556530059896 closeAudioContext -- C3

playLow  :: forall eff. Eff (dom :: DOM, webaudio :: WEBAUDIO  | eff) Unit
playLow = createWindowAudioContext >>= \c ->
            playFreq c 164.81377845643513 closeAudioContext -- E2
