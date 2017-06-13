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
--------------------------------------------------------------------------------
 
postLoginR :: Handler Value
postLoginR = do
    (email, senha) <- requireJsonBody :: Handler (Text, Text)
    usuario        <- runDB $ selectFirst [ UsuarioEmail ==. email
                                          , UsuarioSenha ==. senha
                                          ] []
    case usuario of
        Nothing -> sendStatusJSON unauthorized401 emptyObject
        Just (Entity uid _) -> sendStatusJSON ok200 (object [ "resp" .= (fromSqlKey uid) ])