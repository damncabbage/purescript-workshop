module Main where

import Prelude

addsOne :: Int -> Int
addsOne x = x + 1

multipliesAndAddsOne :: Int -> Int -> String
multipliesAndAddsOne x y = addsOne (x * y)
