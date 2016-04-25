module Test.Main where

import Prelude
import App.Game (Hand(..), Result(..), winner)
import Control.Monad.Eff (Eff)
import Test.QuickCheck as QC
import Test.QuickCheck ((===), (/==))
import Test.QuickCheck.Arbitrary (class Arbitrary)
import Test.QuickCheck.Gen (elements)
import Test.Unit (test, runTest)
import Test.Unit.Assert (assert)
import Test.Unit.QuickCheck (quickCheck)

newtype RandomHand = RandomHand Hand
instance arbHand :: Arbitrary RandomHand where
  arbitrary = do
    h <- elements Rock [Paper, Scissors]
    pure (RandomHand h)

main :: Eff _ Unit
main = runTest do
  test "matching hands draw" do
    quickCheck match
  test "individual tests" do
    assert "🍪 > 🔪" (
      winner Rock Scissors == P1Won
    )
    assert "📜 > 🍪" (
      winner Paper Rock == P1Won
    )

match :: RandomHand -> RandomHand -> QC.Result
match (RandomHand h1) (RandomHand h2) =
  let result = winner h1 h2
   in if h1 == h2
        then result === Draw
        else result /== Draw
