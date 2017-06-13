module Editora where

import Yesod
import Funcs
import Data.Text
import Foundation
import Data.Aeson.Types
import Network.HTTP.Types.Status
import Database.Persist.Postgresql as DB

-- OPTIONS ---------------------------------------------------------------------
optionsEditoraR :: Handler ()
optionsEditoraR = anyOriginIn [ OPTIONS, POST ]

optionsEditoraByIdR :: EditoraId -> Handler ()
optionsEditoraByIdR _ = anyOriginIn [ OPTIONS, GET, PUT, DELETE ]

optionsBuscarEditoraR :: Text -> Handler ()
optionsBuscarEditoraR _ = anyOriginIn [ OPTIONS, GET ]