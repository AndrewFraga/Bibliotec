module Livro where

import Yesod
import Funcs
import Imagem
import Foundation
import Data.Text as T
import Data.Aeson.Types
import Network.HTTP.Types.Status
import Database.Persist.Postgresql as DB

-- OPTIONS ---------------------------------------------------------------------
optionsLivroR :: Handler ()
optionsLivroR = anyOriginIn [ OPTIONS, POST ]

optionsLivroByIdR :: LivroId -> Handler ()
optionsLivroByIdR _ = anyOriginIn [ OPTIONS, GET, PUT, DELETE ]

optionsBuscarLivroIdR :: Text -> Handler ()
optionsBuscarLivroIdR _ = anyOriginIn [ OPTIONS, GET ]

optionsQtLivroAlugadoByIdR :: LivroId -> Handler ()
optionsQtLivroAlugadoByIdR _ = anyOriginIn [ OPTIONS, GET ]

optionsBuscarLivroIdByCategoriaIdR :: CategoriaId -> Handler ()
optionsBuscarLivroIdByCategoriaIdR _ = anyOriginIn [ OPTIONS, GET ]

optionsBuscarLivroIdByAutorIdR :: AutorId -> Handler ()
optionsBuscarLivroIdByAutorIdR _ = anyOriginIn [ OPTIONS, GET ]

-- GET -------------------------------------------------------------------------
getLivroByIdR :: LivroId -> Handler Value
getLivroByIdR livroId = do
    livro <- runDB $ get404 livroId
    
    listaAutorLivro <- runDB $ selectList [ AutorLivroLivro ==. livroId ] []
    listaAutorId    <- return $ Prelude.map ( autorLivroAutor.entityVal ) listaAutorLivro
    
    listaCategoriaLivro <- runDB $ selectList [ CategoriaLivroLivro ==. livroId ] []
    listaCategoriaId    <- return $ Prelude.map ( categoriaLivroCategoria.entityVal ) listaCategoriaLivro
    
    sendStatusJSON ok200 $ object [ "resp" .= ( livro, listaAutorId, listaCategoriaId ) ]


getBuscarLivroIdR :: Text -> Handler Value
getBuscarLivroIdR pesquisa = do
    listaLivro   <- runDB $ selectList [ LivroTitulo %=. pesquisa] []
    listaLivroId <- return $ Prelude.map entityKey listaLivro
    sendStatusJSON ok200 $ object [ "resp" .= listaLivroId ]


getQtLivroAlugadoByIdR :: LivroId -> Handler Value
getQtLivroAlugadoByIdR livroId = do
    qtAluguelAbertoLivro <- runDB $ DB.count [ AluguelLivro     ==. livroId
                                             , AluguelDevolucao ==. Nothing
                                             ]
    sendStatusJSON ok200 $ object [ "resp" .= qtAluguelAbertoLivro ]


getBuscarLivroIdByCategoriaIdR :: CategoriaId -> Handler Value
getBuscarLivroIdByCategoriaIdR categoriaId = do
    listaCategoriaLivro <- runDB $ selectList [ CategoriaLivroCategoria ==. categoriaId ] []
    listaLivroId <- return $ Prelude.map ( categoriaLivroLivro.entityVal ) listaCategoriaLivro
    sendStatusJSON ok200 $ object [ "resp" .= listaLivroId ]


getBuscarLivroIdByAutorIdR :: AutorId -> Handler Value
getBuscarLivroIdByAutorIdR autorId = do
    listaAutorLivro <- runDB $ selectList [ AutorLivroAutor ==. autorId ] []
    listaLivroId <- return $ Prelude.map ( autorLivroLivro.entityVal ) listaAutorLivro
    sendStatusJSON ok200 $ object [ "resp" .= listaLivroId ]


-- POST ------------------------------------------------------------------------
postLivroR :: Handler Value
postLivroR = do
    (livro, imagem, listaCategoria, listaAutor) <- requireJsonBody :: Handler ( Livro
                                                                              , Text
                                                                              , [ CategoriaId ]
                                                                              , [ AutorId ]
                                                                              )
    livroId <- runDB $ insert livro
    mapM_ ( \categoriaLivro -> runDB $ insert $ CategoriaLivro categoriaLivro livroId ) listaCategoria
    mapM_ ( \autorLivro -> runDB $ insert $ AutorLivro autorLivro livroId ) listaAutor
    liftIO $ writeToServer imagem (show $ fromSqlKey livroId)
    sendStatusJSON created201 $ object [ "resp" .= ( fromSqlKey livroId ) ]


-- PUT -------------------------------------------------------------------------
putLivroByIdR :: LivroId -> Handler Value
putLivroByIdR livroId = do
    livro <- requireJsonBody :: Handler Livro
    runDB $ DB.replace livroId livro
    sendStatusJSON noContent204 emptyObject


-- DELETE ----------------------------------------------------------------------
deleteLivroByIdR :: LivroId -> Handler Value
deleteLivroByIdR livroId = do
    runDB $ delete livroId
    sendStatusJSON noContent204 emptyObject