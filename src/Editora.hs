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


-- GET -------------------------------------------------------------------------
getEditoraByIdR :: EditoraId -> Handler Value
getEditoraByIdR editoraId = do
    editora <- runDB $ get404 editoraId
    sendStatusJSON ok200 $ object [ "resp" .= editora ]