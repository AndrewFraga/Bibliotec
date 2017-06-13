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


-- GET -------------------------------------------------------------------------
getAutorByIdR :: AutorId -> Handler Value
getAutorByIdR autorId = do
    autor <- runDB $ get404 autorId
    sendStatusJSON ok200 $ object [ "resp" .= autor ]


getBuscarAutorR :: Text -> Handler Value
getBuscarAutorR pesquisa = do
    listaAutor <- runDB $ selectList [ AutorNome %=. pesquisa ] []
    sendStatusJSON ok200 $ object [ "resp" .= listaAutor ]


-- POST ------------------------------------------------------------------------
postAutorR :: Handler Value
postAutorR = do
    autor   <- requireJsonBody :: Handler Autor
    autorId <- runDB $ insert autor
    sendStatusJSON created201 $ object [ "resp" .= ( fromSqlKey autorId ) ]