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


getBuscarEditoraR :: Text -> Handler Value
getBuscarEditoraR pesquisa = do
    listaEditora <- runDB $ selectList [ EditoraNome %=. pesquisa ] []
    sendStatusJSON ok200 $ object [ "resp" .= listaEditora ]


-- POST ------------------------------------------------------------------------
postEditoraR :: Handler Value
postEditoraR = do
    editora   <- requireJsonBody :: Handler Editora
    editoraId <- runDB $ insert editora
    sendStatusJSON created201 $ object [ "resp" .= ( fromSqlKey editoraId ) ]


-- PUT -------------------------------------------------------------------------
putEditoraByIdR :: EditoraId -> Handler Value
putEditoraByIdR editoraId = do
    editora <- requireJsonBody :: Handler Editora
    runDB $ DB.replace editoraId editora
    sendStatusJSON noContent204 emptyObject


-- DELETE ----------------------------------------------------------------------
deleteEditoraByIdR :: EditoraId -> Handler Value
deleteEditoraByIdR editoraId = do
    runDB $ delete editoraId
    sendStatusJSON noContent204 emptyObject