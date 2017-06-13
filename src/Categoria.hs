module Categoria where

import Yesod
import Funcs
import Data.Text
import Foundation
import Data.Aeson.Types
import Network.HTTP.Types.Status
import Database.Persist.Postgresql as DB

-- OPTIONS ---------------------------------------------------------------------
optionsCategoriaR :: Handler ()
optionsCategoriaR = anyOriginIn [ OPTIONS, POST ]

optionsCategoriaByIdR :: CategoriaId -> Handler ()
optionsCategoriaByIdR _ = anyOriginIn [ OPTIONS, GET, PUT, DELETE ]

optionsBuscarCategoriaR :: Text -> Handler ()
optionsBuscarCategoriaR _ = anyOriginIn [ OPTIONS, GET ]