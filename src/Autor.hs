module Autor where

import Yesod
import Funcs
import Data.Text as T
import Foundation
import Data.Aeson.Types
import Network.HTTP.Types.Status
import Database.Persist.Postgresql as DB

-- OPTIONS ---------------------------------------------------------------------
optionsAutorR :: Handler ()
optionsAutorR = anyOriginIn [ OPTIONS, POST ]

optionsAutorByIdR :: AutorId -> Handler ()
optionsAutorByIdR _ = anyOriginIn [ OPTIONS, GET, PUT, DELETE ]

optionsBuscarAutorR :: Text -> Handler ()
optionsBuscarAutorR _ = anyOriginIn [ OPTIONS, GET ]