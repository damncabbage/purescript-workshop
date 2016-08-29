module Main where

import Prelude

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Random (RANDOM, randomInt)
import Control.Monad.Eff.Console (CONSOLE)


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
hasAConsoleEffect :: Eff (console :: CONSOLE) Unit
hasAConsoleEffect = do
  let value = unit -- Replace this line.
  pure value

-- TODO: Try to use someRandomInt in the function below, and see what happens:
hasARandomEffect :: Eff (random :: RANDOM) Int
hasARandomEffect = do
  let value = 5 -- Replace this line.
  pure value

-- TODO: Write a function that generates two random numbers, and
--       returns an array containing both of them.
-- twoRandomInts :: ...

-- TODO: Harder: Use Data.Unfoldable's replicateA to make a function that
--       accepts an int N, and returns an array of N random integers.
-- someRandomInts :: ...

-- TODO: Write a function that uses the console :: CONSOLE effect and returns
--       Unit, and makes use of the "log" function from Control.Monad.Eff.Console
