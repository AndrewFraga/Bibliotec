module Usuario where

import Yesod
import Funcs
import Data.Text
import Data.Time
import Foundation
import Data.Aeson.Types
import Network.HTTP.Types.Status
import Database.Persist.Postgresql

-- OPTIONS ---------------------------------------------------------------------
optionsUsuarioR :: Handler ()
optionsUsuarioR = anyOriginIn [ OPTIONS, POST ]

optionsUsuarioByIdR :: UsuarioId -> Handler ()
optionsUsuarioByIdR _ = anyOriginIn [ OPTIONS, GET, PATCH ]

optionsBuscarUsuarioR :: Text -> Handler ()
optionsBuscarUsuarioR _ = anyOriginIn [ OPTIONS, GET ]

-- GET -------------------------------------------------------------------------
getUsuarioByIdR :: UsuarioId -> Handler Value
getUsuarioByIdR usuarioId = do
    ( Usuario n e _ g d ) <- runDB $ get404 usuarioId
    sendStatusJSON ok200 $ object [ "resp" .= Usuario n e "" g d ]


getBuscarUsuarioR :: Text -> Handler Value
getBuscarUsuarioR pesquisa = do
    lu <- runDB $ selectList [ UsuarioNome %=. pesquisa ] []
    listaUsuario <- return $ Prelude.map (\( Entity i (Usuario n e _ g d) ) -> Entity i $ Usuario n e "" g d ) lu
    sendStatusJSON ok200 $ object [ "resp" .= listaUsuario ]