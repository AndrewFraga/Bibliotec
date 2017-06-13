{-# OPTIONS_GHC -fno-warn-orphans #-}
module Application where

import Foundation
import Yesod.Core

import Aluguel
import Autor
import Categoria
import Editora
import Livro
import Login
import Usuario

mkYesodDispatch "App" resourcesApp
