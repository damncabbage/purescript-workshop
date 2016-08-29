module Main where

import Prelude

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Random (RANDOM, randomInt)
import Control.Monad.Eff.Console (CONSOLE, log)
import Data.Unfoldable (replicateA)


someRandomInt :: Eff (random :: RANDOM) Int
someRandomInt = do
  num <- randomInt 0 999
  pure num
  -- This could be streamlined to:
  --   someRandomInt = randomInt 0 999
  -- I'm just showing you "pure" here to return num (a plain Int)
  -- to the Eff context.


----- Exercises -----

-- TODO: Try to use someRandomInt in the function below, and see what happens:
--
-- hasAConsoleEffect :: Eff (console :: CONSOLE) Unit
-- hasAConsoleEffect = do
--   value <- someRandomInt   <-- compiler error!
--   pure value

-- TODO: Try to use someRandomInt in the function below, and see what happens:
hasARandomEffect :: Eff (random :: RANDOM) Int
hasARandomEffect = do
  value <- someRandomInt
  pure value

-- TODO: Write a function that generates two random numbers, and
--       returns an array containing both of them.
twoRandomInts :: Eff (random :: RANDOM) (Array Int)
twoRandomInts = do
  n1 <- someRandomInt
  n2 <- someRandomInt
  pure [n1,n2]

-- TODO: Harder: Use Data.Unfoldable's replicateA to make a function that
--       accepts an int N, and returns an array of N random integers.
someRandomInts :: Int -> Eff (random :: RANDOM) (Array Int)
someRandomInts n = replicateA n someRandomInt

-- TODO: Write a function that uses the console :: CONSOLE effect and returns
--       Unit, and makes use of the "log" function from Control.Monad.Eff.Console
someLogging :: Eff (console :: CONSOLE) Unit
someLogging = do
  log "It's logging."
  log "It's some more logging."
  x <- log "I can return a value here, but it's always a Unit so it doesn't mean anything."
  log "Last log."
