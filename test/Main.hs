module Main (main) where

import Test.Tasty (defaultMain, testGroup)
import Tests.Example qualified

main :: IO ()
main =
  defaultMain
    . testGroup "toplevel"
    $ [ testGroup "Example" Tests.Example.tests
      ]
