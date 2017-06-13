module Imagem where

import Data.Text
import System.FilePath
import Data.ByteString as BS
import Data.Text.Encoding as TE
import Data.ByteString.Base64 as BS

writeToServer :: Text -> String -> IO ()
writeToServer file imgName = do
    case BS.decode $ TE.encodeUtf8 file of
        Left _ -> undefined
        Right img -> BS.writeFile (uploadDirectory </> (imgName ++ ".jpg")) img

uploadDirectory :: FilePath
uploadDirectory = "static"