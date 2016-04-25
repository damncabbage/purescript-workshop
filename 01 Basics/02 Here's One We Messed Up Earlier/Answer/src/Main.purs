module Main where

import Prelude

addsOne :: Int -> Int
addsOne x = x + 1

multipliesAndAddsOne :: Int -> Int -> Int -- <= Changed "... -> String" to "... -> Int".
multipliesAndAddsOne x y = addsOne (x * y)

-- [1/1 TypesDoNotUnify] src/Main.purs:9:28
--
--   9  multipliesAndAddsOne x y = addsOne (x * y)
--                                 ^^^^^^^^^^^^^^
--
--   Could not match type
--     Int
--
--   with type
--     String
