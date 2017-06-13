module Aluguel where

import Yesod
import Funcs
import Foundation
import Data.Time
import Data.Aeson.Types
import Network.HTTP.Types.Status
--import Database.Persist.Postgresql

-- OPTIONS ---------------------------------------------------------------------
optionsAluguelR :: Handler ()
optionsAluguelR = anyOriginIn [ OPTIONS, POST ]
    
optionsAluguelByIdR :: AluguelId -> Handler ()
optionsAluguelByIdR _ = anyOriginIn [ OPTIONS, GET, DELETE ]

optionsBuscarAluguelByUsuarioIdR :: UsuarioId -> Handler ()
optionsBuscarAluguelByUsuarioIdR _ = anyOriginIn [ OPTIONS, GET ]
    
optionsBuscarAluguelByLivroIdR :: LivroId -> Handler ()
optionsBuscarAluguelByLivroIdR _ = anyOriginIn [ OPTIONS, GET ]

optionsBuscarAluguelByDateR :: Day -> Day -> Handler ()
optionsBuscarAluguelByDateR _ _ = anyOriginIn [ OPTIONS, GET ]

optionsBuscarAluguelByUsuarioIdDateR :: UsuarioId -> Day -> Day -> Handler ()
optionsBuscarAluguelByUsuarioIdDateR _ _ _ = anyOriginIn [ OPTIONS, GET ]

optionsBuscarAluguelByLivroIdDateR :: LivroId -> Day -> Day -> Handler ()
optionsBuscarAluguelByLivroIdDateR _ _ _ = anyOriginIn [ OPTIONS, GET ]

optionsDevolucaoAluguelByIdR :: AluguelId -> Handler ()
optionsDevolucaoAluguelByIdR _ = anyOriginIn [ OPTIONS, PATCH ]

optionsSaidaAluguelByIdR :: AluguelId -> Handler ()
optionsSaidaAluguelByIdR _ = anyOriginIn [ OPTIONS, PATCH ]

optionsRenovacaoAluguelByIdR :: AluguelId -> Handler ()
optionsRenovacaoAluguelByIdR _ = anyOriginIn [ OPTIONS, PATCH ]


-- GET -------------------------------------------------------------------------
getAluguelByIdR :: AluguelId -> Handler Value
getAluguelByIdR aluguelId = do
    aluguel <- runDB $ get404 aluguelId
    sendStatusJSON ok200 $ object [ "resp" .= aluguel ]


getBuscarAluguelByUsuarioIdR :: UsuarioId -> Handler Value
getBuscarAluguelByUsuarioIdR usuarioId = do
    listaAluguelUsuario <- runDB $ selectList [ AluguelUsuario ==. usuarioId ]
                                              [ Desc AluguelRetirada ]
    sendStatusJSON ok200 $ object [ "resp" .= listaAluguelUsuario ]


getBuscarAluguelByLivroIdR :: LivroId -> Handler Value
getBuscarAluguelByLivroIdR livroid = do
    listaAluguelLivro <- runDB $ selectList [ AluguelLivro ==. livroid ]
                                            [ Desc AluguelRetirada ]
    sendStatusJSON ok200 $ object [ "resp" .= listaAluguelLivro ]


getBuscarAluguelByDateR :: Day -> Day -> Handler Value
getBuscarAluguelByDateR inicio fim = do
    listaAluguelByDate <- runDB $ selectList [ AluguelRetirada >=. inicio
                                             , AluguelRetirada <=. fim
                                             ] []
    sendStatusJSON ok200 $ object [ "resp" .= listaAluguelByDate ]


getBuscarAluguelByUsuarioIdDateR :: UsuarioId -> Day -> Day -> Handler Value
getBuscarAluguelByUsuarioIdDateR usuarioId inicio fim = do
    listaAluguelUsuarioByDate <- runDB $ selectList [ AluguelRetirada >=. inicio
                                                    , AluguelRetirada <=. fim
                                                    , AluguelUsuario  ==. usuarioId
                                                    ] []
    sendStatusJSON ok200 $ object [ "resp" .= listaAluguelUsuarioByDate ]


getBuscarAluguelByLivroIdDateR :: LivroId -> Day -> Day -> Handler Value
getBuscarAluguelByLivroIdDateR livroid inicio fim = do
    listaAluguelLivroByDate <- runDB $ selectList [ AluguelRetirada >=. inicio
                                                  , AluguelRetirada <=. fim
                                                  , AluguelLivro    ==. livroid
                                                  ] []
    sendStatusJSON ok200 $ object [ "resp" .= listaAluguelLivroByDate ]


-- POST ------------------------------------------------------------------------
postAluguelR :: Handler Value
postAluguelR = do
    aluguel   <- requireJsonBody :: Handler Aluguel
    aluguelId <- runDB $ insert aluguel
    sendStatusJSON created201 $ object [ "resp" .= aluguelId ]


-- PATCH -----------------------------------------------------------------------
patchDevolucaoAluguelByIdR :: AluguelId -> Handler Value
patchDevolucaoAluguelByIdR aluguelId = do
    currentDate <- liftIO $ getCurrentTime
    runDB $ update aluguelId [ AluguelDevolucao =. ( Just $ utctDay currentDate ) ]
    sendStatusJSON noContent204 emptyObject


patchSaidaAluguelByIdR :: AluguelId -> Handler Value
patchSaidaAluguelByIdR aluguelId = do
    runDB $ update aluguelId [ AluguelSaida =. True ]
    sendStatusJSON noContent204 emptyObject


patchRenovacaoAluguelByIdR :: AluguelId -> Handler Value
patchRenovacaoAluguelByIdR aluguelId = do
    aluguel <- runDB $ get404 aluguelId 
    runDB $ update aluguelId [ AluguelRenovacao =. True
                             , AluguelPrevisao  =. ( addDays 15 $ aluguelPrevisao aluguel)
                             ]
    sendStatusJSON noContent204 emptyObject


-- DELETE ----------------------------------------------------------------------
deleteAluguelByIdR :: AluguelId -> Handler Value
deleteAluguelByIdR aluguelId = do
    runDB $ delete aluguelId
    sendStatusJSON noContent204 emptyObject