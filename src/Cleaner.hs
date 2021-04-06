module Cleaner where

import qualified Data.Text as T
import qualified Data.Text.IO as TIO
import Data.Kanji
import Data.List
import Data.Maybe

lineCheck :: T.Text -> Bool
lineCheck line =
       any (flip T.isInfixOf line) ["#ama", "pcm "]
    || T.any (\x -> isKanji x || isHiragana x || isKatakana x) line

replacePcm :: T.Text -> T.Text
replacePcm line =
    if T.isInfixOf "pcm" line
    then T.dropEnd 1 (T.replace "pcm " "[" line) <> ".ogg];"
    else line

clean :: FilePath -> IO ()
clean fileName = do
    file <- T.lines <$> TIO.readFile fileName

    let output = T.concat $ map ((<> "\r\n") . replacePcm) $ filter lineCheck file

    TIO.writeFile (fileName ++ ".output") output
