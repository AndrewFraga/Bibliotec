import Application () -- for YesodDispatch instance
import Foundation
import Yesod.Core
import Yesod.Static
import Control.Monad.Logger (runStdoutLoggingT)
import Database.Persist.Postgresql
import Data.Text
import Data.Text.Encoding

connStr :: Text
connStr = --"dbname=bibliotec host=localhost user=postgres password=root port=5432"
    "dbname=decjj5nqjumfnd host=ec2-54-221-244-196.compute-1.amazonaws.com user=wmxeosohimzhht password=9b26c2103f3eee0fbe303f4ff5cc05b639679a8ac43c9b6a70cf72b917b7086b port=5432"

main :: IO ()
main = runStdoutLoggingT $ withPostgresqlPool (encodeUtf8 connStr) 10 $ \pool -> liftIO $ do
    runSqlPersistMPool (runMigration migrateAll) pool
    capasLivro <- static "static"
    warp 8080 (App capasLivro pool)