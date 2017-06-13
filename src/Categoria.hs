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


-- GET -------------------------------------------------------------------------
getCategoriaByIdR :: CategoriaId -> Handler Value
getCategoriaByIdR categoriaId = do
    categoria <- runDB $ get404 categoriaId
    sendStatusJSON ok200 $ object [ "resp" .= categoria ]


getBuscarCategoriaR :: Text -> Handler Value
getBuscarCategoriaR pesquisa = do
    listaCategoria <- runDB $ selectList [ CategoriaNome %=. pesquisa ] []
    sendStatusJSON ok200 $ object [ "resp" .= listaCategoria ]


-- POST ------------------------------------------------------------------------
postCategoriaR :: Handler Value
postCategoriaR = do
    categoria   <- requireJsonBody :: Handler Categoria
    categoriaId <- runDB $ insert categoria
    sendStatusJSON created201 $ object [ "resp" .= ( fromSqlKey categoriaId ) ]


-- PUT -------------------------------------------------------------------------
putCategoriaByIdR :: CategoriaId -> Handler Value
putCategoriaByIdR categoriaId = do
    categoria <- requireJsonBody :: Handler Categoria
    runDB $ DB.replace categoriaId categoria
    sendStatusJSON noContent204 emptyObject