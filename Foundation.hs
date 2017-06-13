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