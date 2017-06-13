module Funcs where

import Yesod
import Foundation
import Data.Text as T

data HttpMethod = OPTIONS | GET | POST | PUT | PATCH | DELETE deriving Show

(%=.) :: EntityField record Text -> Text -> Filter record
(%=.) campo valor = Filter campo ( Left $ T.concat ["%",valor,"%"] )
                                 ( BackendSpecificFilter "ILIKE" )

anyOriginIn :: [HttpMethod] -> Handler ()
anyOriginIn methods = do
    addHeader "Access-Control-Allow-Origin" "*"
    addHeader "Access-Control-Allow-Methods" $ T.intercalate ", " $ Prelude.map (pack.show) methods