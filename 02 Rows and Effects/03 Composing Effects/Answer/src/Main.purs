module Main where

import Prelude

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Random (RANDOM, randomInt)
import Control.Monad.Eff.Console (CONSOLE, log)
import Data.Array (replicateM)


someRandomInts :: Int -> Eff (random :: RANDOM) (Array Int)
someRandomInts n =
  replicateM n (randomInt 0 999)

someLogging :: String -> Eff (console :: CONSOLE) Unit
someLogging x = do
  log x
  log (x <> x)
  log (x <> x <> x)


----- Exercise -----

-- TODO: Try uncommenting the log and/or random lines and see what happens.
wrapper1 :: forall e. Eff e Unit
wrapper1 = do
  -- someLogging "A String"
  -- nums <- someRandomInts 5
  pure unit

-- In short: we haven't specified any specific effects, and so no effect-expecting
-- functions can be used.


-- TODO: Try uncommenting the log AND random lines and see what happens.
wrapper2 :: Eff (console :: CONSOLE, random :: RANDOM) Unit
wrapper2 = do
  -- someLogging "A String"
  -- nums <- someRandomInts 5
  pure unit

-- The answer: even though wrapper2 itself says it supports CONSOLE and RANDOM effects,
-- the actual someLogging / someRandomInts functions themselves will only work
-- in an Eff (...) ... where the effect is *only* CONSOLE or RANDOM.

-- Here's a more permissive someRandomInts function, using the "Open Row" feature from
-- last exercise:

openRandomInts :: forall eff. Int -> Eff (random :: RANDOM | eff) (Array Int)
openRandomInts n =
  replicateM n (randomInt 0 999)

-- TODO: Write an openLogging function using an open effect row, uncomment its use below,
--       and see what happens.
openLogging :: forall eff. String -> Eff (console :: CONSOLE | eff) Unit
openLogging x = do
  log x
  log (x <> x)
  log (x <> x <> x)

wrapper3 :: Eff (console :: CONSOLE, random :: RANDOM) Unit
wrapper3 = do
  openLogging "A String"
  nums <- openRandomInts 5
  pure unit


-- Lastly, the wrapper function itself should likely be an open row, so we can then use that
-- as part of a larger piece of an application.
wrapper4 :: forall eff. Eff (console :: CONSOLE, random :: RANDOM | eff) Unit
wrapper4 = do
  openLogging "A String"
  nums <- openRandomInts 5
  pure unit
