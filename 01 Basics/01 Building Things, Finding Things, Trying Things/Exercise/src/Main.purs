module Main where

-- Import all functions and types from this "base" library.
import Prelude

-- Imports just the function called "reverse" from the Data.Array module.
import Data.Array (reverse)

-- Makes Data.String functions and types available when you prefix them
-- with, in this case, String, eg. String.joinWith
import Data.String as String


-- Let's define a function.
alwaysYes :: String -- <= A "type signature", this says it's a function that returns a value.
alwaysYes = "Yes." -- <= The function body. Exciting.
-- ... You can almost think of this as a constant. It has no
-- input, so will always return the same output.


-- More exciting: a function that takes an Int[eger] as input, and
-- returns a String as output.
sometimesYes :: Int -> String
sometimesYes x = -- Defining the function body with the argument; we've just called the argument "x".
  if x > 0
    then "Yes."
    else "No."

-- Another example: takes an Int and an Int, and returns a String.
occasionallyYes :: Int -> Int -> String
occasionallyYes n1 n2 =  -- Function body with two arguments.
  if n1 * n2 == 6
    then "Yes."
    else "No."


palindromicYes :: String -> String
palindromicYes candidate =
  -- We can define some aliases with this "let ... in ..." pattern.
  -- Define two helpers: stringToArray (takes a string, returns a string) and reversedString (ditto):
  let stringToArray  str = String.split "" str -- Calling a function and giving it an argument
      reversedString str = String.joinWith "" (reverse (stringToArray str)) -- Parens wrap the entire call.
   in if candidate == reversedString candidate
         then "Yes." -- We got ourselves a Palindrome.
         else "No."


-- Takes an Array (in the JavaScript sense) of Ints, and returns a true/false Boolean.
palindromicArray :: Array Int -> Boolean
palindromicArray xs =
  if xs == reverse xs
     then true
     else false
  -- Or just:
  -- xs == reverse xs


-- Advanced type-signature example: skip over this if you haven't used Haskell before.
-- * When writing a type annotation, the scope of the type variables must be defined
--   (https://www.reddit.com/r/purescript/comments/45ha27/why_have_explicit_universal_quantification/);
--   there's no implicit forall, unlike with Haskell.
-- * PureScript has type-classes, a lot of them with the same name you're used to.
palindromicForAllArray :: forall a. (Eq a) => Array a -> Boolean
palindromicForAllArray xs =
  xs == reverse xs
