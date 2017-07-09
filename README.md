![alt text](https://github.com/AndrewFraga/Bibliotec/blob/master/static/logo.png "Logo Bibliotec")

> Bibliotec é uma API REST para o gerenciamento de uma biblioteca.
  Suas principais funcionalidades são:
    - teste
    - asd

| Rotas                                        | Descrição                                                             | Métodos HTTP              |
|----------------------------------------------|-----------------------------------------------------------------------|:-------------------------:|
| /aluguel                                     | Efetua o registro de um novo aluguel.                                 | OPTIONS  POST             |
| /aluguel/#AluguelId                          | Busca ou deleta um aluguel.                                           | OPTIONS  GET  DELETE      |
| /buscar/aluguel/usuario/#UsuarioId           | Busca todos os aluguéis de um usuário.                                | OPTIONS  GET              |
| /buscar/aluguel/livro/#LivroId               | Busca todos os aluguéis de um livro.                                  | OPTIONS  GET              |
| /buscar/aluguel/#Day/#Day                    | Busca todos os aluguéis efetuados em um período de tempo.             | OPTIONS  GET              |
| /buscar/aluguel/usuario/#UsuarioId/#Day/#Day | Busca todos os aluguéis efetuados por um usuario em período de tempo. | OPTIONS  GET              |
| /buscar/aluguel/livro/#LivroId/#Day/#Day     | Busca todos os aluguéis de um livro efetuados em período de tempo.    | OPTIONS  GET              |
| /devolucao/aluguel/#AluguelId                | Efetua a devolução de um aluguel.                                     | OPTIONS  PATCH            |
| /saida/aluguel/#AluguelId                    | Efetua a saida de um aluguel.                                         | OPTIONS  PATCH            |
| /renovacao/aluguel/#AluguelId                | Efetua a renaovação de um aluguel.                                    | OPTIONS  PATCH            |
| /autor                                       | Efetua o registro de um novo autor.                                   | OPTIONS  POST             |
| /autor/#AutorId                              | Busca, altera e deleta um autor.                                      | OPTIONS  GET  PUT  DELETE |
| /buscar/autor/#Text                          | Busca autores, a partir de uma pesquisa, com base em seus nomes.      | OPTIONS  GET              |
| /categoria                                   | Efetua o registro de uma nova categoria.                              | OPTIONS  POST             |
| /categoria/#CategoriaId                      | Busca, altera e deleta uma categoria.                                 | OPTIONS  GET  PUT  DELETE |
| /buscar/categoria/#Text                      | Busca categorias, a partir de uma pesquisa, com base em seus nomes.   | OPTIONS  GET              |
| /editora                                     | Efetua o registro de uma nova editora.                                | OPTIONS  POST             |
| /editora/#EditoraId                          | Busca, altera e deleta uma editora.                                   | OPTIONS  GET  PUT  DELETE |
| /buscar/editora/#Text                        | Busca editoras, a partir de uma pesquisa, com base em seus nomes.     | OPTIONS  GET              |
| /livro                                       | Efetua o registro de um novo livro.                                   | OPTIONS  POST             |
| /livro/#LivroId                              | Busca, altera e deleta um livro.                                      | OPTIONS  GET  PUT  DELETE |
| /buscar/livro/#Text                          | Busca livros, a partir de uma pesquisa, com base em seus nomes.       | OPTIONS  GET              |
| /qt/livro/alugado/#LivroId                   | Busca a quantidade de exemplares, que estão alugados, de  um livro.   | OPTIONS  GET              |
| /buscar/livro/categoria/#CategoriaId         | Busca todos os livros de uma categoria.                               | OPTIONS  GET              |
| /buscar/livro/autor/#AutorId                 | Busca todos os livros de um autor.                                    | OPTIONS  GET              |
| /usuario                                     | Efetua o registro de um novo usuario.                                 | OPTIONS  POST             |
| /usuario/#UsuarioId                          | Busca e altera um usuário.                                            | OPTIONS  GET  PATCH       |
| /buscar/usuario/#Text                        | Busca usuários, a partir de uma pesquisa, com base em seus nomes.     | OPTIONS  GET              |
| /login                                       | Verifica se o usuario e senha existem no banco de dados.              | OPTIONS  POST             |
| /static/                                     | Acesso as imagens do servidor.                                        | GET                       |

## EDITORA
#### Cadastra Editora
    curl -X POST localhost:8080/editora -d '{"nome": "Rocco"}' -H "accept: application/json"
 
#### Listar Editora por nome
    curl -X GET localhost:8080/buscar/editora/ro -H "accept: application/json"
 
    
## CATEGORIA
#### Seleciona categoria
    curl -X GET localhost:8080/categoria/1 -H "accept: application/json"
 
#### Seleciona categoria por nome
    curl -X GET localhost:8080/buscar/categoria/ficção -H "accept: application/json"
 
#### Altera um categoria
    curl -X PUT localhost:8080/categoria/1 -d '{"nome": "Ficção e Fantasia"}' -H "accept: application/json"
 
#### Deleta uma categoria
    curl -X DELETE localhost:8080/categoria/1 -H "accept: application/json"

    
## AUTOR
#### Cadastrar autor
    curl -X POST localhost:8080/autor -d '{"nome": "J. K. Rowling", "descricao": "J. K. Rowling, é uma escritora, roteirista e produtora cinematográfica britânica, notória por escrever a série de livros Harry Potter."}' -H "accept: application/json"

#### Buscar autor
    curl -X GET localhost:8080/autor/1 -H "accept: application/json"

#### Buscar autor por nome
    curl -X GET localhost:8080/buscar/autor/rowling -H "accept: application/json"

#### Alterar autor
    curl -X PUT localhost:8080/autor/1 -d '{"nome": "Joanne K. Rowling", "descricao": "J. K. Rowling, é uma escritora, roteirista e produtora cinematográfica britânica, notória por escrever a série de livros Harry Potter."}' -H "accept: application/json"

#### Deletar autor
    curl -X DELETE localhost:8080/autor/4 -H "accept: application/json"

    
## USUARIO
#### Cadastrar usuário
    curl -X POST localhost:8080/usuario -d '{"nome": "Mateus Vilione Braz Lima", "email": "mateus@gmail.com", "senha": "123", "genero": 1, "dataNascimento": "1995-08-09"}' -H "accept: application/json"

#### Selecionar usuário
    curl -X GET localhost:8080/usuario/1 -H "accept: application/json"

    curl -X GET localhost:8080/buscar/usuario/an -H "accept: application/json"

#### Alterar usuário
curl -X PATCH localhost:8080/usuario/1 -d '["Andre Fraga", 1, "1999-11-20"]' -H "accept: application/json"


## Livro
#### Cadastrar livro
    curl -X POST localhost:8080/livro -d '[{"titulo": "Harry Potter e a Pedra Filosofal", "edicao": 1, "ano": 1999, "editora": 5, "paginas": 255, "descricao": "O livro conta a história de Harry Potter, um garoto órfão criado por seus tios que descobre em seu aniversário de onze anos que é um bruxo. ", "quantidade": 77}, "<Imagem em base64>",[3,4],[2]]' -H "accept: application/json"


#### Buscar livro por nome
    curl -X GET localhost:8080/buscar/livro/ha -H "accept: application/json"

    
#### Alterar livro
    curl -X POST localhost:8080/livro -d '[{"titulo": "Harry Potter e a Pedra Filosofal", "edicao": 1, "ano": 1999, "editora": 5, "paginas": 255, "descricao": "O livro conta a história de Harry Potter, um garoto órfão criado por seus tios que descobre em seu aniversário de onze anos que é um bruxo. ", "quantidade": 77}, "<Imagem em base64>",[3,4],[2]]' -H "accept: application/json"

    
## Aluguel
#### Cadastrar aluguel
    curl -X POST localhost:8080/aluguel -d '{"usuario": 1, "livro": 1, "retirada": "2017-06-08", "saida": false, "previsao": "2017-06-23", "devolucao": null, "renovacao": false}' -H "accept: application/json"

#### Buscar aluguel por periodo de tempo
    curl -X GET localhost:8080/buscar/aluguel/2017-05-01/2017-06-08 -H "accept: application/json"

#### Buscar aluguel por periodo de tempo e usuário
    curl -X GET localhost:8080/buscar/aluguel/usuario/1/2017-05-01/2017-06-08 -H "accept: application/json"

#### Buscar aluguel por periodo de tempo e livro
    curl -X GET localhost:8080/buscar/aluguel/livro/1/2017-05-01/2017-06-08 -H "accept: application/json"

#### Devolução do livro
    curl -X PATCH localhost:8080/devolucao/aluguel/1 -H "accept: application/json"
#### Confirmar saída do livro
    curl -X PATCH localhost:8080/saida/aluguel/1 -H "accept: application/json"

#### Renovar aluguel
    curl -X PATCH localhost:8080/renovacao/aluguel/1 -H "accept: application/json"




# Funções do Usuário

#### Selecionar um usuário por ID
~~~haskell
getUsuarioByIdR :: UsuarioId -> Handler Value
getUsuarioByIdR usuarioId = do
    ( Usuario n e _ g d ) <- runDB $ get404 usuarioId -- Seleciona da DB sem a senha
    sendStatusJSON ok200 $ object [ "resp" .= Usuario n e "" g d ]  -- Envia o JSON
~~~~

#### Selecionar um usuário por parte do nome
~~~haskell
getBuscarUsuarioR :: Text -> Handler Value
getBuscarUsuarioR pesquisa = do
    lu <- runDB $ selectList [ UsuarioNome %=. pesquisa ] [] -- Seleciona da DB com o operador like os mais próximos 
    listaUsuario <- return $ Prelude.map (\( Entity i (Usuario n e _ g d) ) -> Entity i $ Usuario n e "" g d ) lu -- Retira a senha do retorno
    sendStatusJSON ok200 $ object [ "resp" .= listaUsuario ] -- Envia o JSON
~~~~

#### Cadastra um usuário
~~~haskell
postUsuarioR :: Handler Value
postUsuarioR = do
    usuario   <- requireJsonBody :: Handler Usuario -- Recebe um JSON
    usuarioId <- runDB $ insert usuario -- Cadastra o usuário na DB
    sendStatusJSON created201 $ object [ "resp" .= ( fromSqlKey usuarioId ) ] -- Inserido com sucesso e retorna a Chave
~~~~

#### Altera um usuário 
~~~haskell
patchUsuarioByIdR :: UsuarioId -> Handler Value -- Recebe o Id do usuário
patchUsuarioByIdR usuarioId = do
    (nome, genero, dataNascimento) <- requireJsonBody :: Handler ( Text, GeneroId, Day ) -- Recebe JSON contendo uma tupla 
    runDB $ update usuarioId [ UsuarioNome           =. nome
                             , UsuarioGenero         =. genero
                             , UsuarioDataNascimento =. dataNascimento
                             ] -- Efetua o update nos campos
    sendStatusJSON noContent204 emptyObject
~~~~

# Funções do livro

#### Selecionar um livro por ID
~~~haskell
getLivroByIdR :: LivroId -> Handler Value
getLivroByIdR livroId = do
    livro <- runDB $ get404 livroId
    
    listaAutorLivro <- runDB $ selectList [ AutorLivroLivro ==. livroId ] [] -- Seleciona da tabela AutorLivro os Id's dos autores relacionados ao livro 
    listaAutorId    <- return $ Prelude.map ( autorLivroAutor.entityVal ) listaAutorLivro -- retorna uma lista com os Id's dos autores
    
    listaCategoriaLivro <- runDB $ selectList [ CategoriaLivroLivro ==. livroId ] [] -- Seleciona da tabela CategoriaLivro os Id's das categorias relacionados ao livro 
    listaCategoriaId    <- return $ Prelude.map ( categoriaLivroCategoria.entityVal ) listaCategoriaLivro -- retorna uma lista com os Id's das categorias
    
    sendStatusJSON ok200 $ object [ "resp" .= ( livro, listaAutorId, listaCategoriaId ) ]
~~~~

#### Selecionar um livro por parte do nome
~~~haskell
getBuscarLivroIdR :: Text -> Handler Value
getBuscarLivroIdR pesquisa = do
    listaLivro   <- runDB $ selectList [ LivroTitulo %=. pesquisa] [] -- Seleciona da DB com o operador like os mais próximos 
    listaLivroId <- return $ Prelude.map entityKey listaLivro
    sendStatusJSON ok200 $ object [ "resp" .= listaLivroId ]
~~~~


#### Seleciona a quantidade de unidades alugadas pelo ID do livro
~~~haskell
getQtLivroAlugadoByIdR :: LivroId -> Handler Value
getQtLivroAlugadoByIdR livroId = do
    qtAluguelAbertoLivro <- runDB $ DB.count [ AluguelLivro     ==. livroId
                                             , AluguelDevolucao ==. Nothing
                                             ] -- liv
    sendStatusJSON ok200 $ object [ "resp" .= qtAluguelAbertoLivro ]
~~~~

#### Seleciona os livros por categoria 
~~~haskell
getBuscarLivroIdByCategoriaIdR :: CategoriaId -> Handler Value
getBuscarLivroIdByCategoriaIdR categoriaId = do
    listaCategoriaLivro <- runDB $ selectList [ CategoriaLivroCategoria ==. categoriaId ] [] -- Seleciona da tabela CategoriaLivro os Id's das categorias relacionados ao livro 
    listaLivroId <- return $ Prelude.map ( categoriaLivroLivro.entityVal ) listaCategoriaLivro -- Retorna uma lista com os Id's das categorias
    sendStatusJSON ok200 $ object [ "resp" .= listaLivroId ]
~~~~

#### Seleciona os livros por autor 
~~~haskell
getBuscarLivroIdByAutorIdR :: AutorId -> Handler Value
getBuscarLivroIdByAutorIdR autorId = do
    listaAutorLivro <- runDB $ selectList [ AutorLivroAutor ==. autorId ] [] -- -- Seleciona da tabela AutorLivro os Id's dos autores relacionados ao livro 
    listaLivroId <- return $ Prelude.map ( categoriaLivroLivro.entityVal ) listaCategoriaLivro -- Retorna uma lista com os Id's dos autores
    listaLivroId <- return $ Prelude.map ( autorLivroLivro.entityVal ) listaAutorLivro
    sendStatusJSON ok200 $ object [ "resp" .= listaLivroId ]
~~~~

#### cadastra o livro 
~~~haskell
postLivroR :: Handler Value
postLivroR = do
    (livro, imagem, listaCategoria, listaAutor) <- requireJsonBody :: Handler ( Livro
                                                                              , Text
                                                                              , [ CategoriaId ]
                                                                              , [ AutorId ]
                                                                              ) -- Recebe um JSON contendo uma tupla com os dados do livro, imagem, lista de categorias e lista de autores
    livroId <- runDB $ insert livro -- cadastra o livro no Banco
    mapM_ ( \categoriaLivro -> runDB $ insert $ CategoriaLivro categoriaLivro livroId ) listaCategoria -- Efetua a relação do livro com as categorias
    mapM_ ( \autorLivro -> runDB $ insert $ AutorLivro autorLivro livroId ) listaAutor  -- Efetua a relação do livro com os autores
    liftIO $ writeToServer imagem (show $ fromSqlKey livroId) -- insere a imagem no servidor na parta static e o nome do arquivo é o id do livro
    sendStatusJSON created201 $ object [ "resp" .= ( fromSqlKey livroId ) ]
~~~~

#### Altera os dados do livro 
~~~haskell
putLivroByIdR :: LivroId -> Handler Value -- Recebe o Id do livro
putLivroByIdR livroId = do
    livro <- requireJsonBody :: Handler Livro -- Recebe um JSON com os dados do livro
    runDB $ DB.replace livroId livro -- altera os dados do banco
    sendStatusJSON noContent204 emptyObject
~~~~

#### Deleta um livro 
~~~haskell
deleteLivroByIdR :: LivroId -> Handler Value -- Recebe o Id do livro a ser excluido
deleteLivroByIdR livroId = do
    runDB $ delete livroId -- deleta o livro do banco, mas se houver relação com aluguel o livro não poderá ser excluido
    sendStatusJSON noContent204 emptyObject
~~~~

#### Cadastrar um aluguel
~~~haskell
postAluguelR :: Handler Value
postAluguelR = do
    aluguel   <- requireJsonBody :: Handler Aluguel -- Recebe um JSON com os dados do aluguel
    aluguelId <- runDB $ insert aluguel -- insere no banco o aluguel
    sendStatusJSON created201 $ object [ "resp" .= aluguelId ]
~~~~

#### Confirmar a retirada do livro
~~~haskell
patchSaidaAluguelByIdR :: AluguelId -> Handler Value
patchSaidaAluguelByIdR aluguelId = do
    runDB $ update aluguelId [ AluguelSaida =. True ] -- Altera o status de saída para confirmar a retirada pelo usuário
    sendStatusJSON noContent204 emptyObject
~~~~ 

#### Confirmar a devolução do livro
~~~haskell
patchDevolucaoAluguelByIdR :: AluguelId -> Handler Value
patchDevolucaoAluguelByIdR aluguelId = do
    currentDate <- liftIO $ getCurrentTime -- Retorna a data atual
    runDB $ update aluguelId [ AluguelDevolucao =. ( Just $ utctDay currentDate ) ] --altera a data de vazio para o dia em que o livro foi devolvido
    sendStatusJSON noContent204 emptyObject
~~~~

#### Efeturar a renovação do aluguel
~~~haskell
patchRenovacaoAluguelByIdR :: AluguelId -> Handler Value
patchRenovacaoAluguelByIdR aluguelId = do
    aluguel <- runDB $ get404 aluguelId 
    runDB $ update aluguelId [ AluguelRenovacao =. True
                             , AluguelPrevisao  =. ( addDays 15 $ aluguelPrevisao aluguel)
                             ] -- Altera para mais 15 dias a data de previsão de devolução do livro, assim renovando o aluguel
    sendStatusJSON noContent204 emptyObject
~~~~

#### Busca os aluguéis de um usuário
~~~haskell
getBuscarAluguelByUsuarioIdR :: UsuarioId -> Handler Value
getBuscarAluguelByUsuarioIdR usuarioId = do
    listaAluguelUsuario <- runDB $ selectList [ AluguelUsuario ==. usuarioId ]
                                              [ Desc AluguelRetirada ] -- Retorna a lista dos aluguéis de um usuário
    sendStatusJSON ok200 $ object [ "resp" .= listaAluguelUsuario ]
~~~~

#### Busca todos os aluguéis de um usuário
~~~haskell
getBuscarAluguelByLivroIdR :: LivroId -> Handler Value
getBuscarAluguelByLivroIdR livroid = do
    listaAluguelLivro <- runDB $ selectList [ AluguelLivro ==. livroid ]
                                            [ Desc AluguelRetirada ] -- Retorna a lista dos aluguéis de um livro
    sendStatusJSON ok200 $ object [ "resp" .= listaAluguelLivro ]
~~~~

#### Busca todos os aluguéis efetuados em um período de tempo
~~~haskell
getBuscarAluguelByDateR :: Day -> Day -> Handler Value -- data de início e fim da pesquisa
getBuscarAluguelByDateR inicio fim = do
    listaAluguelByDate <- runDB $ selectList [ AluguelRetirada >=. inicio
                                             , AluguelRetirada <=. fim
                                             ] [] -- Retorna a lista dos aluguéis nesse período
    sendStatusJSON ok200 $ object [ "resp" .= listaAluguelByDate ]
~~~~

#### Busca todos os aluguéis efetuados por um usuario em período de tempo
~~~haskell
getBuscarAluguelByUsuarioIdDateR :: UsuarioId -> Day -> Day -> Handler Value -- data de início e fim da pesquisa e o usuário
getBuscarAluguelByUsuarioIdDateR usuarioId inicio fim = do
    listaAluguelUsuarioByDate <- runDB $ selectList [ AluguelRetirada >=. inicio
                                                    , AluguelRetirada <=. fim
                                                    , AluguelUsuario  ==. usuarioId
                                                    ] [] -- Retorna a lista dos aluguéis do usuário no período
    sendStatusJSON ok200 $ object [ "resp" .= listaAluguelUsuarioByDate ]
~~~~

#### Busca todos os aluguéis de um livro efetuados em período de tempo
~~~haskell
getBuscarAluguelByLivroIdDateR :: LivroId -> Day -> Day -> Handler Value -- data de início e fim da pesquisa e o livro
getBuscarAluguelByLivroIdDateR livroid inicio fim = do
    listaAluguelLivroByDate <- runDB $ selectList [ AluguelRetirada >=. inicio
                                                  , AluguelRetirada <=. fim
                                                  , AluguelLivro    ==. livroid
                                                  ] [] -- Retorna a lista dos aluguéis de um livro no período
    sendStatusJSON ok200 $ object [ "resp" .= listaAluguelLivroByDate ]
~~~~


    
#### Selecionar Autores

~~~haskell
getAutorByIdR :: AutorId -> Handler Value -- Esta função recebe um Id do autor
getAutorByIdR autorId = do                -- e retor um JSON com suas informações
    autor <- runDB $ get404 autorId                   -- executa o select no banco 
    sendStatusJSON ok200 $ object [ "resp" .= autor ] -- envia o JSON
~~~~

