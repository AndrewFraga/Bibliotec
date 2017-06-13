module Login where

import Yesod
import Funcs
import Data.Text
import Foundation
import Data.Aeson.Types
import Network.HTTP.Types.Status
import Database.Persist.Postgresql

-- OPTIONS ---------------------------------------------------------------------
optionsLoginR :: Handler ()
optionsLoginR = anyOriginIn [ OPTIONS, POST ]