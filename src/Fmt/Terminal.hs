module Fmt.Terminal
    ( colorF
    , colorVividF
    , module ANSIColors
    ) where

import           Fmt                       (Buildable, Builder, build)
import           Data.Monoid               ((<>))
import qualified System.Console.ANSI       as ANSI
import           System.Console.ANSI.Types as ANSIColors (Color (..))

-- | Wrap content with escape sequence to set and reset color of normal intensity.
colorF :: Buildable a => ANSI.Color -> a -> Builder
colorF = colorF' ANSI.Dull

-- | The same as `colorF` but uses vivid intensity.
colorVividF :: Buildable a => ANSI.Color -> a -> Builder
colorVividF = colorF' ANSI.Vivid

colorF' :: Buildable a => ANSI.ColorIntensity -> ANSI.Color -> a -> Builder
colorF' intensity color content
   = (build $ ANSI.setSGRCode [ANSI.SetColor ANSI.Foreground intensity color])
  <> (build content)
  <> (build $ ANSI.setSGRCode [ANSI.Reset])
