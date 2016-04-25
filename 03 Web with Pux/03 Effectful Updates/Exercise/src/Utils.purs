module App.Utils
  ( effectfulChild
  ) where

import Prelude
import Pux (EffModel, mapEffects, mapState)

-- | This replaces this repeated example:
-- | ```
-- | update (PlayGame action) state = let result = Play.update action state.game
-- |                                  in { state:   state { game = result.state }
-- |                                     , effects: map (map PlayGame) result.effects
-- |                                     }
-- | ```
-- | ... With:
-- | ```
-- | update (PlayGame action) state =
-- |   effectfulChild (\r -> state { game = r}) PlayGame
-- |                  (Play.update action state.game)
-- | ```
effectfulChild :: forall sa sb a b e.
                  (sa -> sb)
               -> (a -> b)
               -> EffModel sa a e
               -> EffModel sb b e
effectfulChild a2b action effmodel = mapState a2b <<< mapEffects action $ effmodel
