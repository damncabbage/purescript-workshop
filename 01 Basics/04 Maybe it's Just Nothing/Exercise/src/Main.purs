module Main where

import Prelude
import Data.Generic (class Generic, gShow) -- Ignore this line.
import Data.Array as Array
import Data.Maybe (Maybe(..))


-- From earlier.
data Hand   = Rock | Paper | Scissors
data Result = P1Won | P2Won | Draw


-- An example type declaration:
data MaybeThrown = NotThrown | Thrown Hand
--   ^== The type.   ^===========^========= The values.

-- Producing a MaybeThrown value:
throwByTheNumbers :: Int -> MaybeThrown -- Int -> our new type
throwByTheNumbers 1 = Thrown Rock -- Constructing a value; Thrown takes one argumnet
throwByTheNumbers 2 = Thrown Paper
throwByTheNumbers 3 = Thrown Scissors
throwByTheNumbers hand = NotThrown -- Constructing a value, but NotThrown takes _no_ arguments.

-- Interpreting a MaybeThrown value:
hasThrown :: MaybeThrown -> Boolean
hasThrown (Thrown choice) = true   -- Pull it apart again; here, choice is a Hand, eg. Rock
hasThrown NotThrown       = false


-- A type you've seen before:
--   data Array a = ...
-- eg. from 01 Basic/01 Finding Things, Trying ...:
--   palindromicArray :: Array Int -> Boolean
--
-- It takes a Type Argument. You can have many of them, but let's just stick to one.

-- An example of it in use:
someNumbers :: Array Int
someNumbers = [1,2,3]

someStrings :: Array String
someStrings = ["hello", "world"]

-- In the same way, we can generalise MaybeThrown from earlier:
--
--   data Maybe a = Nothing | Just a
--
-- This already exists, and is being imported at the top of the module. :-)


-- Lastly, those "type variable" you saw above can also show up in functions.
-- Take the following function:
identity :: forall a. a -> a
identity x = x
-- It simply takes a value and returns it.
-- The type signature here is interesting; it says that this function needs to work
-- "for all possible As". With no further information about what that can be, the
-- only thing we can do here is return the value.
-- We can't return a String or an Int or anything; we can't make a value that fits this!

-- This function is similar:
getFirst :: forall a b. a -> b -> a
getFirst a b = a
-- For all possible As, and for all possible Bs (which may be the same or different, we can't know),
-- define a function that takes an A, a B, and returns an A. There's again only one way to implement this.

-- (This is a concept called "Parametricity", and will be important later.)



---- Exercise ----
-- TODO: Write throwByTheNumbers and hasThrown again, except using the general Maybe type with Hand.

-- throwByTheNumbersV2 :: ...
-- hasThrownV2 :: ...


-- TODO: Write a function that takes an Array of hands, and returns a Hand. 
--       Use `Array.last` to get the last hand, otherwise return Rock.
--       (Good ol' Rock.)
-- You'll find the docs for the "last" function in devdocs/Data.Array.md

-- lastOrRock :: ...


-- TODO: Write a function that takes three arguments, of three potentially-different types,
--       and returns the second.

-- getSecond :: ...




-- -------------------------------------- --
-- -------------------------------------- --
-- Ignore all the below; this is boilerplate to let you use
-- your custom types in psci, and with any luck should go away
-- shortly.
derive instance genericHand :: Generic Hand
derive instance genericResult :: Generic Result
instance showHand :: Show Hand where
  show = gShow
instance showResult :: Show Result where
  show = gShow
