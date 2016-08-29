module Main where

import Prelude
import Math as Math
import Data.Int as Int

-- We have a type called Record, and much in the same way as Maybe, it is a generalised type that has a type argument:
--   data Record a = ...

-- The argument that it takes is different: it takes a "Row" or "structural" type.
-- For example:
frank :: Record (postcode :: Int, state :: String, country :: String) -- The type
frank = {   -- How you construct an Record type.
  postcode: 2001,
  state: "NSW",
  country: "Australia"
}

-- We have an easier way to write this (using a shortcut that PureScript knows about):
kate :: { postcode :: Int, state :: String, country :: String }
kate = {
  postcode: 3001,
  state: "Vic",
  country: "Australia"
}

-- An aside for Haskellers: If you're already familiar with Kinds, there are
-- special types of Kind outside of the regular *s. For example, Record is
-- kind # * -> *, # * indicating a "row" kind. You can test this out by
-- running this with psci:
--   > :kind Record
-- And then
--   > :kind Record ( foo :: String )
-- or
--   > :kind { foo :: String }

-- Anyway.
-- We can make this easier by using a type alias, eg.
type LocationRecord = Record (postcode :: Int, state :: String, country :: String)

-- Or just (again, sugar):
type Location = { postcode :: Int, state :: String, country :: String }

sam :: Location
sam = { postcode: 4000, state: "QLD", country: "Australia" }


-- Let's make use of a record.
-- An aside: <> is an function defined in something called a Semigroup. We won't go into that here; all
-- you need to know is that it can be used to concatenate Strings, Arrays and some other things.
locationToString :: Location -> String
locationToString loc =
  -- We're using Row Labels to retrieve values from the Record (AKA Record). This only works for Records.
  (show loc.postcode) <> " " <> loc.state <> ", " <> loc.country


-- So the above example makes use of all the labels; sometimes we might not, and only need a smaller piece
-- of a larger record.
-- To indicate this, we have what's known as an "open row"; we use a type variable to indicate "some other
-- fields we don't care about", eg.
stateAndCountry :: forall theRest. Record ( state :: String, country :: String | theRest) -> String
stateAndCountry loc =
  loc.state <> ", " <> loc.country

-- And using this:
samSummary :: String
samSummary = stateAndCountry sam


-- Lastly, we've been producing records, but having them change would be a pain. This is the syntax to return a
-- new record, while only changing one or two fields:
changeState :: Location -> String -> Location
changeState loc newState = loc { state = newState }
--            The record  ==^    ^== label    ^== The new value to swap it out with.
-- Note the =, not :, when "setting" a record field.


---- Exercise -----

-- TODO: Try calling locationToString with { postcode: 4000, state: "QLD", country: "Australia" }
--       Then try calling it with { street: "Queen St", postcode: 4000, state: "QLD", country: "Australia" } and see what happens.
--       Finally, try calling stateAndCountry with { street: "Queen St", postcode: 4000, state: "QLD", country: "Australia" }
--       Note the different between locationToString's "closed" row, and stateAndCountry's "open" row.

-- TODO: Write a type alias that is an Record ({}-shorthand or not) and has two fields, x and y, both Ints. Call it Point.

-- TODO: Write a function that takes a Point and an Int, and replace the point's X value with that Int.

-- TODO: Write a function that takes two points, and calculates the distance between them, returning a Number,
--       a type representing numbers that can include a decimal point.
--       (Highschool Maths is back. Use the Data.Int and Math modules,
--        specifically Data.Int.toNumber, and Math.abs, Math.pow and Math.sqrt)
--
--      Use the "pythag" helper at the bottom of the file if you get stuck.

-- TODO: Write a function that takes an array of records containing *at least* (but not limited to)
--       a field of type Int called "x", and returns the "sum" (see Data.Foldable) of all those integers.
--       A function called "map" from the Prelude will also be useful here.


-- Give it two sides, and it'll give you back the third.
pythag :: Int -> Int -> Number
pythag n1 n2 =
  let side n = Math.pow (Math.abs (Int.toNumber n)) 2.0
   in Math.sqrt (side n1 + side n2)
