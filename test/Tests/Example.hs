{-# LANGUAGE DataKinds #-}

-- | Thid module demonstraits how to use @quickcheck-classes@ with @tasty@ for monad law tests.
module Tests.Example (tests) where

import Test.QuickCheck.Classes qualified as QCC
import Test.Tasty
import Util (laws)

tests :: [TestTree]
tests =
  [ testGroup
      "List"
      [ laws @[]
          [ QCC.functorLaws,
            QCC.applicativeLaws,
            QCC.monadLaws
          ]
      ]
  ]
