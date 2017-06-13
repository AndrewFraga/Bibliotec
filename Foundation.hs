module Foundation where

import Yesod
import Data.Time
import Yesod.Static
import Data.Text as T
import Database.Persist.Postgresql

data App = App { getStatic :: Static
               , connPool  :: ConnectionPool
               }

share [mkPersist sqlSettings, mkMigrate "migrateAll"][persistLowerCase|

    Genero json
        nome Text
        UniqueGenero nome
    
    Usuario json
        nome            Text
        email           Text
        senha           Text
        genero          GeneroId
        dataNascimento  Day
        UniqueEmail email
    
    Aluguel json
        usuario   UsuarioId
        livro     LivroId
        retirada  Day
        saida     Bool
        previsao  Day
        devolucao Day Maybe
        renovacao Bool
        
    Livro json
        titulo     Text
        edicao     Int
        ano        Int
        editora    EditoraId
        paginas    Int 
        descricao  Text
        quantidade Int
    
    CategoriaLivro json
        categoria CategoriaId
        livro     LivroId
        Primary categoria livro
    
    Categoria json
        nome Text
        UniqueCategoria nome
    
    AutorLivro json
        autor AutorId
        livro LivroId
        Primary autor livro
    
    Autor json
        nome Text
        descricao Text
        UniqueAutor nome
    
    Editora json
        nome Text
        UniqueEditora nome
|]

staticFiles "static"

mkYesodData "App" $(parseRoutesFile "routes")

instance Yesod App where

instance YesodPersist App where
   type YesodPersistBackend App = SqlBackend
   runDB f = do
       master <- getYesod
       let pool = connPool master
       runSqlPool f pool